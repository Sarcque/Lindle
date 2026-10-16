const NAV = [
  { href: '/features', label: 'Features' },
  { href: '/download', label: 'Download' },
  { href: '/about', label: 'About' },
];

const REPO_URL = 'https://github.com/sarcque/lindle';

function layout({ title, description, current, body }) {
  const fullTitle = title ? `${title} · Lindle` : 'Lindle: Linux without the learning curve';
  const nav = NAV.map(
    ({ href, label }) =>
      `<a href="${href}"${href === current ? ' aria-current="page"' : ''}>${label}</a>`,
  ).join('');

  return `<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${fullTitle}</title>
  <meta name="description" content="${description}">
  <meta name="theme-color" content="#0F1120">
  <link rel="icon" href="/logo.svg" type="image/svg+xml">
  <link rel="stylesheet" href="/fonts/inter/index.css">
  <link rel="stylesheet" href="/fonts/jetbrains-mono/index.css">
  <link rel="stylesheet" href="/tokens.css">
  <link rel="stylesheet" href="/css/site.css">
  <script>document.documentElement.classList.add('js')</script>
</head>
<body>
  <header class="site-header">
    <nav class="pill" aria-label="Main">
      <a class="brand" href="/" aria-label="Lindle home"><img src="/logo.svg" alt="" width="28" height="28"><span>Lindle</span></a>
      <span class="links">${nav}</span>
      <a class="cta" href="/download">Get Lindle</a>
    </nav>
  </header>
  <main>
${body}
  </main>
  <footer class="site-footer">
    <div class="wrap footer-grid">
      <div>
        <a class="brand" href="/"><img src="/logo.svg" alt="" width="28" height="28"><span>Lindle</span></a>
        <p class="footer-note">A modern, open source desktop for people coming from macOS and Windows.</p>
      </div>
      <div class="footer-links">
        <a href="/features">Features</a>
        <a href="/download">Download</a>
        <a href="/about">About</a>
        <a href="${REPO_URL}">GitHub</a>
      </div>
    </div>
    <div class="wrap footer-legal mono">Code Apache-2.0 · Artwork CC BY-SA 4.0 · v0.1 early preview</div>
  </footer>
  <script src="/js/site.js" defer></script>
</body>
</html>
`;
}

module.exports = { layout, NAV, REPO_URL };
