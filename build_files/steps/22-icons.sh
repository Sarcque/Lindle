#!/bin/bash
# Colloid icons (https://github.com/vinceliuice/Colloid-icon-theme, GPL-3.0)
# are the base of Lindle's icon themes in /usr/share/icons/Lindle and
# Lindle-Dark, which add Lindle's own logo and launcher icons on top.
# Pinned to a release commit so builds are reproducible.

set -ouex pipefail

COLLOID_COMMIT=e3a8f89fac888af715233f8f8ef0a5b1e350f0dd  # tag 2026-08-10

work="$(mktemp -d)"
curl -fsSL --retry 3 -o "$work/colloid.tar.gz" \
    "https://github.com/vinceliuice/Colloid-icon-theme/archive/${COLLOID_COMMIT}.tar.gz"
tar -xzf "$work/colloid.tar.gz" -C "$work"
(cd "$work/Colloid-icon-theme-${COLLOID_COMMIT}" && bash install.sh -d /usr/share/icons)
rm -rf "$work"

for theme in Lindle Lindle-Dark; do
    gtk-update-icon-cache -f "/usr/share/icons/$theme"
done
gtk-update-icon-cache -f /usr/share/icons/hicolor
