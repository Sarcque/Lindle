const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
const $$ = (s, r = document) => [...r.querySelectorAll(s)];

// Reveal on scroll. Without JS (or with reduced motion) everything is simply visible.
const reveal = $$('.rv, .display');
if ('IntersectionObserver' in window && !reduce) {
  const io = new IntersectionObserver(
    (entries) => {
      for (const e of entries) {
        if (e.isIntersecting) {
          e.target.classList.add('in');
          io.unobserve(e.target);
        }
      }
    },
    { threshold: 0.15, rootMargin: '0px 0px -6% 0px' },
  );
  reveal.forEach((el) => io.observe(el));
} else {
  reveal.forEach((el) => el.classList.add('in'));
}

// Desktop illustration: switch layouts, and cycle on its own until someone clicks.
const desk = document.querySelector('.desk');
if (desk) {
  const buttons = $$('.switch button');
  const order = buttons.map((b) => b.dataset.layout);
  const set = (layout) => {
    desk.dataset.layout = layout;
    buttons.forEach((b) => b.setAttribute('aria-pressed', String(b.dataset.layout === layout)));
  };
  let timer;
  const stop = () => clearInterval(timer);
  buttons.forEach((b) =>
    b.addEventListener('click', () => {
      stop();
      set(b.dataset.layout);
    }),
  );
  if (!reduce) {
    let seen = false;
    new IntersectionObserver((entries, o) => {
      if (entries[0].isIntersecting && !seen) {
        seen = true;
        o.disconnect();
        timer = setInterval(() => set(order[(order.indexOf(desk.dataset.layout) + 1) % order.length]), 3800);
      }
    }, { threshold: 0.6 }).observe(desk);
  }
}

// Chapters: the screenshot on the right follows the text that is in view.
const chapters = $$('.chapter');
const stageImgs = $$('.chapter-stage img');
if (chapters.length && 'IntersectionObserver' in window) {
  const co = new IntersectionObserver(
    (entries) => {
      for (const e of entries) {
        if (!e.isIntersecting) continue;
        const i = Number(e.target.dataset.i);
        chapters.forEach((c, n) => c.classList.toggle('active', n === i));
        stageImgs.forEach((img, n) => img.classList.toggle('on', n === i));
      }
    },
    { rootMargin: '-45% 0px -45% 0px' },
  );
  chapters.forEach((c) => co.observe(c));
}

// Boot menu: pick the previous entry, watch it come back.
const boot = document.querySelector('[data-boot]');
if (boot) {
  const entries = $$('li', boot);
  const log = boot.querySelector('.boot-log');
  const add = (text, cls = '', delay = 0) => {
    const d = document.createElement('div');
    d.textContent = text;
    d.className = cls;
    d.style.animationDelay = delay + 'ms';
    log.append(d);
  };
  const select = (name) => entries.forEach((li) => li.classList.toggle('sel', li.dataset.entry === name));
  const finish = () => {
    select('old');
    log.replaceChildren();
    add('> Lindle · previous version');
    add('Booting…');
    add('✓ Back on yesterday’s version. Your files were never touched.', 'ok');
  };
  let timers = [];
  const play = () => {
    timers.forEach(clearTimeout);
    log.replaceChildren();
    select('new');
    if (reduce) return finish();
    add('Today’s update fails to start.');
    timers = [
      setTimeout(() => select('old'), 1500),
      setTimeout(() => { log.replaceChildren(); add('> Lindle · previous version'); }, 2300),
      setTimeout(() => add('Booting…'), 2900),
      setTimeout(() => add('✓ Back on yesterday’s version. Your files were never touched.', 'ok'), 3700),
    ];
  };
  boot.querySelector('.boot-replay').addEventListener('click', play);
  if ('IntersectionObserver' in window) {
    new IntersectionObserver((es, o) => {
      if (es[0].isIntersecting) {
        o.disconnect();
        play();
      }
    }, { threshold: 0.5 }).observe(boot);
  } else {
    finish();
  }
}
