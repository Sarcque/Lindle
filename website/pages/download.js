const { REPO_URL } = require('../lib/layout');

module.exports = {
  path: '/download',
  title: 'Download',
  description: 'Download the Lindle installer, or switch an existing Fedora Atomic machine to Lindle.',
  body: `
    <section class="wrap page-head">
      <h1>Get Lindle</h1>
      <p class="lead">Lindle 0.1 is an early preview. Try it in a virtual machine or on a spare computer, but it is not ready for daily use yet.</p>
    </section>

    <section class="wrap section">
      <div class="cards two">
        <article class="card">
          <h2>Installer (ISO)</h2>
          <p>Write the ISO to a USB stick with a tool like Fedora Media Writer or balenaEtcher, then start your computer from it.</p>
          <p>Installers are built by the <strong>Build disk images</strong> workflow. Open the latest run and download the ISO from its artifacts.</p>
          <p><a class="button primary" href="${REPO_URL}/actions/workflows/build-disk.yml">Latest installer builds</a></p>
        </article>
        <article class="card">
          <h2>Already on Fedora Atomic?</h2>
          <p>Switch an existing Fedora Kinoite, Silverblue or Universal Blue machine to Lindle with one command, then restart.</p>
          <pre><code>sudo bootc switch ghcr.io/sarcque/lindle:latest</code></pre>
          <p class="muted">Your files and Flatpak apps stay where they are.</p>
        </article>
      </div>
    </section>

`,
};
