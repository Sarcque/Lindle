const { REPO_URL } = require('../lib/layout');
const line = (t) => `<span class="line"><span>${t}</span></span>`;

module.exports = {
  path: '/download',
  title: 'Download',
  bodyClass: 'sub',
  description: 'Download the Lindle installer, or switch an existing Fedora Atomic machine to Lindle.',
  body: `
    <section class="sub-hero">
      <div class="wrap">
        <p class="mono kicker rv">Download</p>
        <h1 class="display">${line('Get <em>Lindle.</em>')}</h1>
        <p class="lead rv" style="--d:2">Lindle 0.1 is an early preview. Try it in a virtual machine or on a spare computer. It is not ready for daily use yet.</p>
      </div>
    </section>

    <section class="wrap paths">
      <article class="path rv">
        <p class="mono num">Option A</p>
        <h2>Install from a USB stick</h2>
        <ol class="steps">
          <li>Download the latest ISO from the <strong>Build disk images</strong> workflow.</li>
          <li>Write it to a USB stick with Fedora Media Writer or balenaEtcher.</li>
          <li>Restart your computer and boot from the stick.</li>
        </ol>
        <a class="btn" href="${REPO_URL}/actions/workflows/build-disk.yml">Latest installer builds <span aria-hidden="true">→</span></a>
      </article>
      <article class="path rv" style="--d:2">
        <p class="mono num">Option B</p>
        <h2>Switch from Fedora Atomic</h2>
        <p>Already on Kinoite, Silverblue or Universal Blue? One command, then restart. Your files and Flatpak apps stay where they are.</p>
        <pre><code>sudo bootc switch ghcr.io/sarcque/lindle:latest</code></pre>
      </article>
    </section>
`,
};
