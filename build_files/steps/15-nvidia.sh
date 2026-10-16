#!/bin/bash
# NVIDIA edition only: install the NVIDIA driver with Universal Blue's
# installer, which also sets up Secure Boot signing and the kernel arguments.

set -ouex pipefail

[[ "${NVIDIA:-N}" == Y ]] || exit 0

AKMODNV_PATH=/tmp/akmods-nv-rpms /tmp/akmods-nv-rpms/ublue-os/nvidia-install.sh
