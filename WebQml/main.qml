import QtQuick 2.0
import QtQuick.Controls 2.0
import QtWebEngine 1.8
Item {
    width: 800
    height: 600
    WebEngineView {
        anchors.fill: parent
        url: "https://www.zhihu.com"
    }
}

