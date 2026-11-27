# Expendio Bimbo · Sitio de pedidos

Sitio web estático (un solo `index.html`) para ver los productos disponibles y hacer pedidos para recoger en tienda o entrega a domicilio. Los pedidos llegan por WhatsApp con folio.

## Cómo editar

Todo lo que cambia seguido está al inicio del `<script>` en `index.html`:

- **`CONFIG`**: nombre, WhatsApp (formato `521` + 10 dígitos), dirección, enlace de Google Maps, Facebook, enlace de pago (Mercado Pago / Clip), costo de envío y horario.
- **`PRODUCTS`**: lista de productos. `p` = precio, `s` = piezas en existencia (`0` = agotado), `c` = categoría.

Desde GitHub: abre `index.html` → ícono de lápiz → edita → **Commit changes**. La página se actualiza sola en 1–2 minutos.

## Logo

Sube el archivo oficial del logo que te proporcionó Bimbo como `assets/logo.png` (fondo transparente, unos 200 px de alto). Si el archivo no existe, la página solo muestra el nombre.

## Publicar con GitHub Pages

1. **Settings → Pages**.
2. En *Source* elige **Deploy from a branch**, rama **main**, carpeta **/ (root)** → **Save**.
3. En 1–2 minutos queda en `https://<tu-usuario>.github.io/<nombre-del-repo>/`.

### Dominio propio (opcional)

Compra un dominio (por ejemplo `expendiobimbo-tucolonia.mx`) en Namecheap, GoDaddy, Cloudflare o Neubox. Luego, en **Settings → Pages → Custom domain**, escríbelo y sigue las instrucciones de DNS que muestra GitHub. Activa **Enforce HTTPS**.
