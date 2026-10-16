const chapters = [
  {
    n: '01',
    title: 'Twelve apps on the first boot',
    text: 'WordCraft, GridCraft, DeckCraft and PhotoCraft are pinned to the dock. Firefox, Thunderbird, GIMP, Inkscape, Krita, VLC, ONLYOFFICE and Bottles install themselves in the background. You open the lid and start working.',
    img: 'wordcraft.webp',
    alt: 'WordCraft, the word processor that comes with Lindle',
  },
  {
    n: '02',
    title: 'A start menu that behaves like one',
    text: 'Applications are grouped the way you would expect, search starts the moment you type, and the power buttons are where your hand goes looking for them.',
    img: 'start-menu.webp',
    alt: 'The Lindle start menu',
  },
  {
    n: '03',
    title: 'Everything else is one click away',
    text: 'The app store is Discover, pointed at Flathub only. No snaps, no ads, no account. Apps update in the background next to the OS.',
    img: 'app-store.webp',
    alt: 'The Lindle app store',
  },
  {
    n: '04',
    title: 'Settings that read like English',
    text: 'Light or dark, accent, wallpaper, display scaling. The defaults are already tuned, so most people never open this window twice.',
    img: 'settings.webp',
    alt: 'System Settings in Lindle',
  },
];

const details = [
  ['Atomic updates', 'The OS downloads as one image and switches over on the next restart. Nothing is half-installed.'],
  ['Codecs included', 'H.264, H.265 and AAC play out of the box, courtesy of the Universal Blue base.'],
  ['Calibri and Cambria, in spirit', 'Carlito and Caladea have the same metrics, so a .docx from a colleague keeps its page breaks.'],
  ['One source of truth', 'Colors, type and spacing live in a single tokens file. The desktop and this site both read it.'],
  ['Built on Fedora KDE', 'Plasma 6 on Fedora Kinoite, delivered with bootc and built by CI on every change.'],
  ['Open all the way down', 'Apache-2.0 code and CC BY-SA artwork. Read it, fork it, send a patch.'],
];

const line = (t, cls = '') => `<span class="line ${cls}"><span>${t}</span></span>`;

module.exports = {
  path: '/',
  bodyClass: 'home',
  description:
    'Lindle is a modern, open source Linux desktop for people coming from macOS and Windows. Twelve apps on the first boot, updates that undo themselves.',
  body: `
    <section class="hero">
      <div class="wrap hero-grid">
        <p class="mono kicker rv" style="--d:0">Lindle 0.1 · early preview · open source</p>
        <h1 class="display">
          ${line('Linux that', 'l1')}
          ${line('feels like <em>home.</em>', 'l2')}
        </h1>
        <div class="hero-side rv" style="--d:3">
          <p class="lead">A desktop for people leaving Windows or macOS. Twelve apps are there on the first boot, updates install themselves, and if one goes wrong you boot the previous version.</p>
          <div class="actions">
            <a class="btn" href="/download">Download Lindle <span aria-hidden="true">→</span></a>
            <a class="textlink" href="#layouts">See the layouts</a>
          </div>
        </div>
      </div>

      <div class="wrap stage-wrap rv" style="--d:4" id="layouts">
        <div class="switch" role="group" aria-label="Preview a layout">
          <span class="mono switch-label">Feels like</span>
          <button type="button" data-layout="windows" aria-pressed="true">Windows</button>
          <button type="button" data-layout="mac" aria-pressed="false">macOS</button>
          <button type="button" data-layout="lindle" aria-pressed="false">Lindle</button>
        </div>
        <div class="desk" data-layout="windows" role="img" aria-label="An illustration of the Lindle desktop that switches between a Windows-like and a Mac-like layout">
          <picture>
            <source srcset="/img/wall-dark.webp" media="(prefers-color-scheme: dark)">
            <img class="desk-wall" src="/img/wall-light.webp" alt="" width="2400" height="1350">
          </picture>
          <div class="topbar">
            <span class="tb-left"><img src="/logo.svg" alt="" width="14" height="14"><b>Lindle</b><i>File</i><i>Edit</i><i>View</i></span>
            <span class="tb-right mono">Mon 9:41</span>
          </div>
          <div class="appwin">
            <div class="appwin-bar"><span class="dots"><i></i><i></i><i></i></span><span class="mono">Quarterly plan.docx</span></div>
            <div class="appwin-body">
              <div class="sheet">
                <h6></h6><p></p><p></p><p class="short"></p><p></p><p class="short"></p>
              </div>
            </div>
          </div>
          <div class="taskbar">
            <span class="start"><img src="/logo.svg" alt="" width="26" height="26"></span>
            <span class="apps">
              <i class="a-word"></i><i class="a-grid"></i><i class="a-deck"></i><i class="a-photo"></i><i class="a-fox"></i>
            </span>
            <span class="tray mono">9:41</span>
          </div>
        </div>
        <p class="caption mono">Pick the layout in the Welcome Center. Change your mind whenever you like.</p>
      </div>
    </section>

    <section class="facts wrap">
      <div class="rv"><b>12</b><span>apps installed on the first boot</span></div>
      <div class="rv" style="--d:1"><b>2</b><span>familiar layouts to start from</span></div>
      <div class="rv" style="--d:2"><b>1</b><span>previous version always kept to go back to</span></div>
      <div class="rv" style="--d:3"><b>0</b><span>update prompts while you work</span></div>
    </section>

    <section class="chapters wrap" aria-label="What is inside">
      <div class="chapter-texts">
${chapters
  .map(
    (c, i) => `        <article class="chapter${i === 0 ? ' active' : ''}" data-i="${i}">
          <p class="mono num">${c.n} / 04</p>
          <h2>${c.title}</h2>
          <p>${c.text}</p>
          <figure class="inline-shot"><img src="/img/${c.img}" alt="${c.alt}" width="1280" height="800" loading="lazy"></figure>
        </article>`,
  )
  .join('\n')}
      </div>
      <div class="chapter-stage" aria-hidden="true">
        <div class="frame">
${chapters.map((c, i) => `          <img class="${i === 0 ? 'on' : ''}" src="/img/${c.img}" alt="" width="1280" height="800" loading="lazy">`).join('\n')}
        </div>
      </div>
    </section>

    <section class="undo" id="undo">
      <div class="wrap undo-grid">
        <div class="undo-copy rv">
          <p class="mono kicker">Updates</p>
          <h2 class="display sm">Every update<br>comes with an <em>undo.</em></h2>
          <p class="lead">Lindle updates as a whole image and keeps the previous one next to it. If today's update misbehaves, pick yesterday's entry in the boot menu and carry on.</p>
        </div>
        <div class="boot rv" style="--d:2" data-boot aria-label="Illustration of the boot menu">
          <div class="boot-head mono">Boot menu</div>
          <ul class="boot-list mono">
            <li class="sel" data-entry="new"><span>Lindle · today's update</span><em>broken</em></li>
            <li data-entry="old"><span>Lindle · previous version</span><em>kept</em></li>
          </ul>
          <div class="boot-log mono" aria-live="polite"></div>
          <button class="boot-replay mono" type="button">Replay</button>
        </div>
      </div>
    </section>

    <section class="details wrap">
      <h2 class="display sm rv">The small print,<br>written down.</h2>
      <dl>
${details.map(([t, d], i) => `        <div class="row rv" style="--d:${i % 3}"><dt>${t}</dt><dd>${d}</dd></div>`).join('\n')}
      </dl>
    </section>

    <section class="closer">
      <div class="wrap">
        <p class="mono kicker rv">Version 0.1</p>
        <a class="closer-link rv" href="/download"><span>Try it on a spare machine</span><span class="arrow" aria-hidden="true">→</span></a>
      </div>
    </section>
`,
};
