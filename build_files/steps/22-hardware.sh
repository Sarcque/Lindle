#!/bin/bash
# Things people expect to work the moment they plug them in or pair them:
# Bluetooth headsets and mice, printers, scanners, firmware and OS updates.
# Most of this already ships in the base image; installing it here makes sure
# a base change can never silently remove it, and the tests below check it.

set -ouex pipefail

core=(
    # Bluetooth: the stack and KDE's pairing UI
    bluez
    bluedevil
    # Printing: CUPS with driverless (IPP Everywhere) printing, KDE's printer UI,
    # network discovery through Avahi, and common driver sets
    cups
    cups-filters
    plasma-print-manager
    avahi
    nss-mdns
    gutenprint-cups
    hplip
    # Scanning: driverless network scanners and USB scanner drivers, plus a scan app
    sane-airscan
    sane-backends-drivers-scanners
    skanpage
    # Firmware updates, shown in the App Center updates page
    fwupd
)
dnf5 install -y "${core[@]}"

# Nice to have; skipped when the base's repositories do not carry them.
dnf5 install -y --skip-unavailable pipewire-codec-aptx || true

systemctl enable bluetooth.service
systemctl enable cups.socket
systemctl enable avahi-daemon.service
systemctl enable fwupd-refresh.timer
