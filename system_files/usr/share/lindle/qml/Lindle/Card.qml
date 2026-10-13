import QtQuick

// A rounded surface that lifts slightly when hovered.
Rectangle {
    id: card
    property bool hoverable: false
    property alias hovered: hover.hovered
    signal clicked()

    radius: Theme.radiusLarge
    color: hovered && hoverable ? Theme.viewAlt : Theme.view
    border.width: 1
    border.color: hovered && hoverable ? Theme.accent : Theme.border
    Behavior on color { ColorAnimation { duration: Theme.durationFast } }
    Behavior on border.color { ColorAnimation { duration: Theme.durationFast } }

    HoverHandler { id: hover; cursorShape: card.hoverable ? Qt.PointingHandCursor : Qt.ArrowCursor }
    TapHandler { enabled: card.hoverable; onTapped: card.clicked() }
}
