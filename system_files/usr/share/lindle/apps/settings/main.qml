// Lindle Settings: a friendly front page for the settings people actually use.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../qml/Lindle"

ApplicationWindow {
    id: win
    width: 920
    height: 680
    minimumWidth: 520
    minimumHeight: 420
    visible: true
    title: "Settings"
    color: Theme.window

    // Each group: a title and tiles. "kcm" is the System Settings module opened by lindle://settings/<kcm>.
    readonly property var groups: [
        { title: "Connect", items: [
            { name: "Wi-Fi & Network", hint: "Connect to the internet", icon: "network-wireless", kcm: "kcm_networkmanagement", tile: Theme.tileAppCenter },
            { name: "Bluetooth", hint: "Headphones, speakers, mice", icon: "preferences-system-bluetooth", kcm: "kcm_bluetooth", tile: Theme.tileAppCenter },
            { name: "Printers & Scanners", hint: "Add and manage printers", icon: "printer", kcm: "kcm_printer_manager", tile: Theme.tileAppCenter },
            { name: "Scan documents", hint: "Use a scanner", icon: "scanner", app: "org.kde.skanpage", tile: Theme.tileAppCenter },
            { name: "Sound", hint: "Volume, speakers, microphone", icon: "audio-volume-high", kcm: "kcm_pulseaudio", tile: Theme.tileAppCenter }
        ]},
        { title: "Your computer", items: [
            { name: "Displays", hint: "Resolution, scaling, night light", icon: "video-display", kcm: "kcm_kscreen", tile: Theme.tileFiles },
            { name: "Appearance", hint: "Light or dark, colors, wallpaper", icon: "preferences-desktop-theme-global", kcm: "kcm_lookandfeel", tile: Theme.tileFiles },
            { name: "Keyboard", hint: "Layouts and shortcuts", icon: "input-keyboard", kcm: "kcm_keyboard", tile: Theme.tileFiles },
            { name: "Mouse & Touchpad", hint: "Pointer speed, scrolling", icon: "input-mouse", kcm: "kcm_mouse", tile: Theme.tileFiles },
            { name: "Power", hint: "Battery, sleep and screen off", icon: "battery", kcm: "kcm_powerdevilprofilesconfig", tile: Theme.tileFiles }
        ]},
        { title: "You", items: [
            { name: "Users", hint: "Your account and password", icon: "preferences-system-users", kcm: "kcm_users", tile: Theme.tileWelcome },
            { name: "Default apps", hint: "Which app opens what", icon: "preferences-desktop-default-applications", kcm: "kcm_componentchooser", tile: Theme.tileWelcome },
            { name: "Updates", hint: "Keep Lindle and your apps current", icon: "system-software-update", store: "updates", tile: Theme.tileWelcome },
            { name: "About Lindle", hint: "Version and hardware", icon: "help-about", kcm: "kcm_about-distro", tile: Theme.tileWelcome }
        ]}
    ]

    function openItem(item) {
        if (item.app)
            Open.go("lindle://app/" + item.app)
        else
            Open.go(item.store ? "lindle://store/" + item.store : "lindle://settings/" + item.kcm)
    }

    ScrollView {
        id: scroll
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: scroll.availableWidth
            spacing: 0

            // Header
            ColumnLayout {
                Layout.fillWidth: true
                Layout.margins: 32
                Layout.bottomMargin: 8
                spacing: 4
                Text {
                    text: "Settings"
                    color: Theme.text
                    font.family: Theme.fontFamily
                    font.pixelSize: 32
                    font.weight: Font.DemiBold
                }
                Text {
                    text: "Everything you are likely to need, in one place."
                    color: Theme.textMuted
                    font.family: Theme.fontFamily
                    font.pixelSize: 15
                }
                RowLayout {
                    Layout.topMargin: 12
                    spacing: 12
                    TextField {
                        id: search
                        Layout.fillWidth: true
                        Layout.maximumWidth: 420
                        placeholderText: "Search settings"
                        font.family: Theme.fontFamily
                        font.pixelSize: 14
                        color: Theme.text
                        placeholderTextColor: Theme.textMuted
                        leftPadding: 16
                        background: Rectangle {
                            radius: height / 2
                            color: Theme.view
                            border.width: search.activeFocus ? 2 : 1
                            border.color: search.activeFocus ? Theme.accent : Theme.border
                        }
                        onAccepted: if (text.length) Open.go("lindle://settings-search/" + encodeURIComponent(text))
                    }
                }
            }

            Repeater {
                model: win.groups
                delegate: ColumnLayout {
                    required property var modelData
                    Layout.fillWidth: true
                    Layout.leftMargin: 32
                    Layout.rightMargin: 32
                    Layout.topMargin: 20
                    spacing: 12

                    Text {
                        text: modelData.title
                        color: Theme.textMuted
                        font.family: Theme.fontFamily
                        font.pixelSize: 13
                        font.weight: Font.DemiBold
                        font.capitalization: Font.AllUppercase
                        font.letterSpacing: 1
                    }
                    Flow {
                        Layout.fillWidth: true
                        spacing: 12
                        Repeater {
                            model: modelData.items
                            delegate: Card {
                                required property var modelData
                                hoverable: true
                                width: 268
                                height: 76
                                onClicked: win.openItem(modelData)
                                Accessible.role: Accessible.Button
                                Accessible.name: modelData.name

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 14
                                    spacing: 14
                                    Glyph {
                                        implicitWidth: 48
                                        implicitHeight: 48
                                        iconName: modelData.icon
                                        letter: modelData.name.charAt(0)
                                        colors: modelData.tile
                                    }
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2
                                        Text {
                                            Layout.fillWidth: true
                                            text: modelData.name
                                            elide: Text.ElideRight
                                            color: Theme.text
                                            font.family: Theme.fontFamily
                                            font.pixelSize: 15
                                            font.weight: Font.DemiBold
                                        }
                                        Text {
                                            Layout.fillWidth: true
                                            text: modelData.hint
                                            elide: Text.ElideRight
                                            color: Theme.textMuted
                                            font.family: Theme.fontFamily
                                            font.pixelSize: 12
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.margins: 32
                Layout.topMargin: 28
                spacing: 12
                PillButton {
                    text: "All settings"
                    onClicked: Open.go("lindle://settings/all")
                }
                Text {
                    text: "Need something more specific? Open the full System Settings."
                    color: Theme.textMuted
                    font.family: Theme.fontFamily
                    font.pixelSize: 13
                }
            }
        }
    }
}
