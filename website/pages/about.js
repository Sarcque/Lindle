const { REPO_URL } = require('../lib/layout');

module.exports = {
  path: '/about',
  title: 'About',
  description: 'Why Lindle exists, how it is built and how to get involved.',
  body: `
    <section class="page-hero">
      <div class="grain"></div>
      <div class="wrap">
        <p class="mono tag">About</p>
        <h1>Switching should feel<br>like <em>moving house</em>,<br>not learning to cook.</h1>
      </div>
    </section>

    <section class="wrap section manifesto">
      <div data-reveal>
        <p class="mono num">Why</p>
        <p class="big-text">A good desktop looks great, works out of the box and comes with the apps you need. Updates should never get in the way, and when one goes wrong you should be able to go back.</p>
      </div>
      <div data-reveal>
        <p class="mono num">How</p>
        <p class="big-text">Lindle is an image-based OS: one Containerfile on top of Fedora KDE Plasma 6 and Universal Blue, built by CI. Every color, font and spacing value comes from one design tokens file, which also styles this website.</p>
      </div>
      <div data-reveal>
        <p class="mono num">Join</p>
        <p class="big-text">Lindle is open source and early. Ideas, bug reports and pull requests are welcome.</p>
        <div class="actions">
          <a class="btn solid" href="${REPO_URL}">Lindle on GitHub</a>
          <a class="btn outline" href="${REPO_URL}/issues">Report an issue</a>
        </div>
      </div>
    </section>
`,
};
