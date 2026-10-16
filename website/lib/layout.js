const NAV = [
  { href: '/features', label: 'What’s inside' },
  { href: '/about', label: 'About' },
];

const REPO_URL = 'https://github.com/sarcque/lindle';

function layout({ title, description, current, body, bodyClass = '' }) {
  const fullTitle = title ? `${title} · Lindle` : 'Lindle, a Linux desktop for Windows and Mac users';
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
  <link rel="stylesheet" href="/fonts/schibsted-grotesk/index.css">
  <link rel="stylesheet" href="/fonts/funnel-display/latin-500.css">
  <link rel="stylesheet" href="/fonts/funnel-display/latin-700.css">
  <link rel="stylesheet" href="/fonts/jetbrains-mono/index.css">
  <link rel="stylesheet" href="/tokens.css">
  <link rel="stylesheet" href="/css/site.css">
  <script>document.documentElement.classList.add('js')</script>
</head>
<body class="${bodyClass}">
  <header class="site-header">
    <div class="wrap bar">
      <a class="brand" href="/" aria-label="Lindle home"><img src="/logo.svg" alt="" width="30" height="30"><span>Lindle</span></a>
      <nav aria-label="Main">${nav}<a class="nav-dl" href="/download">Download</a></nav>
    </div>
  </header>
  <main>
${body}
  </main>
  <footer class="site-footer">
    <div class="wrap foot">
      <p>Lindle is open source. The code is Apache-2.0 and the artwork is CC BY-SA 4.0. Version 0.1, early preview.</p>
      <p><a href="${REPO_URL}">Source on GitHub</a> · <a href="${REPO_URL}/issues">Report a problem</a></p>
    </div>
  </footer>
  <script src="/js/site.js" defer></script>
</body>
</html>
`;
}

module.exports = { layout, NAV, REPO_URL };
