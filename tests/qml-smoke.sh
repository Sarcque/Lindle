#!/bin/bash
# Loads each of Lindle's QML apps headlessly and fails on any QML error.
# Needs Qt 6's "qml" tool and the Qt Quick Controls modules.

set -euo pipefail

qml="$(command -v qml6 qml-qt6 2>/dev/null | head -n 1 || true)"
[[ -n "$qml" ]] || qml=/usr/lib/qt6/bin/qml
root="$(cd "$(dirname "$0")/.." && pwd)"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

for app in welcome app-center settings; do
    cat > "$work/$app.qml" <<EOF
import QtQuick
Item {
    Loader { source: "file://$root/system_files/usr/share/lindle/apps/$app/main.qml" }
    Timer { interval: 1500; running: true; onTriggered: Qt.quit() }
}
EOF
    out="$(QT_QPA_PLATFORM=offscreen QT_QUICK_CONTROLS_STYLE=Basic XDG_RUNTIME_DIR="$work" "$qml" "$work/$app.qml" 2>&1 || true)"
    if grep -Eqi 'error|unavailable|not installed|is not a type|ReferenceError|TypeError' <<<"$out"; then
        echo "QML errors in $app:" >&2
        echo "$out" >&2
        exit 1
    fi
    echo "$app loads cleanly"
done
