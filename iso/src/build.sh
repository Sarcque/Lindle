#!/usr/bin/bash
# Turn the Lindle image into a live system: boots from a USB stick into the
# Lindle desktop, with an "Install Lindle" button that copies Lindle to the
# disk without needing internet.
#
# Follows Titanoboa's container-native ISO contract and its Bazzite example:
# https://github.com/ublue-os/titanoboa/tree/main/examples

set -exo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
: "${IMAGE:?}"
# What installed systems follow for updates.
UPDATE_REF="${UPDATE_REF:-ghcr.io/sarcque/lindle:latest}"

mkdir -p "$(realpath /root)"
# bwrap (used by flatpak) writes /proc/sys/user/max_user_namespaces.
mount -o remount,rw /proc/sys

### Apps that work in the live session and are copied to the installed system.
# The rest of Lindle's apps install on first boot from Flathub, as usual.
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub org.mozilla.firefox io.github.kolunmi.Bazaar

### The Lindle image itself, so installing needs no internet.
podman pull "${IMAGE}"
if [[ "${IMAGE}" != "${UPDATE_REF}" ]]; then
    podman tag "${IMAGE}" "${UPDATE_REF}"
    podman rmi "${IMAGE}" || :
fi

### Live boot: initramfs that can run from the ISO's squashfs.
dnf install -y dracut-live
kernel=$(find /usr/lib/modules -maxdepth 1 -mindepth 1 -type d -printf '%P\n')
[[ $(wc -l <<<"$kernel") == 1 ]]
DRACUT_NO_XATTR=1 dracut -v --force --zstd --reproducible --no-hostonly \
    --add "dmsquash-live dmsquash-live-autooverlay plymouth" \
    "/usr/lib/modules/${kernel}/initramfs.img" "${kernel}"

# Log in automatically as "liveuser" into Plasma.
dnf install -y livesys-scripts
sed -i "s/^livesys_session=.*/livesys_session=kde/" /etc/sysconfig/livesys
systemctl enable livesys.service livesys-late.service

### Installer
# The installer's web interface runs in a Firefox package, separate from the
# Firefox app people use.
dnf install -y --allowerasing anaconda-live anaconda-webui firefox rsync libblockdev-{btrfs,lvm,dm}
mkdir -p /var/lib/rpm-state

# Lindle logo and colors in the installer.
branding=/usr/share/cockpit/branding/fedora-lindle
install -D -m 0644 /src/branding/branding.css "$branding/branding.css"
install -m 0644 /usr/share/pixmaps/lindle-logo.svg "$branding/logo.svg"

cat >/etc/anaconda/conf.d/90-lindle.conf <<'EOF'
[Network]
default_on_boot = FIRST_WIRED_WITH_LINK

[Bootloader]
menu_auto_hide = True

[Storage]
default_scheme = BTRFS
btrfs_compression = zstd:1

[User Interface]
hidden_spokes =
    NetworkSpoke
    PasswordSpoke
hidden_webui_pages =
    root-password
    network

[Localization]
use_geolocation = False

[Payload]
flatpak_remote = flathub https://dl.flathub.org/repo/
EOF

cat >>/usr/share/anaconda/interactive-defaults.ks <<EOF
ostreecontainer --url=${UPDATE_REF} --transport=containers-storage --no-signature-verification

%post --erroronfail
# Follow Lindle's updates from the registry from now on.
sed -i 's|container-image-reference=.*|container-image-reference=ostree-unverified-registry:${UPDATE_REF}|' /ostree/deploy/default/deploy/*.origin
%end

%post --erroronfail --nochroot
# Keep the apps already on the stick.
deployment="\$(ostree rev-parse --repo=/mnt/sysimage/ostree/repo ostree/0/1/0)"
target="/mnt/sysimage/ostree/deploy/default/deploy/\$deployment.0/var/lib/"
mkdir -p "\$target"
rsync -aAXUHKP --filter='-x security.selinux' /var/lib/flatpak "\$target"
%end
EOF

# Name the installer after Lindle and give it the Lindle logo.
installer=/usr/share/applications/liveinst.desktop
sed -i -e 's/^Name=.*/Name=Install Lindle/' -e '/^Name\[/d' \
    -e 's/^Icon=.*/Icon=lindle-logo/' "$installer"

### Live desktop
# Pin the installer to the dock, right after the start menu.
layout=/usr/share/plasma/look-and-feel/org.lindle.desktop/contents/layouts/org.kde.plasma.desktop-layout.js
sed -i 's|"preferred://browser",|"applications:liveinst.desktop",\n                "preferred://browser",|' "$layout"
grep -q liveinst.desktop "$layout"

# An "Install Lindle" icon on the desktop too, instead of the Welcome Center.
rm -f /etc/xdg/autostart/org.kde.plasma-welcome.desktop
mkdir -p /etc/skel/Desktop /etc/skel/.config
install -m 0755 "$installer" /etc/skel/Desktop/liveinst.desktop
printf '[Wallet]\nEnabled=false\n' >/etc/skel/.config/kwalletrc

# Background jobs that make no sense on a USB stick.
for s in rpm-ostreed-automatic.timer flatpak-system-update.timer lindle-flatpak-preinstall.service; do
    systemctl disable "$s" || :
done

# ostree needs more room in /var/tmp than the live system's /run offers.
rm -rf /var/tmp
mkdir -p /var/tmp
cat >/etc/systemd/system/var-tmp.mount <<'EOF'
[Unit]
Description=Larger /var/tmp for the live system

[Mount]
What=tmpfs
Where=/var/tmp
Type=tmpfs
Options=size=50%%,nr_inodes=1m

[Install]
WantedBy=local-fs.target
EOF
systemctl enable var-tmp.mount

rm -f /etc/localtime
systemd-firstboot --timezone UTC

### What the ISO builder needs from the image.
dnf install -y grub2-efi-x64-cdboot xorriso isomd5sum
mkdir -p /boot/efi
cp -av /usr/lib/efi/*/*/EFI /boot/efi/
cp -v /boot/efi/EFI/fedora/grubx64.efi /boot/efi/EFI/BOOT/fbx64.efi
mkdir -p /usr/lib/bootc-image-builder
cp "$SRC/iso.yaml" /usr/lib/bootc-image-builder/iso.yaml

dnf clean all
