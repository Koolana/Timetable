import QtQuick 2.0

Item{
    property int animationDuration: 200
    property int headerHeight: 0
    property int windowWidth: 0
    property int curStateMenu: 5

    function changeState(){
        root.state = root.state == "off" ? "on" : "off";
        backEl.state = backEl.state == "off" ? "on" : "off";
    }

    function setStartMenuState(){
        curStateMenu = 5
        Controller.setMenuField("Назад");
        changedCurrentField(curStateMenu);
        root.state = "off"
        backEl.state = "off"
        //changedState();
    }

    signal changedState();
    signal changedCurrentField(var num);

    anchors.fill: parent

    Rectangle {
        id: root

        property string colorFont: "#ffffff";
        property string colorType0: "#2c3e50";
        property string colorType1: "#18bc9c";
        property string colorType2: "#eFaF00";//"#3498db";
        property string colorType3: "#ca3838"//"#6c7eb0";
        property string colorType4: "#888888";

        height: parent.height
        width: 200

        anchors.left: parent.left
        anchors.leftMargin: -width

        color: colorType0

        state: "off"
        states: [
            State {
                name: "off"
                PropertyChanges { target: root; anchors.leftMargin: -width }
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
                text: "Личный кабинет";
            }
            ListElement{
                text: "Календарь";
            }
            ListElement{
                text: "Лаб. работы";
            }
            ListElement{
                text: "Настройки";
            }
            ListElement{
                text: "Обновить данные";
            }
            ListElement{
                text: "Назад";
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
                        //console.log(model.text);
                        if(model.index != curStateMenu)
                        {
                            backBut.state = "unPressed";
                            Controller.setMenuField(model.text);
                            changedCurrentField(model.index);
                            changeState();
                            changedState();
                        }

                        curStateMenu = model.index;
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
    }

    Rectangle {
        id: actionFieldOfMenu
        width: 20;

        visible: root.state == "off"

        opacity: 0

        anchors.top: parent.top
        anchors.bottom: parent.bottom

        MouseArea{
            property int curMouseX: 0
            property int startMargin: 0
            property int lastMouseX: 0
            property int speed: 0
            anchors.fill: parent

            onPressed: {
                curMouseX = mouseX - actionFieldOfMenu.width
                startMargin = root.anchors.leftMargin
                root.anchors.leftMargin = startMargin + actionFieldOfMenu.width
                backEl.visible = true
                backEl.opacity = 0
            }

            onMouseXChanged: {
                root.anchors.leftMargin = startMargin + ((mouseX - curMouseX) > 0 ? (mouseX - curMouseX) < root.width ? (mouseX - curMouseX) : root.width : 0)
                //console.log(0.7 - Math.abs(root.anchors.leftMargin/root.width))
                backEl.opacity = 0.7 - Math.abs(root.anchors.leftMargin/root.width)
                speed = lastMouseX - mouseX
                lastMouseX = mouseX
            }

            onReleased: {
                if ((mouseX - curMouseX) > root.width/3 || speed < -4){
                    changeState();
                    changedState();
                }else{
                    root.anchors.leftMargin = startMargin
                }

                curMouseX = 0;
                startMargin = 0;
            }
        }
    }

    Rectangle {
        id: backEl

        width: windowWidth;
        height: parent.height

        smooth: true

        z: -1
        opacity: 0/*0.7*/
        visible: false
        anchors.left: parent.left
        anchors.top: parent.top
        color: "#000000"

        state: "off"
        states: [
            State {
                name: "off"
                PropertyChanges { target: backEl; opacity: 0; visible: false}
            },

            State {
                name: "on"
                PropertyChanges { target: backEl; opacity: 0.7; visible: true}
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation { target: backEl; properties: "opacity";
                    duration: animationDuration; easing.type: Easing.InOutQuad }
            }
        ]

        MouseArea{
            property int curMouseX: 0
            property int startMargin: 0
            property int lastMouseX: 0
            property int speed: 0
            anchors.fill: parent

            onPressed: {
                curMouseX = mouseX
                lastMouseX = mouseX
                startMargin = root.anchors.leftMargin
            }

            onMouseXChanged: {
                root.anchors.leftMargin = startMargin + ((mouseX - curMouseX) < 0 ? (mouseX - curMouseX) : 0)
                backEl.opacity = 0.7 - Math.abs(root.anchors.leftMargin/root.width)
                speed = lastMouseX - mouseX
                lastMouseX = mouseX
                //console.log(speed)
            }

            onReleased: {
                //console.log(lastMouseX - mouseX)
                if ((mouseX - curMouseX) < -root.width/3 || speed > 4){
                    changeState();
                    changedState();
                }else{
                    root.anchors.leftMargin = startMargin
                    backEl.opacity = 0.7
                }

                curMouseX = 0;
                startMargin = 0;
            }
        }
    }
}
