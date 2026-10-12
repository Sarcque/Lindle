# Lindle

Lindle is a modern, open source Linux desktop for people coming from macOS and Windows. It aims to look great, work out of the box, and come with familiar apps already installed.

> Status: **0.1, early scaffolding.** Not ready for daily use yet. See [docs/plan.md](docs/plan.md) for the full plan and roadmap.

## What's in 0.1

- **Base:** Fedora KDE (Plasma 6) as an atomic, image-based OS, built on [Universal Blue](https://universal-blue.org/)'s `kinoite-main` image with [bootc](https://github.com/bootc-dev/bootc). Codecs and Flathub come from the base.
- **Look:** Lindle light and dark color schemes, Inter and JetBrains Mono fonts, Lindle wallpaper, floating taskbar. All colors come from [design/tokens.json](design/tokens.json) and are checked for WCAG contrast in CI.
- **Storytold Craft apps, built into the OS:** [PhotoCraft](https://github.com/storytold/photocraft) (Photoshop) and [GridCraft](https://github.com/storytold/gridcraft) (Excel), from each project's latest release. [WordCraft](https://github.com/storytold/wordcraft) (Word) and [SlideCraft](https://github.com/storytold/slidecraft) (PowerPoint) are added automatically once they publish their first release.
- **Apps, installed from Flathub on first boot:** ONLYOFFICE (Word, Excel, PowerPoint), GIMP (Photoshop), Inkscape, Krita, Firefox, Thunderbird, VLC, Bottles (Windows apps).
- **Updates:** the OS downloads updates in the background and applies them on the next restart; apps update in the background too. A bad OS update can be undone by choosing the previous entry at boot.
- **Office-friendly fonts:** Carlito and Caladea, metric-compatible with Calibri and Cambria, so documents keep their layout.

## Repository layout

```
Containerfile            The OS image: base image + build steps
build_files/steps/       Build steps, run in order (packages, branding, services, tests)
system_files/            Files copied over the OS (themes, KDE defaults, services, app list)
design/tokens.json       Colors, type, spacing: single source of truth for the theme
design/generate.py       Turns tokens into KDE color schemes and wallpapers
disk_config/             Installer ISO and VM disk settings
lindle.env               Image name and metadata
Justfile                 Local build commands
docs/plan.md             Build plan and roadmap
```

## Building

CI builds the image on every push to `main` and publishes it to `ghcr.io/sarcque/lindle`. Installer ISOs are built by the **Build disk images** workflow, either by running it manually or by pushing a `v*` tag; the ISO is attached to the workflow run.

Locally, on a machine with `podman` and `just`:

```bash
just build          # build the container image
just build-iso      # build an installer ISO into output/
just run-vm-iso     # boot the ISO in a VM (opens in your browser)
```

After changing `design/tokens.json`, regenerate the theme files:

```bash
pip install pillow           # only needed for wallpapers
python3 design/generate.py
```

## Switching an existing Fedora Atomic machine to Lindle

```bash
sudo bootc switch ghcr.io/sarcque/lindle:latest
```

## One-time setup for maintainers

1. **Make the container package public** in GitHub (Packages → lindle → Package settings) so installs and updates can pull it without logging in.
2. **Signing (recommended before any public release):** generate a key with `cosign generate-key-pair`, add the private key as the `SIGNING_SECRET` Actions secret, and commit `cosign.pub`. Never commit `cosign.key`. Until the secret exists, CI skips signing.

## Credits

Built on the [Universal Blue image template](https://github.com/ublue-os/image-template) (Apache-2.0). Lindle's own code is Apache-2.0; artwork is CC BY-SA 4.0.
