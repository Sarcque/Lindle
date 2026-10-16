const swaps = [
  ['Word', 'WordCraft'],
  ['Excel', 'GridCraft'],
  ['PowerPoint', 'DeckCraft'],
  ['Photoshop', 'PhotoCraft, and GIMP for the heavier jobs'],
  ['Illustrator', 'Inkscape'],
  ['Outlook or Mail', 'Thunderbird'],
  ['Edge, Chrome or Safari', 'Firefox'],
  ['Windows Media Player or QuickTime', 'VLC'],
  ['Files that need Office exactly', 'ONLYOFFICE, as a fallback'],
  ['Windows-only programs', 'Bottles, which runs many of them'],
];

module.exports = {
  path: '/features',
  title: 'What’s inside',
  bodyClass: 'sub',
  description: 'The apps and system features in Lindle 0.1, and what replaces the programs you use now.',
  body: `
    <section class="wrap sub-head">
      <h1 class="rise">What’s inside Lindle 0.1</h1>
      <p class="lead rise" style="--d:1">The system is Fedora KDE Plasma 6 with Universal Blue underneath, plus our theme, our apps and some defaults. This page lists what you get.</p>
    </section>

    <section class="wrap prose-section">
      <h2>If you use this today, you get this</h2>
      <table class="swaps rise">
        <thead><tr><th scope="col">You use</th><th scope="col">Lindle has</th></tr></thead>
        <tbody>
${swaps.map(([a, b]) => `          <tr><th scope="row">${a}</th><td>${b}</td></tr>`).join('\n')}
        </tbody>
      </table>
      <p class="small">WordCraft, GridCraft, DeckCraft and PhotoCraft come from the <a href="https://github.com/storytold">Storytold</a> project and are built into the system image. The others are installed from Flathub the first time you boot.</p>
    </section>

    <section class="wrap prose-section two">
      <div class="rise">
        <h2>Updates</h2>
        <p>The system downloads its updates in the background and switches to them when you restart. The previous version stays available in the boot menu. Apps from Flathub update on their own, too.</p>
      </div>
      <div class="rise" style="--d:1">
        <h2>Look and feel</h2>
        <p>There is a light and a dark theme, one accent colour, a wallpaper and the Inter font. The values are generated from a single tokens file, and CI checks that the text colours have enough contrast.</p>
      </div>
      <div class="rise">
        <h2>Layouts</h2>
        <p>In the Welcome Center you choose between a Windows-style taskbar with a start menu and a Mac-style top bar with a dock. You can change it afterwards.</p>
      </div>
      <div class="rise" style="--d:1">
        <h2>Fonts for documents</h2>
        <p>Carlito and Caladea are installed. They have the same metrics as Calibri and Cambria, which keeps documents from colleagues laid out the way they sent them.</p>
      </div>
    </section>

    <section class="wrap prose-section rise">
      <h2>Screenshots</h2>
      <div class="shots">
        <figure><img src="/img/gridcraft.webp" alt="GridCraft" width="1280" height="800" loading="lazy"><figcaption>GridCraft</figcaption></figure>
        <figure><img src="/img/photocraft.webp" alt="PhotoCraft" width="1280" height="800" loading="lazy"><figcaption>PhotoCraft</figcaption></figure>
        <figure><img src="/img/app-store.webp" alt="The app store" width="1280" height="800" loading="lazy"><figcaption>The app store</figcaption></figure>
        <figure><img src="/img/settings.webp" alt="System Settings" width="1280" height="800" loading="lazy"><figcaption>System Settings</figcaption></figure>
      </div>
    </section>
`,
};
