#!/bin/bash
# Background services that make the system look after itself.
# The base image already uses Flathub as its only app source and enables
# background app updates (flatpak-system-update.timer).

set -ouex pipefail

# Install the preinstalled apps from Flathub on first boot (and add any new
# ones listed in later releases). Reads /usr/share/flatpak/preinstall.d.
systemctl enable lindle-flatpak-preinstall.service

# OS updates download in the background and apply on the next restart
# (AutomaticUpdatePolicy=stage in /etc/rpm-ostreed.conf).
systemctl enable rpm-ostreed-automatic.timer
