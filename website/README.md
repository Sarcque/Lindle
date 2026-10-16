# Lindle website

A small Express site with four pages: home, features, download and about.

Colors, radii, spacing and motion come straight from [`design/tokens.json`](../design/tokens.json): the server turns them into CSS variables at `/tokens.css`, so the site always matches the OS theme, in light and dark mode. The logo is served from [`design/logo`](../design/logo). Inter and JetBrains Mono are self-hosted from npm, so the site loads nothing from third parties.

```bash
cd website
npm install
npm start        # http://localhost:3000 (set PORT to change)
npm run dev      # restarts on file changes
npm test
```

## Layout

```
server.js        Express app: routes, static files, fonts, 404
lib/tokens.js    design/tokens.json -> CSS variables
lib/layout.js    Shared page shell: header, nav, footer
pages/*.js       One file per page: path, title, description, body
public/css/      Site stylesheet
public/img/      OS screenshots (WebP)
```

To add a page, create a file in `pages/`, add it to the list in `server.js` and, if it belongs in the menu, to `NAV` in `lib/layout.js`.
