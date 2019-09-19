import QtQuick 2.12
import QtGraphicalEffects 1.13

Item {
    Rectangle{
        id: leftBut

        width: parent.width/2 - 5;
        radius: parent.width/4;

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        color: "White"

        Text{
            anchors.fill: parent
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent.Center

            font.pointSize: 40
            anchors.bottomMargin: font.pointSize/4
            text: "<"
        }

        Rectangle {
            color: "black"

            width: parent.width + 4
            height: parent.height + 4
            anchors.leftMargin: -2
            anchors.topMargin: -2

            smooth: true

            z: -1
            opacity: 0.3
            radius: parent.radius
            anchors.left: parent.left
            anchors.top: parent.top
        }

        MouseArea{
            anchors.fill: parent

            onClicked: {
                tSys.prevDay();
            }
        }
    }

    Rectangle{
        id: rightBut

        radius: parent.width/4;

        anchors.left: leftBut.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.leftMargin: 10

        color: "White"

        Text{
            anchors.fill: parent
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent.Center

            font.pointSize: 40
            anchors.bottomMargin: font.pointSize/4
            text: ">"
        }

        Rectangle {
            color: "black"

            width: parent.width + 4
            height: parent.height + 4
            anchors.leftMargin: -2
            anchors.topMargin: -2

            smooth: true

            z: -1
            opacity: 0.3
            radius: parent.radius
            anchors.left: parent.left
            anchors.top: parent.top
        }

        MouseArea{
            anchors.fill: parent

            onClicked: {
                tSys.nextDay();
            }
        }
    }
}
