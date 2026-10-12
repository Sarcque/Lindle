#!/bin/bash
# Name the OS "Lindle" everywhere the system reports its name.
# ID stays "fedora" so tooling that keys off it keeps working.

set -ouex pipefail

# shellcheck source=/dev/null
source /usr/lib/os-release
LINDLE_VERSION="0.1"

sed -i "s|^NAME=.*|NAME=\"Lindle\"|" /usr/lib/os-release
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"Lindle ${LINDLE_VERSION} (Fedora ${VERSION_ID} base)\"|" /usr/lib/os-release
sed -i "s|^HOME_URL=.*|HOME_URL=\"https://github.com/sarcque/lindle\"|" /usr/lib/os-release
sed -i "s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\"https://github.com/sarcque/lindle/issues\"|" /usr/lib/os-release
if grep -q "^VARIANT_ID=" /usr/lib/os-release; then
    sed -i "s|^VARIANT_ID=.*|VARIANT_ID=lindle|" /usr/lib/os-release
else
    echo "VARIANT_ID=lindle" >> /usr/lib/os-release
fi

fc-cache -f
