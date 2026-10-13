#!/bin/bash
# Name the OS "Lindle" everywhere the system reports its name.
# ID stays "fedora" so tooling that keys off it keeps working.

set -ouex pipefail

# shellcheck source=/dev/null
source /usr/lib/os-release
LINDLE_VERSION="0.1"

sed -i "s|^NAME=.*|NAME=\"Lindle\"|" /usr/lib/os-release
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"Lindle ${LINDLE_VERSION} (Fedora ${VERSION_ID} base)\"|" /usr/lib/os-release
sed -i "s|^HOME_URL=.*|HOME_URL=\"https://github.com/sarcque/lindle\"|" /usr/lib/os-release
sed -i "s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\"https://github.com/sarcque/lindle/issues\"|" /usr/lib/os-release
if grep -q "^VARIANT_ID=" /usr/lib/os-release; then
    sed -i "s|^VARIANT_ID=.*|VARIANT_ID=lindle|" /usr/lib/os-release
else
    echo "VARIANT_ID=lindle" >> /usr/lib/os-release
fi

fc-cache -f

# Lindle's wallpaper is the default everywhere a "Default" wallpaper is used
# (new users, the lock screen, the login screen).
ln -sfn Lindle /usr/share/wallpapers/Default
defaults=/usr/lib/plasmalogin/defaults.conf
if [[ -f "$defaults" ]]; then
    sed -i "s|^Image=.*|Image=file:///usr/share/wallpapers/Lindle/contents/images/3840x2160.png|" "$defaults"
    cat "$defaults"
fi

# The Lindle App Store (Bazaar, a Flatpak) replaces Discover in menus. Discover
# stays installed for firmware and system update notifications.
if [[ -f /usr/share/applications/org.kde.discover.desktop ]]; then
    sed -i '/^\[Desktop Entry\]/a NoDisplay=true' /usr/share/applications/org.kde.discover.desktop
fi
