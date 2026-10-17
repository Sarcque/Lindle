#!/bin/bash
# Lindle boot splash: the Lindle logo with Plymouth's standard spinner.
# The splash lives in the initramfs, so it is rebuilt here.

set -ouex pipefail

theme=/usr/share/plymouth/themes/lindle
# Spinner frames, password dialog and keyboard images come from Fedora's
# "spinner" theme; the logo (watermark.png) is Lindle's own.
cp -n /usr/share/plymouth/themes/spinner/*.png "$theme/"
plymouth-set-default-theme lindle

# The installed kernel, from the package database. The base image can carry a
# leftover modules folder from an older kernel; that one belongs to no
# package and would confuse bootc, so it goes.
kver="$(rpm -q kernel-core --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n')"
[[ "$(wc -w <<<"$kver")" == 1 ]]
for dir in /usr/lib/modules/*; do
    if [[ "$(basename "$dir")" != "$kver" ]] && ! rpm -qf "$dir" >/dev/null 2>&1; then
        echo "Removing leftover $dir"
        rm -rf "$dir"
    fi
done
export DRACUT_NO_XATTR=1
dracut --no-hostonly --kver "$kver" --reproducible --zstd -v --add ostree \
    -f "/usr/lib/modules/$kver/initramfs.img"
chmod 0600 "/usr/lib/modules/$kver/initramfs.img"
