const NAV = [
  { href: '/', label: 'Home' },
  { href: '/features', label: 'Features' },
  { href: '/download', label: 'Download' },
  { href: '/about', label: 'About' },
];

const REPO_URL = 'https://github.com/sarcque/lindle';

function layout({ title, description, current, body }) {
  const fullTitle = title ? `${title} · Lindle` : 'Lindle: a Linux desktop that feels like home';
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
  <link rel="stylesheet" href="/tokens.css">
  <link rel="stylesheet" href="/css/site.css">
</head>
<body>
  <header class="site-header">
    <div class="wrap header-inner">
      <a class="brand" href="/"><img src="/logo.svg" alt="" width="32" height="32"><span>Lindle</span></a>
      <nav class="site-nav" aria-label="Main">${nav}</nav>
    </div>
  </header>
  <main>
${body}
  </main>
  <footer class="site-footer">
    <div class="wrap footer-inner">
      <p><img src="/logo.svg" alt="" width="20" height="20"> Lindle is open source. Code under Apache-2.0, artwork under CC BY-SA 4.0.</p>
      <p><a href="${REPO_URL}">Source on GitHub</a></p>
    </div>
  </footer>
</body>
</html>
`;
}

module.exports = { layout, NAV, REPO_URL };
