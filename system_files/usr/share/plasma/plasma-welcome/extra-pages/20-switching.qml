// Lindle: a short "where is everything" guide for people coming from
// Windows or macOS, shown in Welcome Center.
import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts

import org.kde.kirigami as Kirigami

import org.kde.plasma.welcome as Welcome

Welcome.Page {
    id: root

    heading: "Coming from Windows or Mac?"
    description: "Most things work the way you are used to. Here is where to find the rest."

    GridLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width, Kirigami.Units.gridUnit * 34)
        columns: 2
        columnSpacing: Kirigami.Units.gridUnit * 2
        rowSpacing: Kirigami.Units.largeSpacing

        Repeater {
            model: [
                ["Start menu or Launchpad", "The Lindle button at the left of the dock, or press the Windows or ⌘ key"],
                ["Search or Spotlight", "Press Alt+Space and start typing an app, file or setting"],
                ["File Explorer or Finder", "Files, pinned to the dock"],
                ["Microsoft Store or App Store", "Discover, pinned to the dock"],
                ["Control Panel or System Settings", "System Settings, in the start menu"],
                ["Windows Update or Software Update", "Nothing to do: updates install in the background and apply on restart"]
            ]

            delegate: Item {
                required property var modelData
                required property int index
                Layout.columnSpan: 2
                Layout.fillWidth: true
                implicitHeight: row.implicitHeight

                RowLayout {
                    id: row
                    anchors.fill: parent
                    spacing: Kirigami.Units.gridUnit

                    QQC2.Label {
                        Layout.preferredWidth: Kirigami.Units.gridUnit * 12
                        Layout.alignment: Qt.AlignTop
                        font.weight: Font.DemiBold
                        wrapMode: Text.Wrap
                        text: modelData[0]
                    }
                    QQC2.Label {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignTop
                        wrapMode: Text.Wrap
                        text: modelData[1]
                    }
                }
            }
        }
    }
}
