const { REPO_URL } = require('../lib/layout');

const tour = [
  {
    title: 'Office and photo apps are already there',
    text: 'There’s a word processor (WordCraft), a spreadsheet (GridCraft), a presentation app (DeckCraft) and a photo editor (PhotoCraft). They’re meant to replace Word, Excel, PowerPoint and Photoshop. ONLYOFFICE is installed too, for documents that need it.',
    img: 'wordcraft.webp',
    alt: 'WordCraft, the word processor that comes with Lindle',
  },
  {
    title: 'The start menu works like you’d expect',
    text: 'Apps are sorted into categories, search starts as soon as you type, and sleep, restart and shut down are at the bottom. If you’d rather have a dock and a menu bar at the top, you can pick that in the Welcome Center.',
    img: 'start-menu.webp',
    alt: 'The Lindle start menu',
  },
  {
    title: 'More apps come from one store',
    text: 'The app store only shows apps from Flathub. Firefox, Thunderbird, GIMP, Inkscape, Krita, VLC and Bottles are installed the first time you boot, and they update themselves along with the system.',
    img: 'app-store.webp',
    alt: 'The Lindle app store',
  },
  {
    title: 'Settings are the ones from KDE Plasma',
    text: 'We haven’t reinvented System Settings. It’s Plasma’s own, with our light and dark themes, our wallpaper and the accent colour already set.',
    img: 'settings.webp',
    alt: 'System Settings in Lindle',
  },
];

const faq = [
  ['Will my Word and Excel files look right?', 'Mostly, yes. Lindle ships Carlito and Caladea, which have the same letter widths as Calibri and Cambria, so page breaks stay where they were. Very complicated documents can still differ, and for those there’s ONLYOFFICE.'],
  ['Can I run my Windows programs?', 'Some of them. Bottles is installed and runs many Windows apps, but not all. Check whether your must-have program works before you switch.'],
  ['What happens if an update breaks something?', 'Lindle keeps the previous version of the system next to the new one. You pick it in the boot menu and you’re back where you were. Your files aren’t touched either way.'],
  ['Does it cost anything?', 'No. It’s open source, and there’s no account or subscription.'],
  ['Will it run on my laptop?', 'We don’t know yet. We’ve only tried it in virtual machines so far, so start there. Testing on real hardware is planned for 0.4.'],
  ['Why does it have its own wallpaper and colours?', 'Because we’d like it to look finished. The colours, fonts and spacing live in one file in the repository, and the desktop and this website both read from it.'],
];

const notYet = [
  'A graphics driver image for NVIDIA cards',
  'Importing your files and bookmarks from a Windows disk',
  'An option to use Mac-style keyboard shortcuts',
  'Testing on real laptops and desktops',
  'An accessibility check (contrast, screen readers, keyboard use)',
  'Signed images. They’re currently built without a signature.',
];

module.exports = {
  path: '/',
  bodyClass: 'home',
  description:
    'Lindle is an open source Linux desktop for people coming from Windows or macOS. It comes with office and photo apps and updates itself. Version 0.1, early preview.',
  body: `
    <section class="hero">
      <div class="wrap">
        <h1 class="rise">A Linux desktop for people coming from Windows or macOS</h1>
        <p class="lead rise" style="--d:1">Lindle is an open source operating system. It starts with a taskbar or a dock you already know, comes with a word processor, a spreadsheet, a presentation app and a photo editor, and updates itself in the background. It’s version 0.1, so expect rough edges.</p>
        <p class="rise" style="--d:2"><a class="button" href="/download">Download Lindle</a> <a class="plain" href="${REPO_URL}">or look at the source</a></p>
      </div>

      <div class="wrap stage rise" style="--d:3">
        <div class="tabs" role="group" aria-label="Preview a layout">
          <button type="button" data-layout="windows" aria-pressed="true">Windows-style</button>
          <button type="button" data-layout="mac" aria-pressed="false">Mac-style</button>
          <button type="button" data-layout="lindle" aria-pressed="false">Lindle’s own</button>
        </div>
        <div class="desk" data-layout="windows" role="img" aria-label="A drawing of the Lindle desktop that changes between a Windows-style, a Mac-style and Lindle's own layout">
          <picture>
            <source srcset="/img/wall-dark.webp" media="(prefers-color-scheme: dark)">
            <img class="desk-wall" src="/img/wall-light.webp" alt="" width="2400" height="1350">
          </picture>
          <div class="topbar">
            <span class="tb-left"><img src="/logo.svg" alt="" width="14" height="14"><b>Lindle</b><i>File</i><i>Edit</i><i>View</i></span>
            <span class="tb-right">Mon 9:41</span>
          </div>
          <div class="appwin">
            <div class="appwin-bar"><span class="dots"><i></i><i></i><i></i></span><span>Quarterly plan.docx</span></div>
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
            <span class="tray">9:41</span>
          </div>
        </div>
        <p class="note">This is a drawing, not a screenshot. Real screenshots are further down the page. You choose the layout the first time you log in and can change it later.</p>
      </div>
    </section>

    <section class="tour wrap" aria-label="What’s inside">
      <div class="tour-texts">
${tour
  .map(
    (c, i) => `        <article class="step${i === 0 ? ' active' : ''}" data-i="${i}">
          <h2>${c.title}</h2>
          <p>${c.text}</p>
          <figure class="inline-shot"><img src="/img/${c.img}" alt="${c.alt}" width="1280" height="800" loading="lazy"></figure>
        </article>`,
  )
  .join('\n')}
      </div>
      <div class="tour-stage" aria-hidden="true">
        <div class="frame">
${tour.map((c, i) => `          <img class="${i === 0 ? 'on' : ''}" src="/img/${c.img}" alt="" width="1280" height="800" loading="lazy">`).join('\n')}
        </div>
      </div>
    </section>

    <section class="undo">
      <div class="wrap undo-grid">
        <div class="undo-copy rise">
          <h2>If an update goes wrong, you go back</h2>
          <p>Lindle installs updates as a whole new copy of the system and keeps the old one. The new copy only takes over after a restart. If it doesn’t behave, choose the previous entry in the boot menu.</p>
          <p class="small">The panel on the right is a small simulation of that menu.</p>
        </div>
        <div class="boot rise" style="--d:2" data-boot aria-label="A simulation of the boot menu">
          <div class="boot-head">Boot menu</div>
          <ul class="boot-list">
            <li class="sel" data-entry="new"><span>Lindle (today’s update)</span><em>won’t start</em></li>
            <li data-entry="old"><span>Lindle (previous version)</span><em>works</em></li>
          </ul>
          <div class="boot-log" aria-live="polite"></div>
          <button class="boot-replay" type="button">Play again</button>
        </div>
      </div>
    </section>

    <section class="wrap faq">
      <h2>Questions people ask</h2>
${faq.map(([q, a]) => `      <details class="rise"><summary>${q}</summary><p>${a}</p></details>`).join('\n')}
    </section>

    <section class="wrap notyet rise">
      <h2>What isn’t there yet</h2>
      <p>Lindle is at the start. These are things we know are missing:</p>
      <ul>
${notYet.map((t) => `        <li>${t}</li>`).join('\n')}
      </ul>
      <p>The full list is in the <a href="${REPO_URL}/blob/main/docs/plan.md">plan</a>.</p>
    </section>

    <section class="wrap try rise">
      <h2>Want to try it?</h2>
      <p>The easiest way is in a virtual machine. You can switch back whenever you like.</p>
      <p><a class="button" href="/download">Go to the download page</a></p>
    </section>
`,
};
