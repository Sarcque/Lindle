# Lindle build plan

Lindle is a Linux desktop OS for people coming from macOS and Windows: modern design, open source, works out of the box, office and photo apps preinstalled.

This plan picks a default for every decision so we can start building now. Each choice says why, and what the fallback is.

## 1. Base: image-based (atomic) Fedora KDE, built with bootc

**Default:** build Lindle as a bootable container image on top of Universal Blue's KDE base image (Fedora Kinoite with codecs and drivers already wired in), using `bootc`.

**Why this beats a classic Mint-style remaster for a small team:**
- The whole OS is defined by one `Containerfile`. Building a release is a CI job, not a hand-maintained apt repo and live-build config.
- Updates are atomic and download in the background. If an update breaks something, the user picks the previous version at boot. This is the single biggest "just works" feature for switchers, who will never open a terminal to fix a broken upgrade.
- Codecs (full ffmpeg), NVIDIA drivers, and hardware enablement are already solved upstream by Universal Blue (the Bazzite/Aurora/Bluefin family), so we spend our time on design and UX instead.
- Apps come as Flatpaks from Flathub, so app updates never touch the base system.

**Fallback if we want to stay closer to Mint:** Ubuntu 26.04 LTS base with snaps removed and Flatpak added, built with `live-build`/`livecd-rootfs`, Calamares installer. More familiar, but we'd own package repos, upgrade scripts, and driver handling ourselves.

## 2. Desktop: KDE Plasma 6, heavily styled

**Default:** KDE Plasma 6.

- It can be made to look and behave like Windows or macOS natively (panels, dock, global menu, window buttons) through Look-and-Feel packages, with no fragile extensions.
- It's the most themeable desktop with a stable theming API, which is what a "10/10 design" needs.
- It has the best Windows-like defaults (taskbar, start menu, right-click behavior, file dialogs).

GNOME (the Zorin approach) looks clean but layout changes depend on extensions that break across releases, and libadwaita apps can't be properly themed. COSMIC (from System76) is promising but younger; revisit it in a year.

**First-run layout picker:** the welcome app asks "Which feels like home?" with three options:
- **Windows-like:** bottom taskbar, start menu, window buttons on the right.
- **Mac-like:** top bar with global menu, bottom dock, buttons on the left, optional Mac keyboard shortcuts (Cmd-style, via Toshy).
- **Lindle:** our own signature layout (floating dock + minimal top bar).

## 3. Design system

One source of truth, generated into every toolkit.

- **Tokens** (`design/tokens.json`): color (light/dark, one accent), type scale, radius, spacing, elevation, motion durations.
- **Generators** turn tokens into: Plasma color scheme, Plasma style (panels/widgets), Aurorae or KDecoration window decoration, Qt application style config, GTK3/GTK4 accent and color overrides (so GTK apps like GIMP match), SDDM login theme, Plymouth boot splash, GRUB theme, Konsole profile.
- **Typography:** Inter for UI, a matching monospace (e.g. JetBrains Mono). Metric-compatible fonts (Carlito, Caladea, Liberation) so Word/Excel documents keep their layout.
- **Icons:** done in 0.1: the generated "Lindle" icon theme (`design/icons.py`) with branded tiles for the system apps, folders and the logo, inheriting Breeze for everything else. Next: cover more app and file-type icons, then commission a full custom set.
- **App Center:** KDE Discover relaunched as "App Center" (own name and icon). Next: a curated front page of picks, and a real Lindle-owned app once Discover's branding limits (window title, appstream name) get in the way.
- **Craft details that make it feel premium:** consistent 8px grid, one corner radius family, subtle blur on panels, real motion curves, a coherent sound set, curated wallpapers, crisp HiDPI defaults (fractional scaling on).

Rule: nothing ships that hasn't been checked in light mode, dark mode, at 100% and 150–200% scaling.

## 4. Preinstalled apps

Chosen for familiarity to switchers. All open source, installed as Flatpaks.

| Need | Default | Why |
|---|---|---|
| Word / Excel / PowerPoint | ONLYOFFICE Desktop Editors | Closest look to Microsoft Office and the best .docx/.xlsx/.pptx fidelity. AGPL. LibreOffice is one click away in the store. |
| Photoshop | GIMP 3, with a Photoshop-style layout and shortcuts preset (PhotoGIMP-style) | Most capable open-source photo editor; the preset removes the biggest switching pain. |
| Illustrator / drawing | Inkscape, Krita | Vector and painting. |
| Browser | Firefox | |
| Email / calendar | Thunderbird | |
| Media | VLC or Haruna, Elisa | Plays everything (codecs in base). |
| PDF | Okular | Annotate and sign. |
| Windows apps | Bottles | Runs many .exe apps when needed. |
| App store | KDE Discover, Flathub only, rebranded | One place for apps and updates. |

## 5. "Just works" checklist

- **Drivers:** NVIDIA via the Universal Blue NVIDIA image variant, picked automatically by the installer when an NVIDIA GPU is detected. Firmware updates via `fwupd` shown in Discover.
- **Codecs:** included in the base image (H.264/H.265/AAC/etc).
- **Updates:** OS and Flatpaks update automatically in the background, apply on next reboot, and can be rolled back from the boot menu. No update prompts during work.
- **Printers and scanners:** CUPS with driverless IPP plus common driver packages.
- **Laptop basics:** Bluetooth, fingerprint (fprintd), power profiles, sleep tested on our hardware matrix.
- **Migration:** welcome app offers to import files, browser bookmarks and Wi‑Fi from a Windows partition or USB drive.
- **Familiar shortcuts:** Ctrl+C/V everywhere, Win/Cmd key opens launcher, screenshot on PrtSc and Cmd/Ctrl+Shift+4.
- **Installer:** Fedora's Anaconda web UI (what bootc ISOs use) restyled with our theme; goal is 5 screens or fewer.
- **Testing:** every build boots in CI (QEMU) and runs automated smoke tests; a small physical hardware matrix (Intel, AMD, NVIDIA laptop, one older machine, one Mac-switcher-style HiDPI laptop) is checked before each release.

## 6. Repo layout (one monorepo to start)

```
lindle/
├── image/
│   ├── Containerfile          # FROM Universal Blue KDE base, adds our layer
│   ├── packages.txt           # system packages added/removed
│   ├── flatpaks.txt           # preinstalled apps
│   ├── system_files/          # /etc and /usr overlays (defaults, configs)
│   └── scripts/               # build-time setup steps
├── design/
│   ├── tokens.json
│   ├── generators/            # tokens -> Plasma, GTK, SDDM, Plymouth themes
│   └── wallpapers/ icons/ sounds/
├── apps/
│   └── welcome/               # first-run app (Qt/QML + Kirigami)
├── iso/                       # installer ISO config and branding
├── tests/                     # boot + smoke tests (QEMU)
├── docs/
└── .github/workflows/         # build image, sign, push to GHCR, build ISO
```

Split into separate repos only when a part gets its own contributors (likely `design` and `welcome` first).

## 7. Roadmap

**Milestone 0.1, "It boots and it's ours" (first concrete milestone)**
- `Containerfile` on the Universal Blue KDE base, with Lindle wallpaper, Inter font, accent color and ONLYOFFICE, GIMP, Firefox preinstalled.
- GitHub Actions builds and signs the image on every push and publishes it to GHCR.
- A downloadable ISO that installs in a VM.
- Done when: a fresh VM installs from the ISO, boots to a Lindle-branded desktop, opens a .docx in ONLYOFFICE and edits a photo in GIMP, and receives an update from a new push.

**0.2, Design system v1:** tokens and generators; full Plasma, GTK, login, boot splash themes; light and dark.

**0.3, Welcome and layouts:** first-run app with layout picker, Mac shortcuts option, migration import, app picks.

**0.4, Hardware and polish:** NVIDIA variant, installer branding, hardware matrix testing, accessibility pass (contrast, screen reader, keyboard navigation).

**0.5, Public alpha:** website, docs, bug tracker, update channels (stable/beta).

**1.0:** after a beta period with real switchers, usability-tested on people who have never used Linux.

## 8. Towards a complete OS identity

Status of each piece, all generated from `design/tokens.json` where possible (`design/system.py`, `design/icons.py`):

| Piece | Status |
|---|---|
| Boot splash (Plymouth) | Done: `lindle` script theme (mark, pulse, progress bar, disk password prompt), baked into the initramfs at build time. |
| Boot menu (GRUB) | Done, applied on first boot by `lindle-grub-theme.service` through `/boot/grub2/custom.cfg`. Needs checking on real UEFI and BIOS machines. |
| Login screen | Colors, accent, font and icons seeded for the login user (`/usr/share/lindle/greeter/kdeglobals`); wallpaper and blur come from Plasma Login. A logo on the login screen needs a custom greeter, not planned yet. |
| Window shadows and animation | Done through Breeze settings (`breezerc`), tinted from the tokens. |
| Plasma style | Done for panels, menus/popups and tooltips: a "Lindle" desktop theme (`design/plasma.py`) with corner radii from the tokens, a hairline border, glass opacity and a soft wide shadow. Everything else falls back to Breeze. Needs checking against screenshots. |
| Window decoration shape | Not done: Breeze's decoration keeps its own corner radius. Needs a custom decoration. |
| Sounds | Done: "Lindle" sound theme, 14 synthesized chimes. |
| Cursors | Partly done: Lindle arrow and text cursors (`design/cursors.py`), the rest still Breeze. |
| Welcome, App Center, Settings | Done as QML apps (`/usr/share/lindle/apps`, run by `lindle-qml`), sharing one theme with the system colors. Welcome does not replace Plasma's Welcome Center on first login yet. |

Lindle's apps open the system through `lindle://` links (`/usr/libexec/lindle/lindle-open`, fixed list of actions). The App Center is a curated front page over Discover, which stays underneath as the install and update engine.

## 9. Things to decide early

- **Name and trademark check** for "Lindle" before the website and branding.
- **License:** our own code GPL-3.0 or MIT; artwork CC BY-SA.
- **Funding and governance:** donations/sponsorships model, and who approves releases.
