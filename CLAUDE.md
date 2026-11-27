# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Static order site for a Bimbo expendio (Mexican bread shop). Everything lives in one file, `index.html` (inline CSS + inline JS, no framework, no build, no dependencies, no tests). Customers browse stock, build a cart, and the order is sent to the shop via a prefilled WhatsApp link (`wa.me`) with a folio. No backend: nothing is stored server-side. UI text is Spanish (es-MX); keep it that way.

## Running / deploying

- Run locally: open `index.html` in a browser, or serve the folder (e.g. `python -m http.server`) so `assets/logo.png` resolves.
- Deploy: GitHub Pages from `main`, root folder (`.nojekyll` present). Pushing to `main` publishes in 1–2 min. The owner often edits `index.html` directly in the GitHub web editor.

## Architecture (index.html)

- `<style>`: design tokens on `:root` using `light-dark()` for light/dark; brand blue `--brand` + red `--red`. Breakpoints at 860px and 600px (mobile has 2-column grid, sticky top bar on one line, `.cats` sticky offset must match top bar height).
- `<script>` is wrapped in a block `{ ... }` to avoid globals. Top of script holds the owner-editable data:
  - `CONFIG`: store name, `whatsapp` (`521` + 10 digits), address, maps/Facebook URLs, `linkPago` (empty = payment link sent via WhatsApp), `envio`/`envioGratisDesde` delivery fee rules, `zona`, `horario`.
  - `PRODUCTS`: `{id, n:name, b:brand, c:category, m:size, p:price MXN, s:stock (0 = agotado), i:icon key, col:card bg}`. Category chips are derived from `c`.
- `horario` is positional: index 0 = Mon–Fri, 1 = Sat, 2 = Sun. `todayHours()` and `slots()` depend on that order.
- `ICONS` holds inline SVG per product icon key; unknown key falls back to `loaf`.
- Rendering is full re-render via `innerHTML` (`drawCats`, `drawGrid`, `drawCart`); user/config strings interpolated into HTML must go through `esc()`.
- Clicks are delegated on `document` via `data-inc`, `data-dec`, `data-c` attributes.
- Cart persisted in `localStorage` key `expendio-cart`; last customer data in `expendio-cart-cliente`. All storage access is wrapped in try/catch.
- Quantity is capped at `p.s` but stock is static: orders never decrement it; owner updates `PRODUCTS` manually.
- Submit handler validates, generates folio `P-` + base36 timestamp suffix, builds the WhatsApp message text (`lastMsg`), then swaps `#cartView` for `#doneView`.

## Notes

- `assets/logo.png` is the shop logo (256×256, transparent background); the `<img>` removes itself on error and only the name shows.
- Current `CONFIG` WhatsApp/address and product prices/stock are sample data (see `#sampleNote` on the page).
- Footer disclaimer about Bimbo trademarks should stay.
