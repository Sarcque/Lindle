const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
const $$ = (s, r = document) => [...r.querySelectorAll(s)];

// Fade things in as they scroll into view. Without JS or with reduced motion everything is simply visible.
const rise = $$('.rise');
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
    { threshold: 0.1, rootMargin: '0px 0px -5% 0px' },
  );
  rise.forEach((el) => io.observe(el));
} else {
  rise.forEach((el) => el.classList.add('in'));
}

// The desktop drawing: switch layouts, and cycle by itself until someone clicks.
const desk = document.querySelector('.desk');
if (desk) {
  const buttons = $$('.tabs button');
  const order = buttons.map((b) => b.dataset.layout);
  const set = (layout) => {
    desk.dataset.layout = layout;
    buttons.forEach((b) => b.setAttribute('aria-pressed', String(b.dataset.layout === layout)));
  };
  let timer;
  buttons.forEach((b) =>
    b.addEventListener('click', () => {
      clearInterval(timer);
      set(b.dataset.layout);
    }),
  );
  if (!reduce && 'IntersectionObserver' in window) {
    new IntersectionObserver((entries, o) => {
      if (entries[0].isIntersecting) {
        o.disconnect();
        timer = setInterval(() => set(order[(order.indexOf(desk.dataset.layout) + 1) % order.length]), 4200);
      }
    }, { threshold: 0.6 }).observe(desk);
  }
}

// Tour: the screenshot on the right follows the text that is in view.
const steps = $$('.step');
const stageImgs = $$('.tour-stage img');
if (steps.length && 'IntersectionObserver' in window) {
  const so = new IntersectionObserver(
    (entries) => {
      for (const e of entries) {
        if (!e.isIntersecting) continue;
        const i = Number(e.target.dataset.i);
        steps.forEach((c, n) => c.classList.toggle('active', n === i));
        stageImgs.forEach((img, n) => img.classList.toggle('on', n === i));
      }
    },
    { rootMargin: '-45% 0px -45% 0px' },
  );
  steps.forEach((c) => so.observe(c));
}

// Boot menu simulation.
const boot = document.querySelector('[data-boot]');
if (boot) {
  const entries = $$('li', boot);
  const log = boot.querySelector('.boot-log');
  const add = (text, cls = '') => {
    const d = document.createElement('div');
    d.textContent = text;
    d.className = cls;
    log.append(d);
  };
  const select = (name) => entries.forEach((li) => li.classList.toggle('sel', li.dataset.entry === name));
  const done = () => {
    select('old');
    log.replaceChildren();
    add('Starting Lindle (previous version)…');
    add('Back on the previous version. Your files are as you left them.', 'ok');
  };
  let timers = [];
  const play = () => {
    timers.forEach(clearTimeout);
    log.replaceChildren();
    select('new');
    if (reduce) return done();
    add('Today’s update doesn’t start.');
    timers = [
      setTimeout(() => select('old'), 1600),
      setTimeout(() => { log.replaceChildren(); add('Starting Lindle (previous version)…'); }, 2500),
      setTimeout(() => add('Back on the previous version. Your files are as you left them.', 'ok'), 3500),
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
    done();
  }
}
