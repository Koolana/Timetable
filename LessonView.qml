import QtQuick 2.12

Rectangle {
    property string timeFieldText: "";
    property string typeFieldText: "";
    property string nameFieldText: "";
    property string cabFieldText: "";

    color: "lightblue"

    Text {
        id: timeField
        width: 50
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 0

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

        text: typeFieldText
    }

    Text {
        id: nameField
        width: parent.width-150
        anchors.left: typeField.right
        anchors.right: cabField.left
        renderType: Text.NativeRendering
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter

        anchors.centerIn: parent

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

        text: cabFieldText
    }
}
