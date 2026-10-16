const apps = [
  'WordCraft', 'GridCraft', 'DeckCraft', 'PhotoCraft', 'Firefox', 'Thunderbird',
  'GIMP', 'Inkscape', 'Krita', 'VLC', 'ONLYOFFICE', 'Bottles',
];
const marquee = [...apps, ...apps].map((a) => `<span>${a}</span>`).join('');

module.exports = {
  path: '/',
  description:
    'Lindle is a modern, open source Linux desktop for people coming from macOS and Windows. Familiar layout, apps included, updates you can undo.',
  body: `
    <section class="hero">
      <div class="grain"></div>
      <div class="wrap hero-copy">
        <p class="mono tag">Lindle 0.1 · early preview</p>
        <h1>Linux, without<br>the <em>learning curve</em>.</h1>
        <p class="lead">A desktop for people coming from macOS and Windows. Your office and photo apps are already installed, and updates install themselves.</p>
        <div class="actions">
          <a class="btn solid" href="/download">Download</a>
          <a class="btn ghost" href="/features">How it works</a>
        </div>
      </div>
      <div class="wrap hero-stage">
        <div class="window">
          <div class="window-bar"><i></i><i></i><i></i><span class="mono">Welcome Center</span></div>
          <img src="/img/welcome.webp" alt="The Lindle desktop with the Welcome Center open" width="1280" height="800" fetchpriority="high">
        </div>
      </div>
    </section>

    <div class="marquee" aria-label="Apps included"><div class="track">${marquee}</div></div>

    <section class="wrap section">
      <div class="section-head" data-reveal>
        <p class="mono tag">What you get</p>
        <h2>Everything a switcher needs. Nothing to configure.</h2>
      </div>

      <div class="bento">
        <article class="tile t-wide" data-reveal>
          <div class="tile-copy">
            <h3>Pick the desktop you know</h3>
            <p>Windows-style taskbar and start menu, or a Mac-style top bar and dock. Choose once in the Welcome Center and change your mind any time.</p>
          </div>
          <div class="duo">
            <img src="/img/layout-windows.webp" alt="Windows-like layout" width="1280" height="800" loading="lazy">
            <img src="/img/layout-mac.webp" alt="Mac-like layout" width="1280" height="800" loading="lazy">
          </div>
        </article>

        <article class="tile t-tall accent" data-reveal>
          <p class="mono tag">Updates</p>
          <p class="big">1 click<br>to undo.</p>
          <p>The OS updates as a single image. If something breaks, boot the previous version.</p>
        </article>

        <article class="tile" data-reveal>
          <div class="fontdemo" aria-hidden="true"><span>Aa</span><b>=</b><span>Aa</span></div>
          <h3>Documents keep their layout</h3>
          <p>Carlito and Caladea match Calibri and Cambria, so shared files look right.</p>
        </article>

        <article class="tile" data-reveal>
          <div class="swatches" aria-hidden="true"><i></i><i></i><i></i><i></i></div>
          <h3>Light, dark, consistent</h3>
          <p>One set of design tokens styles the desktop, the apps and this website.</p>
        </article>

        <article class="tile" data-reveal>
          <div class="fontdemo" aria-hidden="true"><span>&#9654;</span></div>
          <h3>Plays everything</h3>
          <p>Video and music codecs are included. No extra downloads, no hunting for plugins.</p>
        </article>

        <article class="tile t-half shot" data-reveal>
          <div class="tile-copy">
            <h3>Office and photo apps, built in</h3>
            <p>WordCraft, GridCraft, DeckCraft and PhotoCraft sit in the dock from the first boot.</p>
          </div>
          <img src="/img/wordcraft.webp" alt="WordCraft" width="1280" height="800" loading="lazy">
        </article>

        <article class="tile t-half shot" data-reveal>
          <div class="tile-copy">
            <h3>An app store for the rest</h3>
            <p>Thousands more apps from Flathub, updated in the background.</p>
          </div>
          <img src="/img/app-store.webp" alt="The Lindle app store" width="1280" height="800" loading="lazy">
        </article>
      </div>
    </section>

    <section class="wrap cta-section" data-reveal>
      <div class="cta-box">
        <h2>Try it on a spare machine or in a VM.</h2>
        <p>Lindle is open source and moving fast. Early testers shape what comes next.</p>
        <a class="btn solid" href="/download">Get Lindle</a>
      </div>
    </section>
`,
};
