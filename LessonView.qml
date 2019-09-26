import QtQuick 2.12

Rectangle {
    property string timeFieldText: "";
    property string typeFieldText: "";
    property string nameFieldText: "";
    property string cabFieldText: "";

    property string backColor: "";

    radius: 10

    Text {
        id: timeField
        width: 50
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 0

        color: "#ffffff"
        text: timeFieldText
    }

    Text {
        id: typeField
        width: 50
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter

        anchors.left: timeField.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 0

        color: "#ffffff"
        text: typeFieldText
    }

    Text {
        id: nameField
        width: parent.width-200
        anchors.left: typeField.right
        anchors.right: cabField.left
        renderType: Text.NativeRendering
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter

        anchors.centerIn: parent

        color: "#ffffff"
        text: nameFieldText
    }

    Text {
        id: cabField
        width: 50
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 20

        color: "#ffffff"
        text: cabFieldText
    }

    Rectangle {
        id: backEl
        color: backColor

        width: parent.width + 20
        height: parent.height
        anchors.leftMargin: - 10

        smooth: true

        z: -1
        opacity: 0.7
        anchors.left: parent.left
        anchors.top: parent.top
    }
}
