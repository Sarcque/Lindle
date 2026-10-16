const NAV = [
  { href: '/features', label: 'Features' },
  { href: '/download', label: 'Download' },
  { href: '/about', label: 'About' },
];

const REPO_URL = 'https://github.com/sarcque/lindle';

function layout({ title, description, current, body, bodyClass = '' }) {
  const fullTitle = title ? `${title} · Lindle` : 'Lindle: Linux that feels like home';
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
  <link rel="icon" href="/logo.svg" type="image/svg+xml">
  <link rel="stylesheet" href="/fonts/inter/index.css">
  <link rel="stylesheet" href="/fonts/jetbrains-mono/index.css">
  <link rel="stylesheet" href="/fonts/instrument-serif/latin-400.css">
  <link rel="stylesheet" href="/fonts/instrument-serif/latin-400-italic.css">
  <link rel="stylesheet" href="/tokens.css">
  <link rel="stylesheet" href="/css/site.css">
  <script>document.documentElement.classList.add('js')</script>
</head>
<body class="${bodyClass}">
  <header class="site-header">
    <a class="brand" href="/" aria-label="Lindle home"><img src="/logo.svg" alt="" width="30" height="30"><span>Lindle</span></a>
    <nav aria-label="Main">${nav}<a class="nav-cta" href="/download">Download <span aria-hidden="true">↓</span></a></nav>
  </header>
  <main>
${body}
  </main>
  <footer class="site-footer">
    <div class="wrap footer-top">
      <p class="footer-lede">A modern, open source desktop for people coming from macOS and Windows.</p>
      <nav class="footer-links" aria-label="Footer">
        <a href="/features">Features</a>
        <a href="/download">Download</a>
        <a href="/about">About</a>
        <a href="${REPO_URL}">GitHub</a>
      </nav>
    </div>
    <div class="wordmark" aria-hidden="true">Lindle</div>
    <div class="wrap footer-legal mono"><span>Code Apache-2.0 · Artwork CC BY-SA 4.0</span><span>v0.1 early preview</span></div>
  </footer>
  <script src="/js/site.js" defer></script>
</body>
</html>
`;
}

module.exports = { layout, NAV, REPO_URL };
