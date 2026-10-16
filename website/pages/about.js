const { REPO_URL } = require('../lib/layout');

module.exports = {
  path: '/about',
  title: 'About',
  description: 'Why Lindle exists, how it is built and how to get involved.',
  body: `
    <section class="wrap page-head">
      <h1>About Lindle</h1>
      <p class="lead">Lindle exists for people who want to leave macOS or Windows without learning a new way of working.</p>
    </section>

    <section class="wrap section prose">
      <h2>What we believe</h2>
      <p>Switching should not mean opening a terminal. A good desktop looks great, works out of the box and comes with the apps you need. Updates should never get in the way, and if one goes wrong you should be able to go back.</p>

      <h2>How it is built</h2>
      <p>Lindle is an image-based OS. The whole system is defined in one Containerfile on top of Fedora KDE Plasma 6 and Universal Blue, and built by CI. Every color, font and spacing value comes from one design tokens file, which also styles this website.</p>

      <h2>Get involved</h2>
      <p>Lindle is open source and early. Ideas, bug reports and pull requests are welcome on GitHub.</p>
      <p><a class="button" href="${REPO_URL}">Lindle on GitHub</a> <a class="button" href="${REPO_URL}/issues">Report an issue</a></p>
    </section>
`,
};
