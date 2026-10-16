const { REPO_URL } = require('../lib/layout');

module.exports = {
  path: '/download',
  title: 'Download',
  description: 'Download the Lindle installer, or switch an existing Fedora Atomic machine to Lindle.',
  body: `
    <section class="page-hero">
      <div class="grain"></div>
      <div class="wrap">
        <p class="mono tag">Download</p>
        <h1>Get Lindle.</h1>
        <p class="lead">Lindle 0.1 is an early preview. Try it in a virtual machine or on a spare computer. It is not ready for daily use yet.</p>
      </div>
    </section>

    <section class="wrap section">
      <div class="paths">
        <article class="path" data-reveal>
          <p class="mono num">A</p>
          <h2>Install from USB</h2>
          <ol class="steps">
            <li>Download the latest ISO from the <strong>Build disk images</strong> workflow.</li>
            <li>Write it to a USB stick with Fedora Media Writer or balenaEtcher.</li>
            <li>Restart your computer and boot from the stick.</li>
          </ol>
          <a class="btn solid" href="${REPO_URL}/actions/workflows/build-disk.yml">Latest installer builds</a>
        </article>
        <article class="path" data-reveal>
          <p class="mono num">B</p>
          <h2>Switch from Fedora Atomic</h2>
          <p>Already on Kinoite, Silverblue or Universal Blue? One command, then restart. Your files and Flatpak apps stay where they are.</p>
          <pre><code>sudo bootc switch ghcr.io/sarcque/lindle:latest</code></pre>
        </article>
      </div>
    </section>
`,
};
