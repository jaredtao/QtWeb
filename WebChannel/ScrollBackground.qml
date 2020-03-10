import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: root
    property real scrollSpeed: 0

    Image {
        id: image1
        source: "qrc:/track.png"
        sourceSize.width: 178
        sourceSize.height: 656
        width: root.width
        height: root.width /  178 * 656
        Component.onCompleted:  {
            y = root.height - height
        }
    }
    Image {
        id: image2
        source: "qrc:/track.png"
        sourceSize.width: 178
        sourceSize.height: 656
        width: root.width
        height: root.width /  178 * 656
    }
    SequentialAnimation {
        running: scrollSpeed > 0
        loops: -1

    }
}
