#!/usr/bin/bash
# Temporary: find out why the Welcome Center extra pages come up empty.
set -uo pipefail
strings /usr/bin/plasma-welcome | grep -E "extra-pages|intro-customization"
ls -la /usr/share/plasma/plasma-welcome/ /usr/share/plasma/plasma-welcome/extra-pages/
for p in 10-apps.qml 20-switching.qml; do
    echo "=== $p"
    HOME=/tmp/welcome-home QT_QPA_PLATFORM=offscreen QT_LOGGING_RULES="*.debug=false;qml.debug=true;js.debug=true" \
        timeout 20 plasma-welcome --pages "$p" 2>&1 | head -60
done
echo "=== Welcome page"
HOME=/tmp/welcome-home QT_QPA_PLATFORM=offscreen timeout 20 plasma-welcome 2>&1 | head -60
rm -rf /tmp/welcome-home
true
