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
test -f /usr/share/plasma/look-and-feel/org.lindle.desktop.dark/metadata.json
test -f /usr/share/wallpapers/Lindle/contents/images/3840x2160.png
test -f /usr/share/wallpapers/Lindle/contents/images_dark/3840x2160.png
grep -q 'LookAndFeelPackage=org.lindle.desktop' /usr/share/kde-settings/kde-profile/default/xdg/kdeglobals
grep -q '^Theme=Lindle' /usr/share/kde-settings/kde-profile/default/xdg/kdeglobals
grep -q '^LOGO=lindle-logo' /usr/lib/os-release
test -f /usr/share/icons/Lindle/index.theme
test -f /usr/share/icons/Lindle/scalable/apps/lindle-app-center.svg
test -f /usr/share/icons/hicolor/scalable/apps/lindle-logo.svg
grep -q '^Name=App Center' /usr/share/applications/org.kde.discover.desktop
grep -q '^Icon=lindle-app-center' /usr/share/applications/org.kde.discover.desktop
[[ "$(readlink /usr/share/wallpapers/Default)" == Lindle ]]
test -f /usr/lib/plasmalogin/plasmalogin.conf.d/50-lindle.conf
test -f /usr/share/plasma/plasma-welcome/intro-customization.desktop
test -f /usr/share/plasma/plasma-welcome/extra-pages/10-apps.qml

test -f /usr/share/plymouth/themes/lindle/lindle.plymouth
test -f /usr/share/plymouth/themes/lindle/logo.png
grep -q '^Theme=lindle' /etc/plymouth/plymouthd.conf
test -f /usr/share/lindle/grub/lindle/theme.txt
test -f /usr/share/sounds/Lindle/stereo/desktop-login.wav
test -f /usr/share/lindle/greeter/kdeglobals
test -f /usr/lib/tmpfiles.d/lindle-greeter.conf
test -f /usr/share/kde-settings/kde-profile/default/xdg/breezerc
for app in welcome app-center settings; do
    test -f "/usr/share/lindle/apps/$app/main.qml"
    test -f "/usr/share/applications/lindle-$app.desktop"
done
grep -q '^NoDisplay=true' /usr/share/applications/org.kde.discover.desktop
bash -n /usr/bin/lindle-qml
bash -n /usr/libexec/lindle/lindle-open
qml_found=false
for c in qml6 qml-qt6 /usr/lib64/qt6/bin/qml /usr/lib/qt6/bin/qml qml; do
    command -v "$c" >/dev/null 2>&1 && qml_found=true
done
$qml_found
systemctl is-enabled lindle-grub-theme.service

rpm -q bluez bluedevil cups cups-filters plasma-print-manager sane-airscan skanpage fwupd
test -f /usr/share/applications/org.kde.skanpage.desktop
systemctl is-enabled bluetooth.service
systemctl is-enabled cups.socket
systemctl is-enabled avahi-daemon.service
systemctl is-enabled fwupd-refresh.timer

test -f /usr/share/plasma/desktoptheme/Lindle/metadata.json
test -f /usr/share/plasma/desktoptheme/Lindle/widgets/panel-background.svg
test -f /usr/share/plasma/desktoptheme/Lindle/dialogs/background.svg
test -f /usr/share/icons/LindleCursors/cursors/left_ptr
grep -q '^name=Lindle' /usr/share/plasma/look-and-feel/org.lindle.desktop/contents/defaults
grep -q '^cursorTheme=LindleCursors' /usr/share/plasma/look-and-feel/org.lindle.desktop/contents/defaults

# fc-match prints one short line, so grep -q cannot SIGPIPE the producer under pipefail.
fc-match -f "%{family}\n" "Inter" | grep -qi "^Inter"

systemctl is-enabled lindle-flatpak-preinstall.service
systemctl is-enabled rpm-ostreed-automatic.timer
systemctl is-enabled flatpak-system-update.timer
