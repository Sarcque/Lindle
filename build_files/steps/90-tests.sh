#!/bin/bash
# Fail the build if anything Lindle depends on is missing from the image.

set -ouex pipefail

grep -q '^NAME="Lindle"' /usr/lib/os-release
grep -q '^AutomaticUpdatePolicy=stage' /etc/rpm-ostreed.conf
test -f /etc/flatpak/remotes.d/flathub.flatpakrepo

for f in /usr/share/flatpak/preinstall.d/*.preinstall; do
    grep -q '^\[Flatpak Preinstall ' "$f"
done
test -f /usr/share/flatpak/preinstall.d/org.onlyoffice.desktopeditors.preinstall
test -f /usr/share/flatpak/preinstall.d/org.gimp.GIMP.preinstall
rpm -q wordcraft gridcraft deckcraft photocraft
for app in wordcraft gridcraft deckcraft photocraft; do
    test -f "/usr/share/applications/ai.storyteller.$app.desktop"
done

test -f /usr/share/color-schemes/LindleLight.colors
test -f /usr/share/color-schemes/LindleDark.colors
test -f /usr/share/plasma/look-and-feel/org.lindle.desktop/metadata.json
test -f /usr/share/plasma/look-and-feel/org.lindle.desktop.dark/metadata.json
test -f /usr/share/wallpapers/Lindle/contents/images/3840x2160.png
test -f /usr/share/wallpapers/Lindle/contents/images_dark/3840x2160.png
grep -q 'LookAndFeelPackage=org.lindle.desktop' /usr/share/kde-settings/kde-profile/default/xdg/kdeglobals
[[ "$(readlink /usr/share/wallpapers/Default)" == Lindle ]]
test -f /usr/lib/plasmalogin/plasmalogin.conf.d/50-lindle.conf
test -f /usr/share/plasma/plasma-welcome/intro-customization.desktop
test -f /usr/share/plasma/plasma-welcome/extra-pages/10-apps.qml
test -f /usr/share/plasma/plasma-welcome/extra-pages/05-layout.qml
test -x /usr/bin/lindle-layout
test -f /usr/share/lindle/layouts/mac.js
test -f /usr/share/icons/Colloid-Light/index.theme
test -f /usr/share/icons/Lindle/index.theme
test -f /usr/share/icons/Lindle-Dark/index.theme
test -f /usr/share/icons/Lindle/scalable/places/start-here.svg
test -f /usr/share/icons/hicolor/scalable/apps/lindle-logo.svg
test -f /usr/share/flatpak/preinstall.d/io.github.kolunmi.Bazaar.preinstall
test -f /etc/bazaar/config.yaml
test -f /etc/bazaar/banner-light.png
grep -q "ai.storyteller.wordcraft" /usr/share/kde-settings/kde-profile/default/xdg/kicker-extra-favoritesrc
grep -q "^NoDisplay=true" /usr/share/applications/org.kde.discover.desktop
[[ "$(plymouth-set-default-theme)" == lindle ]]

# fc-match prints one short line, so grep -q cannot SIGPIPE the producer under pipefail.
fc-match -f "%{family}\n" "Inter" | grep -qi "^Inter"

systemctl is-enabled lindle-flatpak-preinstall.service
systemctl is-enabled rpm-ostreed-automatic.timer
systemctl is-enabled flatpak-system-update.timer

# Essentials: firewall, update notifier, restore, reset, backups, phone link
test -f /usr/share/flatpak/preinstall.d/org.gnome.World.PikaBackup.preinstall
systemctl is-enabled firewalld.service
test -f /usr/lib/systemd/user/lindle-update-notifier.timer
test -x /usr/libexec/lindle-update-notifier
test -x /usr/bin/lindle-restore
test -x /usr/bin/lindle-reset-desktop
desktop-file-validate /usr/share/applications/lindle-restore.desktop
desktop-file-validate /usr/share/applications/lindle-reset-desktop.desktop
rpm -q plasma-firewall kde-connect orca liberation-sans-fonts jq kdialog
grep -q '^application/x-ms-dos-executable=com.usebottles.bottles.desktop' /etc/xdg/mimeapps.list

# NVIDIA edition: the driver's kernel module is installed.
if [[ "${NVIDIA:-N}" == Y ]]; then
    rpm -qa 'kmod-nvidia*' | grep -q .
fi

# Exactly one kernel, so bootc and the boot splash agree on which one boots.
[[ "$(ls /usr/lib/modules | wc -l)" == 1 ]]
