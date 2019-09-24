import QtQuick 2.12
import QtGraphicalEffects 1.13
import QtQuick.Shapes 1.13

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

//        Text{
//            anchors.fill: parent
//            renderType: Text.NativeRendering
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
//            anchors.centerIn: parent.Center

//            font.pointSize: 40
//            anchors.bottomMargin: font.pointSize/5
//            text: "<"
//            color: "#666666"
//        }

        Shape {
            width: parent.width
            height: parent.height

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true

            ShapePath {
                //ashPattern: [ 1, 4 ]
                fillColor: leftBut.color
                strokeWidth: 5
                strokeColor: "#666666"

                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: leftBut.width / 2 + 10; startY: leftBut.height / 2 - 15
                PathLine { x: leftBut.width / 2 + 10; y: leftBut.height / 2 - 15 }
                PathLine { x: leftBut.width / 2 - 15; y: leftBut.height / 2 }
                PathLine { x: leftBut.width / 2 + 10; y: leftBut.height / 2 + 15 }
            }
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

//        Text{
//            anchors.fill: parent
//            renderType: Text.NativeRendering
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
//            anchors.centerIn: parent.Center

//            font.pointSize: 40
//            anchors.bottomMargin: font.pointSize/5
//            text: ">"
//            color: "#666666"
//        }

        Shape {
            width: parent.width
            height: parent.height

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true

            ShapePath {
                //ashPattern: [ 1, 4 ]
                fillColor: rightBut.color
                strokeWidth: 5
                strokeColor: "#666666"

                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: rightBut.width / 2 - 10; startY: rightBut.height / 2 - 15
                PathLine { x: rightBut.width / 2 - 10; y: rightBut.height / 2 - 15 }
                PathLine { x: rightBut.width / 2 + 15; y: rightBut.height / 2 }
                PathLine { x: rightBut.width / 2 - 10; y: rightBut.height / 2 + 15 }
            }
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
