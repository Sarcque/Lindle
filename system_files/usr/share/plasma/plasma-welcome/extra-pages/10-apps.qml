// Lindle: the preinstalled Storytold Craft apps, shown in Welcome Center.
import QtQuick
import QtQuick.Layouts

import org.kde.kirigami as Kirigami

import org.kde.plasma.welcome as Welcome

Welcome.Page {
    id: root

    title: "Your Apps"
    description: "Lindle comes with a full office and photo suite, so you can get started right away. Each app is free and open source, and they are all pinned to your dock.\n\nClick an app to open it."

    GridLayout {
        anchors.centerIn: parent
        columns: root.width > Kirigami.Units.gridUnit * 36 ? 4 : 2
        columnSpacing: Kirigami.Units.gridUnit * 2
        rowSpacing: Kirigami.Units.gridUnit

        Repeater {
            model: [
                { id: "ai.storyteller.wordcraft", replaces: "Instead of Word" },
                { id: "ai.storyteller.gridcraft", replaces: "Instead of Excel" },
                { id: "ai.storyteller.deckcraft", replaces: "Instead of PowerPoint" },
                { id: "ai.storyteller.photocraft", replaces: "Instead of Photoshop" }
            ]

            delegate: ColumnLayout {
                required property var modelData
                spacing: Kirigami.Units.smallSpacing
                visible: app.exists

                Welcome.ApplicationIcon {
                    Layout.alignment: Qt.AlignHCenter
                    application: Welcome.ApplicationInfo {
                        id: app
                        desktopName: modelData.id
                    }
                    size: Kirigami.Units.gridUnit * 6
                }

                Kirigami.Heading {
                    Layout.alignment: Qt.AlignHCenter
                    level: 3
                    text: app.name
                }

                Kirigami.Heading {
                    Layout.alignment: Qt.AlignHCenter
                    level: 5
                    opacity: 0.7
                    text: modelData.replaces
                }
            }
        }
    }
}
