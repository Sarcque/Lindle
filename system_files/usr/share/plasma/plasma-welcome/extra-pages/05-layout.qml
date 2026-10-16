// Lindle: pick a Windows-like or Mac-like desktop layout, shown in Welcome
// Center. Clicking a layout applies it right away through lindle-layout.
import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts

import org.kde.kirigami as Kirigami

import org.kde.plasma.welcome as Welcome

Welcome.Page {
    id: root

    heading: "Choose your layout"
    description: "Pick the desktop that feels most like home. You can switch at any time by opening Welcome Center again."

    property string chosen: "windows"

    component Choice: QQC2.AbstractButton {
        id: choice

        required property string layout
        required property string title
        required property string subtitle
        property bool mac: layout === "mac"
        readonly property bool selected: root.chosen === layout

        implicitWidth: Kirigami.Units.gridUnit * 14
        implicitHeight: content.implicitHeight + Kirigami.Units.largeSpacing * 2

        onClicked: {
            root.chosen = layout
            Welcome.Controller.runCommand("lindle-layout " + layout)
        }

        background: Rectangle {
            radius: Kirigami.Units.cornerRadius * 2
            color: choice.selected ? Qt.rgba(Kirigami.Theme.highlightColor.r, Kirigami.Theme.highlightColor.g, Kirigami.Theme.highlightColor.b, 0.12)
                 : choice.hovered ? Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.05) : "transparent"
            border.width: choice.selected ? 2 : 1
            border.color: choice.selected ? Kirigami.Theme.highlightColor
                        : Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.15)
        }

        contentItem: ColumnLayout {
            id: content
            spacing: Kirigami.Units.largeSpacing

            // A small drawing of the desktop.
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: Kirigami.Units.largeSpacing
                implicitWidth: Kirigami.Units.gridUnit * 12
                implicitHeight: Kirigami.Units.gridUnit * 7.5
                radius: Kirigami.Units.cornerRadius
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0; color: "#A9B4F8" }
                    GradientStop { position: 1; color: "#C8BDF7" }
                }

                // Top bar (Mac)
                Rectangle {
                    visible: choice.mac
                    anchors { left: parent.left; right: parent.right; top: parent.top }
                    height: Kirigami.Units.gridUnit * 0.6
                    topLeftRadius: parent.radius
                    topRightRadius: parent.radius
                    color: Qt.rgba(1, 1, 1, 0.8)
                    Rectangle {
                        x: 4; anchors.verticalCenter: parent.verticalCenter
                        width: 6; height: 6; radius: 1.5; color: "#4F73F8"
                    }
                }

                // Taskbar (Windows) or dock (Mac)
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: choice.mac ? icons.implicitWidth + 10 : parent.width - 8
                    height: Kirigami.Units.gridUnit * 0.9
                    radius: 4
                    color: Qt.rgba(1, 1, 1, 0.85)

                    Rectangle {
                        visible: !choice.mac
                        x: 4; anchors.verticalCenter: parent.verticalCenter
                        width: 9; height: 9; radius: 2; color: "#4F73F8"
                    }
                    Row {
                        id: icons
                        anchors.verticalCenter: parent.verticalCenter
                        x: choice.mac ? 5 : 18
                        spacing: 3
                        Repeater {
                            model: ["#F07B3F", "#3D63F5", "#2E9E5B", "#F28C28", "#7A5AF8"]
                            Rectangle { width: 9; height: 9; radius: 2; color: modelData }
                        }
                    }
                    Rectangle {
                        visible: !choice.mac
                        anchors { right: parent.right; rightMargin: 5; verticalCenter: parent.verticalCenter }
                        width: 16; height: 4; radius: 2; color: Qt.rgba(0, 0, 0, 0.3)
                    }
                }
            }

            Kirigami.Heading {
                Layout.alignment: Qt.AlignHCenter
                level: 4
                text: choice.title
            }
            QQC2.Label {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: Kirigami.Units.gridUnit * 12
                Layout.bottomMargin: Kirigami.Units.largeSpacing
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                opacity: 0.7
                text: choice.subtitle
            }
        }
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: Kirigami.Units.gridUnit * 2

        Choice {
            layout: "windows"
            title: "Like Windows"
            subtitle: "A taskbar at the bottom with the start menu on the left"
        }
        Choice {
            layout: "mac"
            title: "Like Mac"
            subtitle: "A menu bar at the top and a dock at the bottom"
        }
    }
}
