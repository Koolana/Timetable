import QtQuick 2.12
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.13

Rectangle {
    MouseArea{
        anchors.fill: parent
    }
    property string currentDay: ""
    property string currentWeek: ""
    property string currentDate: ""
    property int indexTodayDay: -1
    property bool isCh: true

    property int animationDuration: 250

    signal nextDateEnd();
    signal prevDateEnd();
    signal notEnd();
    signal changeDate(int num);
    signal menuClicked();

    property string colorFont: "#ffffff";
    property string colorType0: "#2c3e50";
    property string colorType1: "#18bc9c";
    property string colorType2: "#2c3e60";
    property string colorType3: "#6c7eb0";
    property string colorType4: "#888888";

    function clearAll(){
        dateList.clear();
    }

    function addDateToList(data){
        dateList.append({
                            text: data,
                        });
    }

    ListModel{
        id: dataModel
        ListElement{ text: "Пн" }
        ListElement{ text: "Вт" }
        ListElement{ text: "Ср" }
        ListElement{ text: "Чт" }
        ListElement{ text: "Пт" }
        ListElement{ text: "Сб" }
    }

    ListModel{
        id: dateList
    }

    ListModel{
        id: daysList
        ListElement{ text: "Понедельник" }
        ListElement{ text: "Вторник" }
        ListElement{ text: "Среда" }
        ListElement{ text: "Четверг" }
        ListElement{ text: "Пятница" }
        ListElement{ text: "Суббота" }
    }

    function setIndex(ind){
        inViewCombo.currentIndex = ind;

        if(ind == dateList.count - 1){
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
            inViewCombo.currentIndex = dateList.count - 1;
        }

        if(ind == indexTodayDay)
        {
            //bckButton.visible = false
            bckButton.state = "off"
        }else{
            bckButton.state = "on"
        }

        dayField.text = daysList.get(inViewCombo.currentIndex).text + " (" + (isCh ? "ЧС" : "ЗН") + ")\n" + dateList.get(inViewCombo.currentIndex).text;

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

    color: colorType0

    HamburgerMenu {
        id: timeField

        animationDuration: animationDuration

        anchors.leftMargin: 0

//        text: currentTime

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        onButClicked: {
            menuClicked();
        }

//        color: "#ffffff"
    }


    Rectangle{
        id: bckButton
        width: parent.height

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: parent.width / 2

        color: colorType0

        border.width: 3
        border.color: colorType1
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

//        Text{
//            width: parent.width
//            height: parent.height

//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.verticalCenter: parent.verticalCenter
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter

//            color: colorFont

//            text: "Назад"
//        }

        Shape {
            width: parent.width
            height: parent.height

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true

            ShapePath {
                //ashPattern: [ 1, 4 ]
                fillColor: bckButton.color
                strokeWidth: 3
                strokeColor: "#ffffff"

                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: bckButton.width / 2 - 2; startY: bckButton.height / 2 - 12
                PathLine { x: bckButton.width / 2 - 2; y: bckButton.height / 2 - 12 }
                PathLine { x: bckButton.width / 2 - 15; y: bckButton.height / 2 }
                PathLine { x: bckButton.width / 2 - 2; y: bckButton.height / 2 + 12 }
                PathLine { x: bckButton.width / 2 - 15; y: bckButton.height / 2 }
                PathLine { x: bckButton.width / 2 + 10; y: bckButton.height / 2 }
            }
        }

        MouseArea{
            anchors.fill: parent

            onClicked: {
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
    Item {//сделать динамическое отображение дней в кнопках
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        anchors.left: timeField.right
        height: parent.height
        //color: "#ffffff"

        Rectangle {
            id: comboEl
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 220

            border.width: 3
            border.color: inViewCombo.currentIndex == indexTodayDay ? colorType1 : colorType4
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
                text: daysList.get(inViewCombo.currentIndex).text + " (" + (isCh ? "ЧС" : "ЗН") + ")\n" + dateList.get(inViewCombo.currentIndex).text;

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                color: colorFont
            }

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    //console.log("clc");
                    inViewCombo.state = inViewCombo.state == "off" ? "on" : "off"
                }
            }
        }
    }

    ListView {
        id: inViewCombo

        currentIndex: indexTodayDay;
        orientation: ListView.Horizontal

        height: parent.height

        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.bottom

        anchors.leftMargin: 3
        model: dataModel

        anchors.topMargin: -parent.height

        spacing: 3

        z: -1

        state: "off"
        states: [
            State {
                name: "off"
            },

            State {
                name: "on"
                PropertyChanges { target: inViewCombo; anchors.topMargin: 1 }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation { target: inViewCombo; properties: "anchors.topMargin";
                    duration: animationDuration; easing.type: Easing.InOutQuad }
            }
        ]

        delegate: Rectangle {
            width: inViewCombo.width / dataModel.count - 3
            height: parent.height

            color: colorType0

            border.width: inViewCombo.currentIndex == model.index ? 5 : indexTodayDay === model.index ? 3 : 1
            border.color: indexTodayDay === model.index ? colorType1 : colorType4
            radius: 10

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    changeDate(model.index);

                    setIndex(model.index);
                }
            }

            Text{
                id: oneTextField
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                color: colorFont

                text: model.text
            }
        }
    }
}
