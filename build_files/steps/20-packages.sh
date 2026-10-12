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
)

dnf5 install -y "${packages[@]}"

# Firefox comes from Flathub instead, so it updates independently of the OS.
if rpm -q firefox >/dev/null 2>&1; then
    dnf5 remove -y firefox firefox-langpacks
fi
