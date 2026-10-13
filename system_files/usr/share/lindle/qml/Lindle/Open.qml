// Hands a lindle:// link to the system; /usr/libexec/lindle/lindle-open does the work.
pragma Singleton
import QtQuick

QtObject {
    function go(url) {
        Qt.openUrlExternally(url)
    }
}
