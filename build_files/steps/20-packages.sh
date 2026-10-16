#!/bin/bash
# System packages. Desktop apps are Flatpaks (see flatpak preinstall files),
# so only things that must live in the OS image belong here.

set -ouex pipefail

packages=(
    # UI and code fonts
    rsms-inter-fonts
    jetbrains-mono-fonts-all
    # Metric-compatible with Calibri and Cambria, so Office documents keep their layout
    google-carlito-fonts
    google-crosextra-caladea-fonts
    # Metric-compatible with Arial, Times New Roman and Courier New
    liberation-sans-fonts
    liberation-serif-fonts
    liberation-mono-fonts
    # Firewall page in System Settings (firewalld is the firewall itself)
    plasma-firewall
    firewalld
    # Backups page in System Settings: scheduled backups to an external drive
    kup
    # Phone link: notifications, files and clipboard between phone and PC
    kde-connect
    # Screen reader
    orca
    # Used by Lindle's update notifier and restore tools
    jq
    kdialog
)

dnf5 install -y "${packages[@]}"

# Firefox comes from Flathub instead, so it updates independently of the OS.
if rpm -q firefox >/dev/null 2>&1; then
    dnf5 remove -y firefox firefox-langpacks
fi
