#!/bin/bash
# Copy Lindle's files (theme, defaults, services) over the base image.

set -ouex pipefail

cp -avf /ctx/system_files/. /
