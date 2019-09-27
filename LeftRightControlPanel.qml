import QtQuick 2.12
import QtGraphicalEffects 1.13
import QtQuick.Shapes 1.13

Item {
    id: lrButtons

    property int animationDuration: 150

    signal nextDate();
    signal prevDate();

    function offNextDay(){
        leftBut.state = "big"
        rightBut.state = "off"
    }

    function offPrevDay(){
        leftBut.state = "off"
        rightBut.state = "big"
    }

    function unlockNextDay(){
        rightBut.state = "normal"
    }

    function unlockPrevDay(){
        leftBut.state = "normal"
    }

    Rectangle{
        id: leftBut

        width: parent.width/2 - 5;
        radius: parent.width/4;

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        //anchors.right: parent.right

        state: "normal"
        states: [
            State {
                name: "normal"
                PropertyChanges { target: leftBut; width: parent.width/2 - 5 }
            },

            State {
                name: "big"
                PropertyChanges { target: leftBut; width: parent.width }
            },

            State {
                name: "off"
                PropertyChanges { target: leftBut; z: -1 }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation { target: leftBut; properties: "width";
                    duration: animationDuration; easing.type: Easing.InOutQuad }
            }
        ]

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
                //tSys.prevDay();
                lrButtons.prevDate();
            }
        }
    }

    Rectangle{
        id: rightBut

        width: parent.width/2 - 5;
        radius: parent.width/4;

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        anchors.leftMargin: 10

        color: "White"

        state: "normal"
        states: [
            State {
                name: "normal"
                PropertyChanges { target: rightBut; width: parent.width/2 - 5 }
            },

            State {
                name: "big"
                PropertyChanges { target: rightBut; width: parent.width }
            },

            State {
                name: "off"
                PropertyChanges { target: rightBut; z: -1 }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation { target: rightBut; properties: "width";
                    duration: animationDuration; easing.type: Easing.InOutQuad }
                PropertyAnimation { target: rightBut; properties: "z";
                    duration: animationDuration; easing.type: Easing.InOutQuad }
            }
        ]

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
                //tSys.nextDay();
                lrButtons.nextDate();
            }
        }
    }
}
