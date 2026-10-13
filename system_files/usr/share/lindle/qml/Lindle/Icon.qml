import QtQuick
import QtQuick.Shapes

// Lindle's own outline icons: 24 px grid, 1.8 px round strokes, drawn from SVG paths,
// so they look the same on every system and follow the accent color.
Item {
    id: icon
    property string name: ""
    property color color: Theme.accent
    property real strokeWidth: 1.8

    readonly property var paths: ({
        "wifi": "M2 9a15 15 0 0 1 20 0 M5 12.5a10.5 10.5 0 0 1 14 0 M8.5 16a5.5 5.5 0 0 1 7 0 M12 19.5h.01",
        "bluetooth": "M7 7l10 10-5 5V2l5 5L7 17",
        "printer": "M7 8V3h10v5 M7 17H5a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2 M7 14h10v7H7z",
        "scanner": "M3 14h18v6H3z M5 14l2-7h10l2 7 M17 17h.01",
        "sound": "M4 9v6h4l5 4V5L8 9z M16.5 8.5a5 5 0 0 1 0 7 M19 6a8.5 8.5 0 0 1 0 12",
        "display": "M3 4h18v12H3z M8 20h8 M12 16v4",
        "appearance": "M12 3a9 9 0 1 0 0 18a9 9 0 0 0 0-18z M12 3v18",
        "keyboard": "M3 6h18v12H3z M7 10h.01 M11 10h.01 M15 10h.01 M7 14h10",
        "mouse": "M12 3a6 6 0 0 1 6 6v6a6 6 0 0 1-12 0V9a6 6 0 0 1 6-6z M12 3v6",
        "power": "M12 3v8 M7 6.5a7.5 7.5 0 1 0 10 0",
        "users": "M12 12a4 4 0 1 0 0-8a4 4 0 0 0 0 8z M4 21a8 8 0 0 1 16 0",
        "apps": "M4 4h7v7H4z M13 4h7v7h-7z M4 13h7v7H4z M13 13h7v7h-7z",
        "update": "M20 11a8 8 0 1 0-2.3 5.7 M20 4v7h-7",
        "info": "M12 3a9 9 0 1 0 0 18a9 9 0 0 0 0-18z M12 11v6 M12 7.5h.01"
    })

    implicitWidth: 24
    implicitHeight: 24

    Shape {
        width: 24
        height: 24
        scale: icon.width / 24
        transformOrigin: Item.TopLeft
        layer.enabled: true
        layer.samples: 4
        ShapePath {
            strokeColor: icon.color
            strokeWidth: icon.strokeWidth
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin
            PathSvg { path: icon.paths[icon.name] || "" }
        }
    }
}
