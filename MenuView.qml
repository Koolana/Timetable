import QtQuick 2.0

Rectangle {
    id: root
    property int animationDuration: 200
    property int headerHeight: 0

    property string colorFont: "#ffffff";
    property string colorType0: "#2c3e50";
    property string colorType1: "#18bc9c";
    property string colorType2: "#eFaF00";//"#3498db";
    property string colorType3: "#ca3838"//"#6c7eb0";
    property string colorType4: "#888888";

    function changeState(){
        root.state = root.state == "off" ? "on" : "off";
    }

    height: parent.height
    width: 200

    anchors.left: parent.left
    anchors.leftMargin: -width - 2

    color: colorType0

    state: "off"
    states: [
        State {
            name: "off"
        },

        State {
            name: "on"
            PropertyChanges { target: root; anchors.leftMargin: 0 }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation { target: root; properties: "anchors.leftMargin";
                duration: animationDuration; easing.type: Easing.InOutQuad }
        }
    ]

    ListModel {
        id: elsMenu

        ListElement{
            text: "test1";
        }
        ListElement{
            text: "test2";
        }
        ListElement{
            text: "test3";
        }
        ListElement{
            text: "test4";
        }
        ListElement{
            text: "test5";
        }
    }

    ListView {
        id: listElsMenu

        anchors.fill: parent
        anchors.topMargin: headerHeight
        spacing: 0
        model: elsMenu
        interactive: false

        delegate: Rectangle {
            id: delegMenuBut
            width: parent.width
            height: 50

            color: root.color

            Rectangle{
                id: backBut
                anchors.fill: parent

                opacity: 0

                color: "#000000"

                state: "unPressed"
                states: [
                    State {
                        name: "unPressed"
                    },

                    State {
                        name: "pressed"
                        PropertyChanges { target: backBut; opacity: 0.5 }
                    }
                ]

                transitions: [
                    Transition {
                        PropertyAnimation { target: backBut; properties: "opacity";
                            duration: animationDuration; easing.type: Easing.InOutQuad }
                    }
                ]
            }

            Text{
                anchors.leftMargin: 10
                //horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent

                font.pointSize: 15

                color: colorFont
                text: model.text
            }

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    console.log(model.text);
                    backBut.state = "unPressed";
                }

                onPressed: {
                    backBut.state = "pressed";
                }

                onExited: {
                    backBut.state = "unPressed";
                }
            }
        }
    }

    Rectangle {
        id: backEl

        width: parent.width + 4
        height: parent.height + 4
        anchors.leftMargin: - 2
        anchors.topMargin: - 2

        smooth: true

        radius: parent.radius

        z: -1
        opacity: 0.7/*0.7*/
        anchors.left: parent.left
        anchors.top: parent.top
        color: "#000000"
    }
}
