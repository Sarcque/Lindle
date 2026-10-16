// Turns design/tokens.json (the single source of truth for Lindle's look)
// into CSS custom properties, so the site always matches the OS theme.
const fs = require('node:fs');
const path = require('node:path');

const TOKENS_PATH = path.join(__dirname, '..', '..', 'design', 'tokens.json');

function kebab(name) {
  return name.replace(/[A-Z]/g, (c) => '-' + c.toLowerCase());
}

function colorVars(colors) {
  return Object.entries(colors)
    .map(([name, value]) => `  --${kebab(name)}: ${value};`)
    .join('\n');
}

function tokensCss(tokens = JSON.parse(fs.readFileSync(TOKENS_PATH, 'utf8'))) {
  const { radius, spacing, motionMs, color, wallpaper } = tokens;
  const shared = [
    ...Object.entries(radius).map(([k, v]) => `  --radius-${k}: ${v}px;`),
    ...spacing.map((v, i) => `  --space-${i + 1}: ${v}px;`),
    ...Object.entries(motionMs).map(([k, v]) => `  --motion-${k}: ${v}ms;`),
  ].join('\n');
  const wall = (mode) =>
    [
      `  --wall-base: ${wallpaper[mode].base};`,
      ...wallpaper[mode].blobs.map((c, i) => `  --wall-blob-${i + 1}: ${c};`),
    ].join('\n');

  return `:root {
${shared}
${colorVars(color.light)}
${wall('light')}
  color-scheme: light;
}
@media (prefers-color-scheme: dark) {
  :root {
${colorVars(color.dark)}
${wall('dark')}
    color-scheme: dark;
  }
}
`;
}

module.exports = { tokensCss, TOKENS_PATH };
