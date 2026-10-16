const path = require('node:path');
const express = require('express');
const { layout } = require('./lib/layout');
const { tokensCss } = require('./lib/tokens');

const PAGES = ['home', 'features', 'download', 'about'].map((name) => require(`./pages/${name}`));

function createApp() {
  const app = express();
  app.disable('x-powered-by');

  const css = tokensCss();
  app.get('/tokens.css', (req, res) => res.type('css').send(css));
  app.get('/logo.svg', (req, res) =>
    res.sendFile(path.join(__dirname, '..', 'design', 'logo', 'lindle-mark.svg')),
  );

  const fontDir = (pkg) => path.dirname(require.resolve(`${pkg}/package.json`));
  const fonts = {
    inter: '@fontsource-variable/inter',
    'jetbrains-mono': '@fontsource-variable/jetbrains-mono',
    'instrument-serif': '@fontsource/instrument-serif',
  };
  for (const [name, pkg] of Object.entries(fonts)) {
    app.use(`/fonts/${name}`, express.static(fontDir(pkg), { maxAge: '30d' }));
  }
  app.use(express.static(path.join(__dirname, 'public'), { maxAge: '1h' }));

  for (const page of PAGES) {
    const html = layout({ ...page, current: page.path });
    app.get(page.path, (req, res) => res.send(html));
  }

  app.use((req, res) => {
    res.status(404).send(
      layout({
        title: 'Page not found',
        description: 'This page does not exist.',
        body: `
    <section class="sub-hero"><div class="wrap">
      <h1>Page not found</h1>
      <p class="lead">This page does not exist. <a href="/">Go to the home page</a>.</p>
    </div></section>`,
      }),
    );
  });

  return app;
}

if (require.main === module) {
  const port = Number(process.env.PORT) || 3000;
  createApp().listen(port, () => console.log(`Lindle website on http://localhost:${port}`));
}

module.exports = { createApp };
