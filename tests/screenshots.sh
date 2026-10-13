#!/bin/bash
# Boot a Lindle VM disk in QEMU and save screenshots of the login screen, the
# Welcome Center, the desktop, the start menu and the preinstalled apps.
#
#   tests/screenshots.sh <disk.raw> <output-dir>
#
# Drives the VM through QEMU's monitor (sendkey/screendump), so it needs no
# agent inside the guest. Timings are generous because CI runners are slow.

set -euo pipefail

disk="$1"
out="$2"
mkdir -p "$out"
work="$(mktemp -d)"
mon="$work/monitor.sock"

firmware=()
if [[ -f /usr/share/ovmf/OVMF.fd ]]; then
    firmware=(-bios /usr/share/ovmf/OVMF.fd)
fi

qemu-system-x86_64 \
    -machine q35,accel=kvm -cpu host -smp 4 -m 8G \
    -drive "file=$disk,if=virtio,format=raw,snapshot=on" \
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
            ".") monitor "sendkey dot" ;;
            *) monitor "sendkey $ch" ;;
        esac
        sleep 0.1
    done
}

trap 'kill "$(cat "$work/qemu.pid")" 2>/dev/null || true' EXIT

# Boot menu and boot splash, then first boot runs setup services and starts
# Flatpak installs in the background.
sleep 8
shot 00-boot-menu
sleep 12
shot 00-boot-splash
sleep 215
shot 01-login

type_text lindle
monitor "sendkey ret"
sleep 120
# Welcome Center opens by itself on the first login.
shot 02-welcome
monitor "sendkey alt-f4"
sleep 5
shot 03-desktop

# Start menu
monitor "sendkey meta_l"
sleep 5
shot 04-start-menu
monitor "sendkey esc"
sleep 3

open_app() {
    # KRunner (Alt+Space), type the app name or command, Enter.
    monitor "sendkey alt-spc"
    sleep 3
    type_text "$1"
    sleep 3
    monitor "sendkey ret"
    sleep "$3"
    shot "$2"
    monitor "sendkey alt-f4"
    sleep 3
}

open_app "plasma-welcome --pages 10-apps.qml" 05-welcome-apps 15
open_app "plasma-welcome --pages 20-switching.qml" 06-welcome-switching 15
open_app wordcraft 07-wordcraft 30
open_app gridcraft 08-gridcraft 30
open_app photocraft 09-photocraft 30
open_app "system settings" 10-settings 20

# Lindle's own apps.
open_app "lindle-qml app-center" 11-app-center 15
open_app "lindle-qml settings" 12-lindle-settings 15
open_app "lindle-qml welcome" 13-lindle-welcome 15
