const { test } = require('node:test');
const assert = require('node:assert');
const { createApp } = require('../server');

async function withServer(fn) {
  const server = createApp().listen(0);
  await new Promise((resolve) => server.once('listening', resolve));
  try {
    await fn(`http://127.0.0.1:${server.address().port}`);
  } finally {
    server.close();
  }
}

test('every page, the logo and the stylesheets load', () =>
  withServer(async (base) => {
    for (const path of ['/', '/features', '/download', '/about', '/logo.svg', '/tokens.css', '/css/site.css', '/fonts/schibsted-grotesk/index.css', '/fonts/funnel-display/latin-700.css', '/js/site.js']) {
      const res = await fetch(base + path);
      assert.strictEqual(res.status, 200, path);
    }
  }));

test('tokens.css carries the accent from design/tokens.json', () =>
  withServer(async (base) => {
    const css = await (await fetch(base + '/tokens.css')).text();
    assert.match(css, /--accent: #3D63F5;/);
    assert.match(css, /prefers-color-scheme: dark/);
  }));

test('unknown pages return 404', () =>
  withServer(async (base) => {
    const res = await fetch(base + '/nope');
    assert.strictEqual(res.status, 404);
  }));
