import QtQuick 2.12
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.13

Rectangle {
    property string currentTime: ""
    property string currentDay: ""
    property string currentWeek: ""
    property string currentDate: ""
    property int indexTodayDay: 0
    property bool isCh: true

    property int animationDuration: 250

    signal nextDateEnd();
    signal prevDateEnd();
    signal notEnd();
    signal changeDate(int num);

    function setIndex(ind){
        inViewCombo.currentIndex = ind;

        if(ind == 11){
            nextDateEnd();
        }else{
            if(ind == 0){
                prevDateEnd();
            }else{
                notEnd();
            }
        }

        if(ind > 11){
            inViewCombo.currentIndex = 0;
        }

        if(ind < 0){
            inViewCombo.currentIndex = 11;
        }

        if(ind == indexTodayDay)
        {
            //bckButton.visible = false
            bckButton.state = "off"
        }else{
            bckButton.state = "on"
        }

        offComboBox();
    }

    function setTodayIndex(){
        setIndex(indexTodayDay);
    }

    function offComboBox(){
        inViewCombo.state = "off"
    }

    function nextDate(){
        setIndex(++inViewCombo.currentIndex);
    }

    function prevDate(){
        setIndex(--inViewCombo.currentIndex);
    }

    color: "#2c3e50"

    HamburgerMenu {
        id: timeField

        animationDuration: animationDuration

        anchors.leftMargin: 10

//        text: currentTime

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

//        color: "#ffffff"
    }


    Rectangle{
        id: bckButton
        width: parent.height

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: parent.width / 2

        color: "#2c3e50"

        border.width: 3
        border.color: "#18bc9c"
        radius: 10

        state: "off"
        states: [
            State {
                name: "off"
            },

            State {
                name: "on"
                PropertyChanges { target: bckButton; anchors.rightMargin: 10 }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation { target: bckButton; properties: "visible, anchors.rightMargin";
                    duration: animationDuration; easing.type: Easing.InOutQuad }
            }
        ]

        Text{
            width: parent.width
            height: parent.height

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            color: "#ffffff"

            text: "To\nToday"
        }

        MouseArea{
            anchors.fill: parent

            onClicked: {
                tSys.setDay(indexTodayDay);
                changeDate(indexTodayDay);

                if(indexTodayDay == 0){
                    prevDateEnd();
                }else{
                    notEnd();
                }

                setTodayIndex();
            }
        }
    }

    //Сделать выпадающее меню с выбором дня
    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        anchors.left: timeField.right
        height: parent.height
        //color: "#ffffff"

        ListModel{
            id: dataModel
            ListElement{ text: "Понедельник" }
            ListElement{ text: "Вторник" }
            ListElement{ text: "Среда" }
            ListElement{ text: "Четверг" }
            ListElement{ text: "Пятница" }
            ListElement{ text: "Суббота" }
        }

        Rectangle {
            id: comboEl
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 220

            border.width: 3
            border.color: inViewCombo.currentIndex == indexTodayDay ? "#18bc9c" : "#5c6ea0"
            radius: 10

            color: parent.parent.color

            Shape {
                width: 12
                height: 10

                anchors.rightMargin: 20
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                ShapePath {
                    //ashPattern: [ 1, 4 ]

                    startX: 0; startY: 0
                    PathLine { x: 0; y: 0 }
                    PathLine { x: 6; y: 10 }
                    PathLine { x: 12; y: 0 }
                    PathLine { x: 0; y: 0 }
                }
            }

            Text {
                id: dayField

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: currentDay + " (" + currentWeek + ")\n" + currentDate;

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                color: "#ffffff"
            }

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    //console.log("clc");
                    inViewCombo.state = inViewCombo.state == "off" ? "on" : "off"
                }
            }

            ListView {
                id: inViewCombo

                currentIndex: indexTodayDay;

                visible: true
                height: comboEl.height * dataModel.count
                anchors.top: parent.bottom
                model: dataModel

                anchors.topMargin: -comboEl.height * dataModel.count

                z: -1

                state: "off"
                states: [
                    State {
                        name: "off"
                    },

                    State {
                        name: "on"
                        PropertyChanges { target: inViewCombo; anchors.topMargin: 0 }
                    }
                ]

                transitions: [
                    Transition {
                        PropertyAnimation { target: inViewCombo; properties: "anchors.topMargin";
                            duration: animationDuration; easing.type: Easing.InOutQuad }
                    }
                ]

                delegate: Rectangle {
                    width: comboEl.width
                    height: comboEl.height

                    color: "#2c3e50"
                    radius: 10

                    Rectangle{
                        id: delegDayField
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        color: "#2c3e50"

                        width: 120

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            color: "#ffffff"

                            text: model.text
                        }

                        border.width: 1
                        border.color: "#5c6ea0"
                        radius: 10
                    }

                    Rectangle{
                        anchors.left: delegDayField.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        width: (parent.width - delegDayField.width) / 2

                        color: "#2c3e50"

                        Text{
                            id: oneTextField
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            color: "#ffffff"

                            text: isCh ? "ЧС" : "ЗН"
                        }


                        MouseArea{
                            anchors.fill: parent

                            onClicked: {
                                tSys.setDay(model.index);
                                changeDate(model.index);

                                setIndex(model.index);
                            }
                        }

                        border.width: inViewCombo.currentIndex == model.index ? 5 : indexTodayDay === model.index ? 3 : 1
                        border.color: indexTodayDay === model.index ? "#18bc9c" : "#5c6ea0"
                        radius: 10
                    }

                    Rectangle{
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        width: (parent.width - delegDayField.width) / 2

                        color: "#2c3e50"

                        Text{
                            id: twoTextField
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            color: "#ffffff"

                            text: !isCh ? "ЧС" : "ЗН"
                        }


                        MouseArea{
                            anchors.fill: parent

                            onClicked: {
                                tSys.setDay(model.index + 7);
                                changeDate(model.index + 6);

                                setIndex(model.index + 6);
                            }
                        }

                        border.width: inViewCombo.currentIndex == model.index + 6 ? 5 : 1
                        border.color: "#5c6ea0"
                        radius: 10
                    }
                }
            }
        }
    }
}
