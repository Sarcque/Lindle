const rows = [
  {
    n: '01',
    title: 'Pick the desktop you know',
    text: 'The Welcome Center asks which desktop feels like home. Windows-like gives you a bottom taskbar and start menu; Mac-like gives you a top bar and a dock. Both run on KDE Plasma 6, so they are fast and fully themed.',
    img: 'start-menu.webp',
    alt: 'The Lindle start menu',
  },
  {
    n: '02',
    title: 'Office and photo apps, built in',
    text: 'The Storytold Craft apps are part of the OS and pinned from the first boot: WordCraft for documents, GridCraft for spreadsheets, DeckCraft for presentations and PhotoCraft for photos. ONLYOFFICE is installed as well for the most complex Office files.',
    img: 'gridcraft.webp',
    alt: 'GridCraft, the spreadsheet app',
  },
  {
    n: '03',
    title: 'One app store for everything else',
    text: 'GIMP, Inkscape, Krita, Firefox, Thunderbird, VLC and Bottles (for Windows apps) are installed on first boot. Anything else is one click away in the store, powered by Flathub.',
    img: 'app-store.webp',
    alt: 'The Lindle app store',
  },
  {
    n: '04',
    title: 'Settings that make sense',
    text: 'A clean System Settings app, light and dark themes, and sensible defaults. Colors, type and spacing all come from one design system, checked for contrast.',
    img: 'settings.webp',
    alt: 'Lindle System Settings',
  },
];

const specs = [
  ['Atomic updates', 'The whole OS updates as one image in the background. Roll back from the boot menu.'],
  ['Codecs included', 'Video and music play out of the box.'],
  ['Metric-compatible fonts', 'Carlito and Caladea match Calibri and Cambria.'],
  ['Built on', 'Fedora KDE Plasma 6, Universal Blue and bootc.'],
  ['Open source', 'Code under Apache-2.0, artwork under CC BY-SA 4.0.'],
  ['Self-updating apps', 'Flatpak apps update quietly in the background.'],
];

module.exports = {
  path: '/features',
  title: 'Features',
  description: 'Familiar layouts, built-in office and photo apps, an app store and updates that undo themselves.',
  body: `
    <section class="page-hero">
      <div class="grain"></div>
      <div class="wrap">
        <p class="mono tag">Features</p>
        <h1>Made for the move,<br>not for the manual.</h1>
        <p class="lead">Lindle takes care of the parts of Linux that usually need a terminal, so you can get on with your work.</p>
      </div>
    </section>

${rows
  .map(
    (r, i) => `
    <section class="wrap feature${i % 2 ? ' flip' : ''}" data-reveal>
      <div class="feature-copy">
        <p class="mono num">${r.n}</p>
        <h2>${r.title}</h2>
        <p>${r.text}</p>
      </div>
      <div class="window small">
        <div class="window-bar"><i></i><i></i><i></i></div>
        <img src="/img/${r.img}" alt="${r.alt}" width="1280" height="800" loading="lazy">
      </div>
    </section>`,
  )
  .join('')}

    <section class="wrap section">
      <h2 class="section-head-h" data-reveal>Under the hood</h2>
      <dl class="specs" data-reveal>
${specs.map(([t, d]) => `        <div><dt>${t}</dt><dd>${d}</dd></div>`).join('\n')}
      </dl>
    </section>
`,
};
