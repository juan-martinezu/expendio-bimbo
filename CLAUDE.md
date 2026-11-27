# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Static order site for a Bimbo expendio (Mexican bread shop). `index.html` (store) and `admin.html` (admin panel), both with inline CSS + JS, no framework, no build. Data lives in Supabase (`supabase-js` from jsDelivr). Customers build a cart; submitting creates the order in the database (decrementing stock) and then offers a prefilled `wa.me` link with the folio. UI text is Spanish (es-MX); keep it that way.

## Running / deploying

- Run locally: open `index.html` in a browser, or serve the folder (e.g. `python -m http.server`) so `assets/logo.png` resolves.
- Deploy: GitHub Pages from `main`, root folder (`.nojekyll` present). Pushing to `main` publishes in 1–2 min. The owner often edits `index.html` directly in the GitHub web editor.

## Architecture

- `config.js`: `window.SUPABASE={url,anonKey}` (public key only). Empty = store shows "catálogo no disponible".
- `icons.js`: `window.ICONS` + `window.svg(key)`, shared by both pages; unknown key falls back to `loaf`.
- `supabase/schema.sql` (re-runnable) holds tables, RLS and all write logic; `supabase/seed.sql` loads initial inventory only into an empty table. Apply by pasting into the Supabase SQL Editor.
  - Admin = row in `public.admins` (`is_admin()`), not merely authenticated.
  - Anon can only read active products and call `create_order`, which locks rows, validates stock, prices server-side, is idempotent by `cliente.clave`, and raises Spanish messages (code `P0001`) shown to the customer.
  - Order state changes only through `cancel_order` (restores stock) / `deliver_order`; restocking through `add_stock`.
- Duplicated business rules, change together: promo price formula (`lineTotal` in `index.html` and `create_order`); delivery fee (`CONFIG.envio*` and `c_envio*` in SQL).
- `index.html`: `CONFIG` at top of `<script>`; `loadProducts()` maps DB rows to `{id,n,b,c,m,p,pc,pp,s,i,col}` and clamps the cart to stock. Script wrapped in `{ ... }`; the Supabase client is `sb` (`#db` is an element id).
- `horario` is positional: index 0 = Mon–Fri, 1 = Sat, 2 = Sun. `todayHours()` and `slots()` depend on that order.
- Rendering via `innerHTML`; DB/user/config strings must go through `esc()` (admin shows customer-supplied text).
- `<style>`: tokens on `:root` with `light-dark()`; breakpoints 860px and 600px in the store (`.cats` sticky offset must match top bar height).
- Cart in `localStorage` key `expendio-cart`; last customer data in `expendio-cart-cliente`.

## Notes

- `assets/logo.png` is the shop logo (256×256, transparent background); the `<img>` removes itself on error and only the name shows.
- Current `CONFIG` WhatsApp/address are sample data.
- Footer disclaimer about Bimbo trademarks should stay.
