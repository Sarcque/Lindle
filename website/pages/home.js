module.exports = {
  path: '/',
  description:
    'Lindle is a modern, open source Linux desktop for people coming from macOS and Windows. It looks great, works out of the box and comes with familiar apps.',
  body: `
    <section class="hero">
      <div class="wrap hero-inner">
        <div class="hero-text">
          <p class="eyebrow">Version 0.1 · early preview</p>
          <h1>A Linux desktop that feels like home.</h1>
          <p class="lead">Lindle is a modern, open source desktop for people coming from macOS and Windows. It looks great, works out of the box, and your office and photo apps are already there.</p>
          <div class="actions">
            <a class="button primary" href="/download">Get Lindle</a>
            <a class="button" href="/features">See what's inside</a>
          </div>
        </div>
        <figure class="hero-shot">
          <img src="/img/welcome.webp" alt="The Lindle desktop with the Welcome Center open" width="1280" height="800">
        </figure>
      </div>
    </section>

    <section class="wrap section">
      <h2 class="section-title">Made for switchers</h2>
      <div class="cards">
        <article class="card">
          <h3>Familiar from day one</h3>
          <p>Pick a Windows-like or Mac-like layout when you first log in. Your taskbar, start menu and shortcuts work the way you expect.</p>
        </article>
        <article class="card">
          <h3>Apps already installed</h3>
          <p>WordCraft, GridCraft, DeckCraft and PhotoCraft sit in the dock, next to Firefox, Thunderbird, GIMP, Inkscape and VLC.</p>
        </article>
        <article class="card">
          <h3>Updates you never notice</h3>
          <p>Lindle updates itself quietly in the background and applies changes on the next restart. A bad update can be undone at boot.</p>
        </article>
      </div>
    </section>

    <section class="wrap section split">
      <div>
        <h2>Your documents keep their layout</h2>
        <p>Lindle ships fonts that match Calibri and Cambria, so Word and Excel files from colleagues look the way they were meant to. For the most complex Office files, ONLYOFFICE is installed as well.</p>
        <p><a href="/features">All features</a></p>
      </div>
      <figure class="shot"><img src="/img/wordcraft.webp" alt="WordCraft, Lindle's word processor" width="1280" height="800" loading="lazy"></figure>
    </section>
`,
};
