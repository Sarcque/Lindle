const { REPO_URL } = require('../lib/layout');

module.exports = {
  path: '/about',
  title: 'About',
  bodyClass: 'sub',
  description: 'Why Lindle exists, how it is built and how to get involved.',
  body: `
    <section class="wrap sub-head">
      <h1 class="rise">About Lindle</h1>
    </section>

    <section class="wrap prose-section narrow prose">
      <p class="rise">Lindle is a Linux desktop for people who use Windows or macOS today and are curious about something else, but don’t want to spend a weekend learning how Linux works. We want it to look good, to have the usual apps ready, and to survive a bad update.</p>
      <p class="rise">It’s a small project and it’s at the very beginning. The first version boots, installs in a virtual machine and has a theme and a set of apps. Plenty is still missing, and the home page lists what we know about.</p>

      <h2 class="rise">How it’s made</h2>
      <p class="rise">The whole system is described in one Containerfile. It starts from the Universal Blue Kinoite image (Fedora with KDE Plasma 6), adds our theme, fonts, apps and defaults, and is built by GitHub Actions on every change. Updates are delivered with bootc, which is why the previous version is always still there.</p>
      <p class="rise">Colours, spacing and corner radii are defined once, in <code>design/tokens.json</code>. A script turns that file into the KDE colour schemes and the wallpaper, and this website reads the same file.</p>

      <h2 class="rise">Helping out</h2>
      <p class="rise">Bug reports, ideas and pull requests are all welcome. The easiest way to help right now is to try it in a virtual machine and tell us what felt wrong.</p>
      <p class="rise"><a class="button" href="${REPO_URL}/issues">Report a problem</a> <a class="plain" href="${REPO_URL}">Browse the code</a></p>
    </section>
`,
};
