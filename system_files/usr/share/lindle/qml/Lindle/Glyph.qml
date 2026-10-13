import QtQuick
import QtQuick.Controls

// An app or setting icon. Calm by default: a soft accent-tinted square with the
// icon (by theme name) or a letter. With "source" it shows the real app icon and
// falls back to the tinted square while loading or offline. With "colors" it
// becomes a gradient tile (used for the Lindle mark only).
Rectangle {
    id: glyph
    property string iconName: ""
    property string letter: ""
    property url source: ""
    property var colors: null

    implicitWidth: 48
    implicitHeight: 48
    radius: width * 0.225
    color: (colors || appIcon.status === Image.Ready) ? "transparent" : Qt.rgba(Theme.accent.r, Theme.accent.g, Theme.accent.b, Theme.dark ? 0.2 : 0.1)
    gradient: colors ? tileGradient : null
    clip: !(appIcon.status === Image.Ready)

    Gradient {
        id: tileGradient
        orientation: Gradient.Horizontal
        GradientStop { position: 0; color: glyph.colors ? glyph.colors[0] : "transparent" }
        GradientStop { position: 1; color: glyph.colors ? glyph.colors[1] : "transparent" }
    }

    Image {
        id: appIcon
        anchors.fill: parent
        source: glyph.source
        visible: status === Image.Ready
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        sourceSize.width: glyph.width * 2
        sourceSize.height: glyph.height * 2
        smooth: true
    }

    Button {
        anchors.centerIn: parent
        visible: glyph.iconName !== "" && appIcon.status !== Image.Ready
        flat: true
        enabled: false
        padding: 0
        display: AbstractButton.IconOnly
        icon.name: glyph.iconName
        icon.color: glyph.colors ? "white" : Theme.accent
        icon.width: glyph.width * 0.5
        icon.height: glyph.width * 0.5
        background: null
    }
    Text {
        anchors.centerIn: parent
        visible: glyph.iconName === "" && appIcon.status !== Image.Ready
        text: glyph.letter
        color: glyph.colors ? "white" : Theme.accent
        font.pixelSize: glyph.width * 0.42
        font.weight: Font.DemiBold
        font.family: Theme.fontFamily
    }
}
