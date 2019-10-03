import QtQuick 2.12

Rectangle {
    property string timeFieldText: "";
    property string typeFieldText: "";
    property string nameFieldText: "";
    property string cabFieldText: "";

    property string colorFont: "#ffffff";
    property string colorType0: "#2c3e50";
    property string colorType1: "#18bc9c";
    property string colorType2: "#eFaF00";//"#3498db";
    property string colorType3: "#ca3838"//"#6c7eb0";
    property string colorType4: "#888888";

    radius: 10

    Text {
        id: timeField
        width: 50
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 0

        color: colorFont
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

        color: colorFont
        text: typeFieldText
    }

    Text {
        id: nameField
        //width: parent.width-220
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.left: typeField.right
        anchors.right: cabField.left
        renderType: Text.NativeRendering
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter

        anchors.verticalCenter: parent.verticalCenter

        color: colorFont
        text: nameFieldText
    }

    Text {
        id: cabField
        width: 50
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10

        color: colorFont
        text: cabFieldText
    }
}
