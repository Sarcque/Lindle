#!/bin/bash
# Lindle's App Center front page is its own app (lindle-app-center). Discover
# stays underneath as the engine for installing and updating apps: it gets
# Lindle's name and icon, and is hidden from menus so there is one "App Center".

set -ouex pipefail

entry=/usr/share/applications/org.kde.discover.desktop

# Inside [Desktop Entry] only (not the [Desktop Action] groups): drop the
# Discover name, its translations and icon, then add Lindle's.
sed -i \
    -e '/^\[Desktop Entry\]/,/^\[/{/^\(Name\|GenericName\|Comment\|Icon\)\(\[[^]]*\]\)\?=/d}' \
    -e '/^\[Desktop Entry\]/a Name=App Center\nGenericName=App Store\nComment=Find, install and update apps\nIcon=lindle-app-center\nNoDisplay=true' \
    "$entry"

# The OS-update notifier shows up as a second "Discover" entry in some menus.
notifier=/usr/share/applications/org.kde.discover.notifier.desktop
if [[ -f "$notifier" ]]; then
    sed -i '/^\[Desktop Entry\]/,/^\[/{/^\(Name\|Icon\)\(\[[^]]*\]\)\?=/d}' "$notifier"
    sed -i '/^\[Desktop Entry\]/a Name=App Center Updates\nIcon=lindle-app-center' "$notifier"
fi

cat "$entry"
