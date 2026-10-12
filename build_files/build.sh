#!/bin/bash
# Runs every step in /ctx/steps in order. Each step is a small, focused script.

set -ouex pipefail

for step in /ctx/steps/*.sh; do
    echo "::group:: ===$(basename "$step")==="
    bash "$step"
    echo "::endgroup::"
done
