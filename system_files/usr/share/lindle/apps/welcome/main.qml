// Welcome to Lindle: a short, friendly first-run tour.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../qml/Lindle"

ApplicationWindow {
    id: win
    width: 860
    height: 600
    minimumWidth: 640
    minimumHeight: 520
    visible: true
    title: "Welcome to Lindle"
    color: Theme.window

    property int page: 0
    readonly property int lastPage: 4

    // Centered column used by every page.
    component Page: ColumnLayout {
        property string heading
        property string lead
        spacing: 12
        Text {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: parent.heading
            color: Theme.text
            font.family: Theme.fontFamily
            font.pixelSize: 34
            font.weight: Font.DemiBold
            wrapMode: Text.WordWrap
        }
        Text {
            Layout.fillWidth: true
            Layout.maximumWidth: 560
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: Text.AlignHCenter
            text: parent.lead
            color: Theme.textMuted
            font.family: Theme.fontFamily
            font.pixelSize: 16
            wrapMode: Text.WordWrap
        }
    }

    // A choice card with a tile and a label.
    component Choice: Card {
        id: choice
        property string title
        property string hint
        property string letter
        property string iconName: ""
        hoverable: true
        implicitWidth: 168
        implicitHeight: 150
        Accessible.role: Accessible.Button
        Accessible.name: title
        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width - 24
            spacing: 8
            Glyph {
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: 56
                implicitHeight: 56
                letter: choice.letter
                iconName: choice.iconName
            }
            Text {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: choice.title
                color: Theme.text
                font.family: Theme.fontFamily
                font.pixelSize: 15
                font.weight: Font.DemiBold
            }
            Text {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: choice.hint
                color: Theme.textMuted
                font.family: Theme.fontFamily
                font.pixelSize: 12
                wrapMode: Text.WordWrap
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 32
        spacing: 16

        StackLayout {
            id: stack
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: win.page

            // 0: hello
            Item {
                ColumnLayout {
                    anchors.centerIn: parent
                    width: Math.min(parent.width, 640)
                    spacing: 24
                    Glyph {
                        Layout.alignment: Qt.AlignHCenter
                        implicitWidth: 112
                        implicitHeight: 112
                        colors: Theme.tileBrand
                        // The Lindle mark: an L.
                        Rectangle { x: parent.width * 0.344; y: parent.height * 0.25; width: parent.width * 0.11; height: parent.height * 0.5; radius: width / 2; color: "white" }
                        Rectangle { x: parent.width * 0.344; y: parent.height * 0.64; width: parent.width * 0.33; height: parent.width * 0.11; radius: height / 2; color: "white" }
                    }
                    Page {
                        Layout.fillWidth: true
                        heading: "Welcome to Lindle"
                        lead: "A calm, modern desktop that works out of the box. Let's spend a minute making it yours."
                    }
                }
            }

            // 1: look
            Item {
                Page {
                    anchors.centerIn: parent
                    width: Math.min(parent.width, 640)
                    heading: "Pick your look"
                    lead: "Light or dark. You can change this any time in Settings."
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 16
                        spacing: 20
                        Repeater {
                            model: [
                                { name: "Light", hint: "Bright and clean", url: "lindle://look/light", bg: "#F4F5F8", fg: "#1A1C22" },
                                { name: "Dark", hint: "Easy on the eyes", url: "lindle://look/dark", bg: "#1B1C21", fg: "#ECEDF1" }
                            ]
                            delegate: Card {
                                id: lookCard
                                required property var modelData
                                hoverable: true
                                implicitWidth: 230
                                implicitHeight: 190
                                onClicked: Open.go(modelData.url)
                                Accessible.role: Accessible.Button
                                Accessible.name: modelData.name
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 14
                                    spacing: 10
                                    // A tiny window in this look.
                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        radius: Theme.radiusMedium
                                        color: lookCard.modelData.bg
                                        border.width: 1
                                        border.color: Theme.border
                                        Rectangle { x: 14; y: 14; width: parent.width * 0.5; height: 10; radius: 5; color: lookCard.modelData.fg; opacity: 0.85 }
                                        Rectangle { x: 14; y: 34; width: parent.width * 0.7; height: 8; radius: 4; color: lookCard.modelData.fg; opacity: 0.3 }
                                        Rectangle { x: 14; y: 50; width: parent.width * 0.4; height: 8; radius: 4; color: lookCard.modelData.fg; opacity: 0.3 }
                                        Rectangle { anchors.right: parent.right; anchors.bottom: parent.bottom; anchors.margins: 14; width: 54; height: 22; radius: 11; color: Theme.accent }
                                    }
                                    Text {
                                        Layout.alignment: Qt.AlignHCenter
                                        text: lookCard.modelData.name
                                        color: Theme.text
                                        font.family: Theme.fontFamily
                                        font.pixelSize: 15
                                        font.weight: Font.DemiBold
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // 2: connect
            Item {
                Page {
                    anchors.centerIn: parent
                    width: Math.min(parent.width, 640)
                    heading: "Get connected"
                    lead: "Wi-Fi, headphones and printers all work from here. Pair or add them now, or skip and do it later."
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 16
                        spacing: 16
                        Choice { title: "Wi-Fi"; hint: "Join a network"; letter: "W"; iconName: "wifi"; onClicked: Open.go("lindle://settings/kcm_networkmanagement") }
                        Choice { title: "Bluetooth"; hint: "Headphones, speakers"; letter: "B"; iconName: "bluetooth"; onClicked: Open.go("lindle://settings/kcm_bluetooth") }
                        Choice { title: "Printers"; hint: "Add a printer"; letter: "P"; iconName: "printer"; onClicked: Open.go("lindle://settings/kcm_printer_manager") }
                    }
                }
            }

            // 3: apps
            Item {
                Page {
                    anchors.centerIn: parent
                    width: Math.min(parent.width, 720)
                    heading: "Your apps"
                    lead: "WordCraft, GridCraft, DeckCraft and PhotoCraft are ready on your taskbar. Need more? The App Center has thousands."
                    RowLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 16
                        spacing: 16
                        Choice { title: "WordCraft"; hint: "Documents"; letter: "W"; onClicked: Open.go("lindle://app/ai.storyteller.wordcraft") }
                        Choice { title: "GridCraft"; hint: "Spreadsheets"; letter: "G"; onClicked: Open.go("lindle://app/ai.storyteller.gridcraft") }
                        Choice { title: "DeckCraft"; hint: "Presentations"; letter: "D"; onClicked: Open.go("lindle://app/ai.storyteller.deckcraft") }
                        Choice { title: "PhotoCraft"; hint: "Photos"; letter: "P"; onClicked: Open.go("lindle://app/ai.storyteller.photocraft") }
                    }
                    PillButton {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 12
                        text: "Open the App Center"
                        onClicked: Open.go("lindle://app/lindle-app-center")
                    }
                }
            }

            // 4: done
            Item {
                Page {
                    anchors.centerIn: parent
                    width: Math.min(parent.width, 640)
                    heading: "You're all set"
                    lead: "Lindle keeps itself up to date in the background, and a bad update can be undone from the boot menu. Enjoy."
                }
            }
        }

        // Footer: progress dots, back and next.
        RowLayout {
            Layout.fillWidth: true
            PillButton {
                text: "Back"
                visible: win.page > 0
                onClicked: win.page--
            }
            Item { Layout.fillWidth: true; visible: win.page === 0 }
            Item { Layout.fillWidth: true; visible: win.page > 0 }
            Row {
                spacing: 8
                Repeater {
                    model: win.lastPage + 1
                    delegate: Rectangle {
                        required property int index
                        width: index === win.page ? 22 : 8
                        height: 8
                        radius: 4
                        color: index === win.page ? Theme.accent : Theme.border
                        Behavior on width { NumberAnimation { duration: Theme.durationNormal; easing.type: Easing.OutCubic } }
                    }
                }
            }
            Item { Layout.fillWidth: true }
            PillButton {
                text: win.page === 0 ? "Get started" : win.page === win.lastPage ? "Start using Lindle" : "Continue"
                primary: true
                onClicked: win.page === win.lastPage ? Qt.quit() : win.page++
            }
        }
    }
}
