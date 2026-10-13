import QtQuick
import QtQuick.Controls

// The one button style: pill-shaped, accent when primary.
Button {
    id: control
    property bool primary: false

    implicitHeight: 36
    leftPadding: 18
    rightPadding: 18
    font.family: Theme.fontFamily
    font.pixelSize: 14
    font.weight: Font.Medium

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.primary ? Theme.accentText : Theme.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        radius: height / 2
        color: control.primary
            ? (control.down ? Qt.darker(Theme.accent, 1.15) : control.hovered ? Qt.lighter(Theme.accent, 1.08) : Theme.accent)
            : (control.down ? Theme.header : control.hovered ? Theme.windowAlt : Theme.button)
        border.width: control.primary ? 0 : 1
        border.color: Theme.border
        Behavior on color { ColorAnimation { duration: Theme.durationFast } }
    }
    HoverHandler { cursorShape: Qt.PointingHandCursor }
}
