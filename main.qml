import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visibility: "FullScreen"
    visible: true

    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle{
        width: parent.width
        height: 50

        anchors.top: parent.top

        color: "green"
    }
}
