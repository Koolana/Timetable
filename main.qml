import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    //visibility: "FullScreen"
    visible: true

    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel {
        id: dataModel
    }

    Column{
        anchors.topMargin: header.height + view.spacing
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        spacing: 10

        ListView {
            id: view

            anchors.fill: parent
            spacing: 10
            model: dataModel

            delegate: Rectangle {
                width: view.width
                height: 100
                color: "blue"

                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    renderType: Text.NativeRendering
                    text: model.index
                }

                Text {
                    anchors.centerIn: parent
                    renderType: Text.NativeRendering
                    text: model.index
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    renderType: Text.NativeRendering
                    text: model.index
                }
            }
        }

        Rectangle {
            id: button

            width: 100
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            border {
                color: "black"
                width: 1
            }

            Text {
                anchors.centerIn: parent
                renderType: Text.NativeRendering
                text: "Add"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: dataModel.append({})
            }
        }
    }


    Rectangle{
        id: header
        width: parent.width
        height: 50

        anchors.top: parent.top

        color: "green"
    }
}
