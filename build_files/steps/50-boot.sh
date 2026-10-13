#!/bin/bash
# Boot splash, boot menu theme, and Lindle's own apps wired into the system.

set -ouex pipefail

# Lindle's apps are QML, run by Qt's "qml" tool. Install it if the base lacks it.
have_qml() {
    local c
    for c in qml6 qml-qt6 /usr/lib64/qt6/bin/qml /usr/lib/qt6/bin/qml qml; do
        command -v "$c" >/dev/null 2>&1 && return 0
    done
    return 1
}
have_qml || dnf5 install -y qt6-qtdeclarative-devel

# lindle:// links open settings pages, the store and apps.
update-desktop-database /usr/share/applications

# Boot splash.
rpm -q plymouth-plugin-script >/dev/null 2>&1 || dnf5 install -y plymouth-plugin-script
plymouth-set-default-theme lindle
cat /etc/plymouth/plymouthd.conf || true

# The splash must be inside the initramfs. A failure here keeps the stock
# splash rather than breaking the build, so look for the warning in the log.
kver="$(find /usr/lib/modules -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort -V | tail -n 1)"
if [[ -n "$kver" ]]; then
    if dracut --no-hostonly --kver "$kver" --reproducible --zstd --add ostree -f "/usr/lib/modules/$kver/initramfs.img"; then
        chmod 0600 "/usr/lib/modules/$kver/initramfs.img"
    else
        echo "::warning::Could not rebuild the initramfs, the Lindle boot splash will not show"
    fi
fi

# Boot menu theme is applied on first boot (it lives on /boot, outside the image).
systemctl enable lindle-grub-theme.service
