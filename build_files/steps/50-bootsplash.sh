#!/bin/bash
# Lindle boot splash: the Lindle logo with Plymouth's standard spinner.
# The splash lives in the initramfs, so it is rebuilt here.

set -ouex pipefail

theme=/usr/share/plymouth/themes/lindle
# Spinner frames, password dialog and keyboard images come from Fedora's
# "spinner" theme; the logo (watermark.png) is Lindle's own.
cp -n /usr/share/plymouth/themes/spinner/*.png "$theme/"
plymouth-set-default-theme lindle

kver="$(ls /usr/lib/modules)"
[[ "$(wc -w <<<"$kver")" == 1 ]]
export DRACUT_NO_XATTR=1
dracut --no-hostonly --kver "$kver" --reproducible --zstd -v --add ostree \
    -f "/usr/lib/modules/$kver/initramfs.img"
chmod 0600 "/usr/lib/modules/$kver/initramfs.img"
