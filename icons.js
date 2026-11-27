/* Iconos SVG de producto, compartidos por index.html y admin.html */
{
const S='stroke="#2b1a10" stroke-width="3" stroke-linejoin="round"';
const ICONS={
 loaf:`<rect x="20" y="22" width="80" height="78" rx="18" fill="#f7fbff" ${S}/><rect x="28" y="36" width="64" height="44" rx="12" fill="#e4a14d"/><rect x="34" y="84" width="52" height="10" rx="5" fill="#d8372a"/>`,
 toast:`<rect x="26" y="30" width="58" height="62" rx="14" fill="#c9792f" ${S}/><rect x="38" y="24" width="58" height="62" rx="14" fill="#e9a955" ${S}/><rect x="48" y="36" width="38" height="38" rx="8" fill="#f7d79a"/>`,
 bun:`<ellipse cx="60" cy="88" rx="44" ry="8" fill="#000" opacity=".12"/><path d="M16 84c0-30 20-46 44-46s44 16 44 46z" fill="#e39a3b" ${S}/><path d="M42 58l3 4M60 52v5M78 58l-3 4" stroke="#fff4dc" stroke-width="5" stroke-linecap="round"/>`,
 roll:`<circle cx="60" cy="62" r="38" fill="#d98b3a" ${S}/><path d="M60 62m-6 0a6 6 0 1 1 12 0a14 14 0 1 1-28 0a22 22 0 1 1 44 0a30 30 0 1 1-58 4" fill="none" stroke="#7a3f14" stroke-width="5"/>`,
 concha:`<path d="M16 82c0-30 20-48 44-48s44 18 44 48z" fill="#f4e2c2" ${S}/><path d="M30 70q30-30 60 0M38 54q22-14 44 0M60 36v44" stroke="#c99a5a" stroke-width="4" fill="none"/><rect x="14" y="80" width="92" height="10" rx="5" fill="#d98b3a" ${S}/>`,
 muffin:`<path d="M32 66h56l-8 32H40z" fill="#d8372a" ${S}/><path d="M26 68c0-22 14-36 34-36s34 14 34 36z" fill="#f2b25a" ${S}/>`,
 loafcake:`<path d="M18 52h84l-6 42H24z" fill="#b8661f" ${S}/><path d="M16 54c10-22 78-22 88 0" fill="#e4a14d" ${S}/><circle cx="44" cy="44" r="4" fill="#5a2c12"/><circle cx="62" cy="40" r="4" fill="#5a2c12"/><circle cx="78" cy="45" r="4" fill="#5a2c12"/>`,
 cake:`<rect x="18" y="40" width="84" height="46" rx="14" fill="#5a2c12" ${S}/><path d="M24 56q9 8 18 0t18 0 18 0 18 0" stroke="#fff" stroke-width="5" fill="none"/><circle cx="40" cy="48" r="4" fill="#ff6a55"/><circle cx="74" cy="47" r="4" fill="#ffc93c"/>`,
 bar:`<rect x="16" y="42" width="88" height="38" rx="10" fill="#e4a14d" ${S}/><rect x="26" y="52" width="68" height="18" rx="6" fill="#e0415a"/>`,
 cookie:`<circle cx="60" cy="60" r="38" fill="#e8b878" ${S}/><circle cx="60" cy="60" r="26" fill="none" stroke="#c99a5a" stroke-width="3" stroke-dasharray="4 6"/>`,
 tortilla:`<ellipse cx="60" cy="68" rx="46" ry="22" fill="#f4e2c2" ${S}/><ellipse cx="60" cy="58" rx="46" ry="22" fill="#fbf0dc" ${S}/><circle cx="44" cy="54" r="3" fill="#d6b27a"/><circle cx="70" cy="62" r="4" fill="#d6b27a"/>`,
 donut:`<circle cx="60" cy="60" r="38" fill="#e39a3b" ${S}/><circle cx="60" cy="60" r="12" fill="var(--card)" ${S}/><path d="M34 46l3 2M80 40l2 3M84 72l-3 2M40 80l3-2" stroke="#fff" stroke-width="4" stroke-linecap="round"/>`,
 tostada:`<circle cx="60" cy="62" r="40" fill="#e9b34f" ${S}/><circle cx="60" cy="62" r="30" fill="none" stroke="#c98a2a" stroke-width="3"/>`
};
const svg=k=>`<svg viewBox="0 0 120 120" aria-hidden="true">${ICONS[k]||ICONS.loaf}</svg>`;
window.ICONS=ICONS;window.svg=svg;
}
