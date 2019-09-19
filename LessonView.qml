import QtQuick 2.12

Rectangle {
    property string timeFieldText: "";
    property string typeFieldText: "";
    property string nameFieldText: "";
    property string cabFieldText: "";
    property int indexIn: 0;
    property int curIndex: 0;

    color: indexIn == curIndex ? "#18bc9c" : "#3498db"

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
}
