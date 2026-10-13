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

# One copy of the qml tool per app: Qt uses the executable's name as the window's
# app id, which has to match the .desktop file for the taskbar icon and grouping.
qml_bin=""
for c in qml6 qml-qt6 /usr/lib64/qt6/bin/qml /usr/lib/qt6/bin/qml qml; do
    if command -v "$c" >/dev/null 2>&1; then
        qml_bin="$(readlink -f "$(command -v "$c")")"
        break
    fi
done
mkdir -p /usr/libexec/lindle
for app in welcome app-center settings; do
    cp -f "$qml_bin" "/usr/libexec/lindle/lindle-$app"
done

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
