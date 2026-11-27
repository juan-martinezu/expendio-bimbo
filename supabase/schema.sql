-- Expendio Bimbo · esquema. Pegar completo en Supabase → SQL Editor → Run.
-- Se puede volver a correr sin borrar datos.

create table if not exists public.products (
  id           bigint generated always as identity primary key,
  nombre       text not null check (length(trim(nombre)) > 0),
  marca        text not null default 'Bimbo',
  categoria    text not null default 'Otros',
  medida       text not null default '',
  precio       numeric(10,2) not null check (precio >= 0),
  promo_cant   int check (promo_cant >= 2),
  promo_precio numeric(10,2) check (promo_precio >= 0),
  stock        int not null default 0 check (stock >= 0),
  icono        text not null default 'loaf',
  color        text not null default '#e8f1ff',
  activo       boolean not null default true,
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now(),
  check ((promo_cant is null) = (promo_precio is null))
);

create table if not exists public.orders (
  id         bigint generated always as identity primary key,
  folio      text unique,
  clave      uuid unique,            -- evita pedidos duplicados al reintentar
  cliente    text not null,
  telefono   text not null,
  modo       text not null check (modo in ('tienda','domicilio')),
  direccion  text not null default '',
  hora       text not null default '',
  pago       text not null default '',
  notas      text not null default '',
  subtotal   numeric(10,2) not null default 0,
  envio      numeric(10,2) not null default 0,
  total      numeric(10,2) not null default 0,
  estado     text not null default 'pendiente' check (estado in ('pendiente','entregado','cancelado')),
  created_at timestamptz not null default now()
);

create table if not exists public.order_items (
  id          bigint generated always as identity primary key,
  order_id    bigint not null references public.orders(id) on delete cascade,
  product_id  bigint not null references public.products(id),
  nombre      text not null,
  marca       text not null,
  cantidad    int not null check (cantidad > 0),
  precio_unit numeric(10,2) not null,
  importe     numeric(10,2) not null
);

-- Quién es administrador (ver README para agregar tu usuario).
create table if not exists public.admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);

create or replace function public.is_admin() returns boolean
language sql stable security definer set search_path = public as
$$ select exists (select 1 from admins where user_id = auth.uid()) $$;

create or replace function public.touch_updated_at() returns trigger
language plpgsql as
$$ begin new.updated_at := now(); return new; end $$;
drop trigger if exists products_touch on public.products;
create trigger products_touch before update on public.products
  for each row execute function public.touch_updated_at();

/* ---------- permisos ---------- */
alter table public.products    enable row level security;
alter table public.orders      enable row level security;
alter table public.order_items enable row level security;
alter table public.admins      enable row level security;   -- sin políticas: nadie la lee ni escribe desde la web

drop policy if exists productos_publicos on public.products;
create policy productos_publicos on public.products for select to anon, authenticated using (activo);
drop policy if exists productos_admin_ver on public.products;
create policy productos_admin_ver on public.products for select to authenticated using (public.is_admin());
drop policy if exists productos_admin_alta on public.products;
create policy productos_admin_alta on public.products for insert to authenticated with check (public.is_admin());
drop policy if exists productos_admin_cambio on public.products;
create policy productos_admin_cambio on public.products for update to authenticated using (public.is_admin()) with check (public.is_admin());

-- Pedidos: el admin solo los lee; se crean y cambian únicamente con las funciones de abajo.
drop policy if exists pedidos_admin_ver on public.orders;
create policy pedidos_admin_ver on public.orders for select to authenticated using (public.is_admin());
drop policy if exists partidas_admin_ver on public.order_items;
create policy partidas_admin_ver on public.order_items for select to authenticated using (public.is_admin());

grant select on public.products to anon, authenticated;
grant insert, update on public.products to authenticated;
grant select on public.orders, public.order_items to authenticated;

/* ---------- crear pedido (público) ---------- */
create or replace function public.create_order(cliente jsonb, items jsonb) returns jsonb
language plpgsql security definer set search_path = public as $$
#variable_conflict use_column
declare
  -- Deben coincidir con CONFIG.envio y CONFIG.envioGratisDesde de index.html
  c_envio        constant numeric := 25;
  c_envio_gratis constant numeric := 300;
  v_clave   uuid := nullif(cliente->>'clave','')::uuid;
  v_nombre  text := trim(coalesce(cliente->>'nombre',''));
  v_tel     text := regexp_replace(coalesce(cliente->>'telefono',''), '\D', '', 'g');
  v_modo    text := coalesce(cliente->>'modo','');
  v_dir     text := trim(coalesce(cliente->>'direccion',''));
  v_order   orders%rowtype;
  v_prod    products%rowtype;
  v_item    record;
  v_importe numeric;
  v_sub     numeric := 0;
  v_fee     numeric := 0;
begin
  if v_clave is not null then
    perform pg_advisory_xact_lock(hashtext(v_clave::text));
    select * into v_order from orders o where o.clave = v_clave;
  end if;

  if v_order.id is null then
    if v_nombre = '' or length(v_nombre) > 80 then raise exception 'Escribe tu nombre.'; end if;
    if length(v_tel) < 10 or length(v_tel) > 15 then raise exception 'Escribe un teléfono de 10 dígitos.'; end if;
    if v_modo not in ('tienda','domicilio') then raise exception 'Elige cómo quieres tu pedido.'; end if;
    if v_modo = 'domicilio' and length(v_dir) < 8 then raise exception 'Escribe tu dirección completa.'; end if;
    if jsonb_typeof(items) is distinct from 'array' or jsonb_array_length(items) not between 1 and 100 then
      raise exception 'El pedido está vacío o es demasiado grande.';
    end if;

    insert into orders (clave, cliente, telefono, modo, direccion, hora, pago, notas)
    values (v_clave, v_nombre, v_tel, v_modo,
            case when v_modo = 'domicilio' then left(v_dir, 300) else '' end,
            case when v_modo = 'tienda' then left(coalesce(cliente->>'hora',''), 40) else '' end,
            left(coalesce(cliente->>'pago',''), 60),
            left(trim(coalesce(cliente->>'notas','')), 500))
    returning * into v_order;

    -- Orden por id: dos pedidos simultáneos bloquean filas en el mismo orden.
    for v_item in
      select (e->>'id')::bigint as pid, sum((e->>'cantidad')::int) as cant
      from jsonb_array_elements(items) e
      group by 1 order by 1
    loop
      if v_item.cant is null or v_item.cant < 1 or v_item.cant > 100 then
        raise exception 'Cantidad no válida.';
      end if;
      select * into v_prod from products p where p.id = v_item.pid and p.activo for update;
      if not found then raise exception 'Un producto de tu pedido ya no está disponible.'; end if;
      if v_prod.stock < v_item.cant then
        raise exception 'Solo quedan % de % (%).', v_prod.stock, v_prod.nombre, v_prod.marca;
      end if;

      if v_prod.promo_cant is null then
        v_importe := v_item.cant * v_prod.precio;
      else
        v_importe := (v_item.cant / v_prod.promo_cant) * v_prod.promo_precio
                   + (v_item.cant % v_prod.promo_cant) * v_prod.precio;
      end if;

      update products set stock = stock - v_item.cant where id = v_prod.id;
      insert into order_items (order_id, product_id, nombre, marca, cantidad, precio_unit, importe)
      values (v_order.id, v_prod.id, v_prod.nombre, v_prod.marca, v_item.cant, v_prod.precio, v_importe);
      v_sub := v_sub + v_importe;
    end loop;

    if v_modo = 'domicilio' and v_sub < c_envio_gratis then v_fee := c_envio; end if;

    update orders set folio = 'P-' || lpad(v_order.id::text, 5, '0'),
                      subtotal = v_sub, envio = v_fee, total = v_sub + v_fee
    where id = v_order.id
    returning * into v_order;
  end if;

  return jsonb_build_object(
    'folio', v_order.folio, 'subtotal', v_order.subtotal, 'envio', v_order.envio, 'total', v_order.total,
    'partidas', (select jsonb_agg(jsonb_build_object(
                   'nombre', i.nombre, 'marca', i.marca, 'cantidad', i.cantidad, 'importe', i.importe) order by i.id)
                 from order_items i where i.order_id = v_order.id));
end $$;

/* ---------- acciones de administrador ---------- */
create or replace function public.cancel_order(p_id bigint) returns void
language plpgsql security definer set search_path = public as $$
begin
  if not is_admin() then raise exception 'No autorizado.'; end if;
  update orders set estado = 'cancelado' where id = p_id and estado = 'pendiente';
  if not found then raise exception 'Solo se pueden cancelar pedidos pendientes.'; end if;
  update products p set stock = p.stock + i.cantidad
  from order_items i where i.order_id = p_id and i.product_id = p.id;
end $$;

create or replace function public.deliver_order(p_id bigint) returns void
language plpgsql security definer set search_path = public as $$
begin
  if not is_admin() then raise exception 'No autorizado.'; end if;
  update orders set estado = 'entregado' where id = p_id and estado = 'pendiente';
  if not found then raise exception 'El pedido ya no está pendiente.'; end if;
end $$;

-- Suma (o resta, con número negativo) existencias sin pisar ventas simultáneas.
create or replace function public.add_stock(p_id bigint, p_cant int) returns int
language plpgsql security definer set search_path = public as $$
declare v_stock int;
begin
  if not is_admin() then raise exception 'No autorizado.'; end if;
  update products set stock = stock + p_cant where id = p_id and stock + p_cant >= 0
  returning stock into v_stock;
  if not found then raise exception 'La existencia no puede quedar en negativo.'; end if;
  return v_stock;
end $$;

revoke execute on function public.create_order(jsonb, jsonb), public.cancel_order(bigint),
  public.deliver_order(bigint), public.add_stock(bigint, int), public.is_admin() from public, anon, authenticated;
grant execute on function public.create_order(jsonb, jsonb) to anon, authenticated;
grant execute on function public.cancel_order(bigint), public.deliver_order(bigint),
  public.add_stock(bigint, int), public.is_admin() to authenticated;
