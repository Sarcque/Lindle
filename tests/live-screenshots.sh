#!/bin/bash
# Boot the Lindle Live ISO in QEMU and save screenshots of the boot menu,
# the live desktop and the installer.
#
#   tests/live-screenshots.sh <lindle-live.iso> <output-dir>
#
# Drives the VM through QEMU's monitor, like tests/screenshots.sh.

set -euo pipefail

# Absolute, because qemu -daemonize changes to /.
iso="$(realpath "$1")"
out="$2"
mkdir -p "$out"
work="$(mktemp -d)"
mon="$work/monitor.sock"
qmp="$work/qmp.sock"

firmware=()
if [[ -f /usr/share/ovmf/OVMF.fd ]]; then
    firmware=(-bios /usr/share/ovmf/OVMF.fd)
fi

# An empty disk to install to.
qemu-img create -f qcow2 "$work/disk.qcow2" 64G >/dev/null

qemu-system-x86_64 \
    -machine q35,accel=kvm -cpu host -smp 4 -m 8G \
    -cdrom "$iso" -boot d \
    -drive "file=$work/disk.qcow2,if=virtio,format=qcow2" \
    "${firmware[@]}" \
    -device virtio-vga -display none \
    -nic user,model=virtio-net-pci \
    -device qemu-xhci -device usb-tablet \
    -monitor "unix:$mon,server,nowait" \
    -qmp "unix:$qmp,server,nowait" \
    -daemonize -pidfile "$work/qemu.pid"

monitor() {
    printf '%s\n' "$1" | socat - "UNIX-CONNECT:$mon" >/dev/null
}

shot() {
    monitor "screendump $work/$1.ppm"
    sleep 2
    convert "$work/$1.ppm" "$out/$1.png"
    echo "saved $out/$1.png"
}

# Click at a pixel of the 1280x800 screen, through the USB tablet.
click() {
    local x=$(($1 * 32767 / 1280)) y=$(($2 * 32767 / 800))
    {
        echo '{"execute":"qmp_capabilities"}'
        echo '{"execute":"input-send-event","arguments":{"events":[{"type":"abs","data":{"axis":"x","value":'"$x"'}},{"type":"abs","data":{"axis":"y","value":'"$y"'}}]}}'
        sleep 0.3
        echo '{"execute":"input-send-event","arguments":{"events":[{"type":"btn","data":{"down":true,"button":"left"}}]}}'
        sleep 0.1
        echo '{"execute":"input-send-event","arguments":{"events":[{"type":"btn","data":{"down":false,"button":"left"}}]}}'
        sleep 0.3
    } | socat - "UNIX-CONNECT:$qmp" >/dev/null
}

type_text() {
    local text="$1" i ch
    for ((i = 0; i < ${#text}; i++)); do
        ch="${text:i:1}"
        case "$ch" in
            " ") monitor "sendkey spc" ;;
            "-") monitor "sendkey minus" ;;
            *) monitor "sendkey $ch" ;;
        esac
        sleep 0.1
    done
}

trap 'kill "$(cat "$work/qemu.pid")" 2>/dev/null || true' EXIT

sleep 3
shot 01-boot-menu

# The live system loads from the ISO, so it starts slower than an install.
sleep 180
shot 02-live-desktop

# Open the installer from KRunner, the same as clicking "Install Lindle".
monitor "sendkey alt-spc"
sleep 3
type_text "install lindle"
sleep 3
monitor "sendkey ret"
sleep 60
shot 03-installer

# Walk through the installer up to the disk and encryption choices, without
# installing. "Next" sits at the same spot on every step.
next_step() {
    click 407 757
    sleep 10
}
next_step
shot 04-installer-date
next_step
shot 05-installer-method
next_step
shot 06-installer-storage
