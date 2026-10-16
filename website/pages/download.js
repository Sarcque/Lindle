const { REPO_URL } = require('../lib/layout');

module.exports = {
  path: '/download',
  title: 'Download',
  bodyClass: 'sub',
  description: 'Download the Lindle installer, or switch an existing Fedora Atomic machine to Lindle.',
  body: `
    <section class="wrap sub-head">
      <h1 class="rise">Download Lindle</h1>
      <p class="lead rise" style="--d:1">Lindle 0.1 is an early preview. We’ve only tried it in virtual machines, so please start there and don’t install it on a computer you depend on.</p>
    </section>

    <section class="wrap prose-section narrow">
      <h2 class="rise">Install it from an ISO</h2>
      <ol class="steps rise">
        <li>Open the <a href="${REPO_URL}/actions/workflows/build-disk.yml">Build disk images</a> workflow on GitHub and download the ISO from the latest run. GitHub asks you to sign in to download workflow files.</li>
        <li>Create a virtual machine in GNOME Boxes, VirtualBox or similar, and boot it from the ISO. For a real computer, write the ISO to a USB stick with Fedora Media Writer or balenaEtcher.</li>
        <li>Follow the installer, then restart.</li>
      </ol>

      <h2 class="rise">Switch from Fedora Atomic</h2>
      <p class="rise">If you already run Fedora Kinoite, Silverblue or a Universal Blue image, you can switch with one command and restart. Your files and Flatpak apps stay as they are.</p>
      <pre class="rise"><code>sudo bootc switch ghcr.io/sarcque/lindle:latest</code></pre>
      <p class="small rise">To go back, use <code>sudo bootc rollback</code> or pick the previous entry in the boot menu.</p>
    </section>
`,
};
