// Lindle App Center: a front page of picks. The full store (Discover) is one click away.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../qml/Lindle"

ApplicationWindow {
    id: win
    width: 1040
    height: 720
    minimumWidth: 560
    minimumHeight: 420
    visible: true
    title: "App Center"
    color: Theme.window

    // id is the Flathub app id; opening lindle://install/<id> shows it in the store.
    readonly property var featured: [
        { id: "org.gimp.GIMP", name: "GIMP", line: "Edit photos like a pro", blurb: "The classic open source photo editor, with layers, masks and filters." },
        { id: "org.kde.krita", name: "Krita", line: "Paint and illustrate", blurb: "Digital painting for artists, with brushes that feel natural." },
        { id: "org.kde.kdenlive", name: "Kdenlive", line: "Edit your videos", blurb: "A full video editor with a timeline, titles and effects." }
    ]

    readonly property var sections: [
        { title: "Work", apps: [
            { id: "org.onlyoffice.desktopeditors", name: "ONLYOFFICE", line: "Word, Excel and PowerPoint files" },
            { id: "org.libreoffice.LibreOffice", name: "LibreOffice", line: "A complete office suite" },
            { id: "org.mozilla.Thunderbird", name: "Thunderbird", line: "Email and calendar" },
            { id: "org.kde.okular", name: "Okular", line: "Read, annotate and sign PDFs" },
            { id: "com.bitwarden.desktop", name: "Bitwarden", line: "Passwords, kept safe" },
            { id: "org.telegram.desktop", name: "Telegram", line: "Messages" }
        ]},
        { title: "Create", apps: [
            { id: "org.inkscape.Inkscape", name: "Inkscape", line: "Vector drawing and logos" },
            { id: "org.blender.Blender", name: "Blender", line: "3D modeling and animation" },
            { id: "org.audacityteam.Audacity", name: "Audacity", line: "Record and edit audio" },
            { id: "com.obsproject.Studio", name: "OBS Studio", line: "Record and stream your screen" }
        ]},
        { title: "Play and watch", apps: [
            { id: "org.videolan.VLC", name: "VLC", line: "Plays just about anything" },
            { id: "com.valvesoftware.Steam", name: "Steam", line: "Games" },
            { id: "com.usebottles.bottles", name: "Bottles", line: "Run Windows apps" },
            { id: "org.mozilla.firefox", name: "Firefox", line: "The web browser" }
        ]}
    ]

    // Real app icons come from Flathub; the tinted letter shows while loading or offline.
    function iconUrl(id) {
        return "https://dl.flathub.org/repo/appstream/x86_64/icons/128x128/" + id + ".png"
    }

    // Columns of equal width that fill the window.
    function columnWidth(columns, gap) {
        var n = Math.max(1, Math.min(columns, Math.floor((scroll.availableWidth - 64 + gap) / (280 + gap))))
        return (scroll.availableWidth - 64 - gap * (n - 1)) / n
    }

    function search() {
        if (searchField.text.length)
            Open.go("lindle://store/search/" + encodeURIComponent(searchField.text))
    }

    ScrollView {
        id: scroll
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: scroll.availableWidth
            spacing: 0

            // Top bar: title, search, updates
            RowLayout {
                Layout.fillWidth: true
                Layout.margins: 32
                Layout.bottomMargin: 8
                spacing: 16
                Text {
                    text: "App Center"
                    color: Theme.text
                    font.family: Theme.fontFamily
                    font.pixelSize: 32
                    font.weight: Font.DemiBold
                }
                Item { Layout.fillWidth: true }
                TextField {
                    id: searchField
                    Layout.preferredWidth: 280
                    placeholderText: "Search apps"
                    font.family: Theme.fontFamily
                    font.pixelSize: 14
                    color: Theme.text
                    placeholderTextColor: Theme.textMuted
                    leftPadding: 16
                    background: Rectangle {
                        radius: height / 2
                        color: Theme.view
                        border.width: searchField.activeFocus ? 2 : 1
                        border.color: searchField.activeFocus ? Theme.accent : Theme.border
                    }
                    onAccepted: win.search()
                }
                PillButton { text: "Updates"; onClicked: Open.go("lindle://store/updates") }
            }

            // Featured
            Text {
                Layout.leftMargin: 32
                Layout.topMargin: 12
                text: "Featured"
                color: Theme.textMuted
                font.family: Theme.fontFamily
                font.pixelSize: 13
                font.weight: Font.DemiBold
                font.capitalization: Font.AllUppercase
                font.letterSpacing: 1
            }
            Flow {
                Layout.fillWidth: true
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.topMargin: 12
                spacing: 16
                Repeater {
                    model: win.featured
                    delegate: Card {
                        required property var modelData
                        hoverable: true
                        width: win.columnWidth(3, 16) - 0.5
                        height: 190
                        onClicked: Open.go("lindle://install/" + modelData.id)
                        Accessible.role: Accessible.Button
                        Accessible.name: modelData.name

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 22
                            spacing: 18
                            Glyph {
                                Layout.alignment: Qt.AlignTop
                                implicitWidth: 72
                                implicitHeight: 72
                                letter: modelData.name.charAt(0)
                                source: win.iconUrl(modelData.id)
                            }
                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 4
                                Text {
                                    text: modelData.line
                                    color: Theme.link
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 12
                                    font.weight: Font.DemiBold
                                }
                                Text {
                                    text: modelData.name
                                    color: Theme.text
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 24
                                    font.weight: Font.DemiBold
                                }
                                Text {
                                    Layout.fillWidth: true
                                    text: modelData.blurb
                                    wrapMode: Text.WordWrap
                                    maximumLineCount: 3
                                    elide: Text.ElideRight
                                    color: Theme.textMuted
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 13
                                }
                                Item { Layout.fillHeight: true }
                                GetButton {}
                            }
                        }
                    }
                }
            }

            // Sections of apps
            Repeater {
                model: win.sections
                delegate: ColumnLayout {
                    required property var modelData
                    Layout.fillWidth: true
                    Layout.leftMargin: 32
                    Layout.rightMargin: 32
                    Layout.topMargin: 28
                    spacing: 12

                    Text {
                        text: modelData.title
                        color: Theme.text
                        font.family: Theme.fontFamily
                        font.pixelSize: 20
                        font.weight: Font.DemiBold
                    }
                    Flow {
                        Layout.fillWidth: true
                        spacing: 12
                        Repeater {
                            model: modelData.apps
                            delegate: Card {
                                required property var modelData
                                hoverable: true
                                width: win.columnWidth(3, 12) - 0.5
                                height: 76
                                onClicked: Open.go("lindle://install/" + modelData.id)
                                Accessible.role: Accessible.Button
                                Accessible.name: modelData.name

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 14
                                    spacing: 14
                                    Glyph {
                                        implicitWidth: 48
                                        implicitHeight: 48
                                        letter: modelData.name.charAt(0)
                                        source: win.iconUrl(modelData.id)
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
                                            text: modelData.line
                                            elide: Text.ElideRight
                                            color: Theme.textMuted
                                            font.family: Theme.fontFamily
                                            font.pixelSize: 12
                                        }
                                    }
                                    GetButton {}
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
                    text: "Browse all apps"
                    primary: true
                    onClicked: Open.go("lindle://store/home")
                }
                Text {
                    text: "Thousands more on Flathub. Every app updates in the background."
                    color: Theme.textMuted
                    font.family: Theme.fontFamily
                    font.pixelSize: 13
                }
            }
        }
    }
}
