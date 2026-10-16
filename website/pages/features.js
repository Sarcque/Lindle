const features = [
  {
    title: 'Choose the layout that feels like home',
    text: 'The Welcome Center asks which desktop you are used to. Windows-like gives you a bottom taskbar and start menu; Mac-like gives you a top bar and a dock.',
    img: 'layout-mac.webp',
    alt: 'Lindle with the Mac-like layout',
  },
  {
    title: 'Office and photo apps, built in',
    text: 'The Storytold Craft apps are part of the OS and pinned to the taskbar: WordCraft for documents, GridCraft for spreadsheets, DeckCraft for presentations and PhotoCraft for photos.',
    img: 'photocraft.webp',
    alt: 'PhotoCraft, the photo editor',
  },
  {
    title: 'One app store for everything',
    text: 'Find more apps in the app store, powered by Flathub. GIMP, Inkscape, Krita, Firefox, Thunderbird, VLC and Bottles for Windows apps are installed on first boot.',
    img: 'app-store.webp',
    alt: 'The Lindle app store',
  },
];

const list = [
  ['Atomic updates', 'The whole OS updates as one image in the background. If something breaks, pick the previous version at boot.'],
  ['Codecs included', 'Video and music play out of the box, no extra downloads needed.'],
  ['Light and dark', 'Lindle light and dark themes, the Inter typeface and a matching wallpaper, all checked for contrast.'],
  ['Office-friendly fonts', 'Carlito and Caladea are metric-compatible with Calibri and Cambria.'],
  ['Built on solid ground', 'Fedora KDE Plasma 6 and Universal Blue, with bootc for image-based updates.'],
  ['Open source', 'Everything is on GitHub. Code under Apache-2.0, artwork under CC BY-SA 4.0.'],
];

module.exports = {
  path: '/features',
  title: 'Features',
  description: 'What you get with Lindle: familiar layouts, built-in office and photo apps, an app store and updates that take care of themselves.',
  body: `
    <section class="wrap page-head">
      <h1>Everything you need, nothing to set up</h1>
      <p class="lead">Lindle takes care of the parts of Linux that usually need a terminal, so you can get on with your work.</p>
    </section>
${features
  .map(
    (f, i) => `
    <section class="wrap section split${i % 2 ? ' reverse' : ''}">
      <div>
        <h2>${f.title}</h2>
        <p>${f.text}</p>
      </div>
      <figure class="shot"><img src="/img/${f.img}" alt="${f.alt}" width="1280" height="800" loading="lazy"></figure>
    </section>`,
  )
  .join('')}

    <section class="wrap section">
      <h2 class="section-title">And under the hood</h2>
      <div class="cards">
${list.map(([t, d]) => `        <article class="card"><h3>${t}</h3><p>${d}</p></article>`).join('\n')}
      </div>
    </section>
`,
};
