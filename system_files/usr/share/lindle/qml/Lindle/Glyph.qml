import QtQuick
import QtQuick.Controls

// A rounded gradient tile with an icon (by theme name) or, failing that, a letter.
Rectangle {
    id: glyph
    property string iconName: ""
    property string letter: ""
    property var colors: Theme.tileBrand

    implicitWidth: 48
    implicitHeight: 48
    radius: width * 30 / 128
    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0; color: glyph.colors[0] }
        GradientStop { position: 1; color: glyph.colors[1] }
    }

    Button {
        anchors.centerIn: parent
        visible: glyph.iconName !== ""
        flat: true
        enabled: false
        padding: 0
        display: AbstractButton.IconOnly
        icon.name: glyph.iconName
        icon.color: "white"
        icon.width: glyph.width * 0.5
        icon.height: glyph.width * 0.5
        background: null
    }
    Text {
        anchors.centerIn: parent
        visible: glyph.iconName === ""
        text: glyph.letter
        color: "white"
        font.pixelSize: glyph.width * 0.46
        font.weight: Font.DemiBold
        font.family: Theme.fontFamily
    }
}
