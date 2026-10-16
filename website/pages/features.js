const line = (t) => `<span class="line"><span>${t}</span></span>`;

const rows = [
  {
    n: '01',
    title: 'Choose the desktop you know',
    text: 'The Welcome Center asks which desktop feels like home. Windows-like gives you a bottom taskbar and a start menu. Mac-like gives you a top bar and a dock. Both are KDE Plasma 6 underneath, so they are quick and fully themed.',
    img: 'start-menu.webp',
    alt: 'The Lindle start menu',
  },
  {
    n: '02',
    title: 'Office and photo apps, built in',
    text: 'WordCraft, GridCraft, DeckCraft and PhotoCraft are part of the OS and pinned from the first boot. ONLYOFFICE is installed alongside for the most complicated Office files.',
    img: 'gridcraft.webp',
    alt: 'GridCraft, the spreadsheet app',
  },
  {
    n: '03',
    title: 'One store for the rest',
    text: 'GIMP, Inkscape, Krita, Firefox, Thunderbird, VLC and Bottles (for Windows apps) install on first boot. Anything else comes from the app store, which only talks to Flathub.',
    img: 'app-store.webp',
    alt: 'The Lindle app store',
  },
  {
    n: '04',
    title: 'Settings that make sense',
    text: 'A clean System Settings app with light and dark themes and sensible defaults. Colors, type and spacing come from one design system and are checked for contrast in CI.',
    img: 'settings.webp',
    alt: 'Lindle System Settings',
  },
];

module.exports = {
  path: '/features',
  title: 'Features',
  bodyClass: 'sub',
  description: 'Familiar layouts, built-in office and photo apps, an app store and updates that undo themselves.',
  body: `
    <section class="sub-hero">
      <div class="wrap">
        <p class="mono kicker rv">Features</p>
        <h1 class="display">${line('Made for the move,')}${line('not for the <em>manual.</em>')}</h1>
        <p class="lead rv" style="--d:3">Lindle takes care of the parts of Linux that usually need a terminal, so you can get on with your work.</p>
      </div>
    </section>
${rows
  .map(
    (r, i) => `
    <section class="wrap feature${i % 2 ? ' flip' : ''}">
      <div class="feature-copy rv">
        <p class="mono num">${r.n} / 04</p>
        <h2>${r.title}</h2>
        <p>${r.text}</p>
      </div>
      <figure class="frame rv" style="--d:2"><img src="/img/${r.img}" alt="${r.alt}" width="1280" height="800" loading="lazy"></figure>
    </section>`,
  )
  .join('')}

    <section class="closer">
      <div class="wrap">
        <p class="mono kicker rv">Ready?</p>
        <a class="closer-link rv" href="/download"><span>Get Lindle</span><span class="arrow" aria-hidden="true">→</span></a>
      </div>
    </section>
`,
};
