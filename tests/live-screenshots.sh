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
    -monitor "unix:$mon,server,nowait" \
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
