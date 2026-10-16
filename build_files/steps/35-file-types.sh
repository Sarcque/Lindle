#!/bin/bash
# Default apps for file types people bring from Windows.

set -ouex pipefail

# Double-clicking a Windows program (.exe, .msi) opens it in Bottles.
list=/etc/xdg/mimeapps.list
grep -q '^\[Default Applications\]' "$list" 2>/dev/null || printf '[Default Applications]\n' >>"$list"
for type in \
    application/x-ms-dos-executable \
    application/x-msdownload \
    application/vnd.microsoft.portable-executable \
    application/x-msi; do
    sed -i "/^\[Default Applications\]/a ${type}=com.usebottles.bottles.desktop" "$list"
done
