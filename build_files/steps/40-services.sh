#!/bin/bash
# Background services that make the system look after itself.

set -ouex pipefail

# Install the preinstalled apps from Flathub on first boot (and add any new
# ones listed in later releases). Reads /usr/share/flatpak/preinstall.d.
systemctl enable flatpak-preinstall.service

# Use Flathub only, so apps match upstream and update from one place.
systemctl disable flatpak-add-fedora-repos.service || true
systemctl enable lindle-flatpak-remove-fedora.service

# OS updates download in the background and apply on the next restart
# (AutomaticUpdatePolicy=stage in /etc/rpm-ostreed.conf).
systemctl enable rpm-ostreed-automatic.timer

# Apps update in the background too.
systemctl enable lindle-flatpak-update.timer
