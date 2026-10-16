const { REPO_URL } = require('../lib/layout');
const line = (t) => `<span class="line"><span>${t}</span></span>`;

module.exports = {
  path: '/about',
  title: 'About',
  bodyClass: 'sub',
  description: 'Why Lindle exists, how it is built and how to get involved.',
  body: `
    <section class="sub-hero">
      <div class="wrap">
        <p class="mono kicker rv">About</p>
        <h1 class="display">${line('Switching should feel')}${line('like <em>moving house,</em>')}${line('not learning to cook.')}</h1>
      </div>
    </section>

    <section class="wrap manifesto">
      <div class="m-row rv">
        <p class="mono num">Why</p>
        <p class="big-text">A good desktop looks great, works out of the box and comes with the apps you need. Updates should never get in the way, and when one goes wrong you should be able to go back.</p>
      </div>
      <div class="m-row rv">
        <p class="mono num">How</p>
        <p class="big-text">Lindle is an image-based OS: one Containerfile on top of Fedora KDE Plasma 6 and Universal Blue, built by CI. Every color, font and spacing value comes from one design tokens file, which also styles this website.</p>
      </div>
      <div class="m-row rv">
        <p class="mono num">Join</p>
        <div>
          <p class="big-text">Lindle is open source and early. Ideas, bug reports and pull requests are welcome.</p>
          <div class="actions">
            <a class="btn" href="${REPO_URL}">Lindle on GitHub <span aria-hidden="true">→</span></a>
            <a class="textlink" href="${REPO_URL}/issues">Report an issue</a>
          </div>
        </div>
      </div>
    </section>
`,
};
