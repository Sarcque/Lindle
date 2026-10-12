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
test -f /usr/share/wallpapers/Lindle/contents/images/3840x2160.png
test -f /usr/share/wallpapers/Lindle/contents/images_dark/3840x2160.png
grep -q 'LookAndFeelPackage=org.lindle.desktop' /usr/share/kde-settings/kde-profile/default/xdg/kdeglobals

# fc-match prints one short line, so grep -q cannot SIGPIPE the producer under pipefail.
fc-match -f "%{family}\n" "Inter" | grep -qi "^Inter"

systemctl is-enabled lindle-flatpak-preinstall.service
systemctl is-enabled rpm-ostreed-automatic.timer
systemctl is-enabled flatpak-system-update.timer
