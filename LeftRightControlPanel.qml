import QtQuick 2.12
import QtGraphicalEffects 1.13

Item {
    id: lrButtons
    signal nextDate();
    signal prevDate();

    function offNextDay(){
        leftBut.anchors.right = lrButtons.right
        leftBut.width = lrButtons.width

        rightBut.visible = false;
        unlockPrevDay();
    }

    function offPrevDay(){
        rightBut.anchors.left = lrButtons.left
        rightBut.width = lrButtons.width

        rightBut.anchors.leftMargin = 0

        leftBut.visible = false;
        unlockNextDay();
    }

    function unlockNextDay(){
        leftBut.anchors.right = undefined
        leftBut.width = lrButtons.width / 2 - 5

        rightBut.visible = true;
    }

    function unlockPrevDay(){
        rightBut.anchors.left = undefined
        rightBut.width = lrButtons.width/2 - 5

        leftBut.visible = true;
    }

    Rectangle{
        id: leftBut

        width: parent.width/2 - 5;
        radius: parent.width/4;

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        //anchors.right: parent.right

        color: "White"

        Text{
            anchors.fill: parent
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent.Center

            font.pointSize: 40
            anchors.bottomMargin: font.pointSize/5
            text: "<"
            color: "#666666"
        }

        Rectangle {
            color: "#444444"

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
                lrButtons.prevDate();

                unlockNextDay();
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
            anchors.bottomMargin: font.pointSize/5
            text: ">"
            color: "#666666"
        }

        Rectangle {
            color: "#444444"

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
                lrButtons.nextDate();

                unlockPrevDay();
            }
        }
    }
}
