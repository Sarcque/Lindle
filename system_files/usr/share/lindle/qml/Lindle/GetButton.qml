import QtQuick

// The small "Get" pill used on app cards.
Rectangle {
    property string text: "Get"
    implicitWidth: label.implicitWidth + 28
    implicitHeight: 28
    radius: height / 2
    color: Qt.rgba(Theme.accent.r, Theme.accent.g, Theme.accent.b, Theme.dark ? 0.22 : 0.12)
    Text {
        id: label
        anchors.centerIn: parent
        text: parent.text
        color: Theme.link
        font.family: Theme.fontFamily
        font.pixelSize: 13
        font.weight: Font.DemiBold
    }
}
