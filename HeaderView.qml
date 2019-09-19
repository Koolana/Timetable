import QtQuick 2.12

Rectangle {
    property string currentTime: ""
    property string currentDay: ""
    property string currentWeek: ""

    color: "#2c3e50"

    Text {
        id: timeField

        anchors.leftMargin: 10

        text: currentTime

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        color: "#ffffff"
    }

    Text {
        id: dayField

        text: currentDay + " (" + currentWeek + ")";

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        color: "#ffffff"
    }
}
