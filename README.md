# Expendio Bimbo · Sitio de pedidos

Sitio web estático para ver los productos disponibles y hacer pedidos para recoger en tienda o entrega a domicilio. Los pedidos llegan por WhatsApp con folio. Productos, existencias y pedidos se guardan en Supabase.

- `index.html`: tienda.
- `admin.html`: panel de administración (productos, existencias, pedidos).

## Configurar la base de datos (una sola vez)

1. Crea un proyecto gratis en [supabase.com](https://supabase.com).
2. **SQL Editor** → pega y corre `supabase/schema.sql`, después `supabase/seed.sql` (inventario inicial) y `supabase/imagenes.sql` (fotos).
3. **Authentication → Users → Add user**: tu correo y una contraseña (marca *Auto Confirm User*).
4. **Authentication → Sign In / Providers**: desactiva *Allow new users to sign up*.
5. En **SQL Editor** dale permiso de administrador a tu usuario:
   ```sql
   insert into public.admins select id from auth.users where email = 'TU_CORREO';
   ```
6. **Project Settings → API**: copia la URL del proyecto y la llave `anon` / `publishable` en `config.js`. Nunca uses la llave `service_role` / `secret`.

## Uso diario (`admin.html`)

- **Llegó mercancía**: escribe las piezas y pulsa *+ Llegó mercancía*.
- **Precio, existencia, promo** (ej. 2 piezas por $50): edita y pulsa *Guardar*.
- **Producto nuevo**: *+ Producto nuevo*. Para quitar uno de la tienda, desmarca *Visible en la tienda*.
- **Fotos**: en *Editar* pega la dirección `https` de la foto. Mientras esté marcada *Foto pendiente de revisión* (o si no carga), la tienda muestra el dibujo. Confirma la nota y desmárcala para publicarla.
- **Pedidos**: la existencia se descuenta sola cuando el cliente envía el pedido. *Cancelar* regresa las piezas; *Marcar entregado* lo cierra.

Las ventas de mostrador se descuentan a mano (cambia la existencia).

## Datos de la tienda

**`CONFIG`**, al inicio del `<script>` en `index.html`: nombre, WhatsApp (formato `521` + 10 dígitos), dirección, Google Maps, Facebook, enlace de pago, envío y horario. Si cambias `envio` o `envioGratisDesde`, cambia también `c_envio` / `c_envio_gratis` en `supabase/schema.sql` y vuelve a correrlo.

## Logo

Sube el archivo oficial del logo que te proporcionó Bimbo como `assets/logo.png` (fondo transparente, unos 200 px de alto). Si el archivo no existe, la página solo muestra el nombre.

## Publicar con GitHub Pages

1. **Settings → Pages**.
2. En *Source* elige **Deploy from a branch**, rama **main**, carpeta **/ (root)** → **Save**.
3. En 1–2 minutos queda en `https://<tu-usuario>.github.io/<nombre-del-repo>/`.

### Dominio propio (opcional)

Compra un dominio (por ejemplo `expendiobimbo-tucolonia.mx`) en Namecheap, GoDaddy, Cloudflare o Neubox. Luego, en **Settings → Pages → Custom domain**, escríbelo y sigue las instrucciones de DNS que muestra GitHub. Activa **Enforce HTTPS**.
