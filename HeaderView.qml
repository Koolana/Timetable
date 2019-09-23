import QtQuick 2.12
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Rectangle {
    property string currentTime: ""
    property string currentDay: ""
    property string currentWeek: ""
    property string currentDate: ""
    property int indexTodayDay: 0
    property bool isCh: true

    signal nextDateEnd();
    signal prevDateEnd();
    signal notEnd();

    function nextDate(){
        inViewCombo.currentIndex++;

        if(inViewCombo.currentIndex == 11){
            nextDateEnd();
        }

        if(inViewCombo.currentIndex > 11){
            inViewCombo.currentIndex = 0;
        }

        inViewCombo.visible = false;
    }

    function prevDate(){
        inViewCombo.currentIndex--;

        if(inViewCombo.currentIndex == 0){
            prevDateEnd();
        }

        if(inViewCombo.currentIndex < 0){
            inViewCombo.currentIndex = 11;
        }

        inViewCombo.visible = false;
    }

    color: "#2c3e50"

    Text {
        id: timeField

        anchors.leftMargin: 10

        text: currentTime

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        color: "#ffffff"
    }

//    Text {
//        id: dayField

//        text: currentDay + " (" + currentWeek + ")";

//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.verticalCenter: parent.verticalCenter

//        color: "#ffffff"
//    }

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
            width: 200

            color: parent.parent.color

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
                    inViewCombo.visible =! inViewCombo.visible
                }
            }

            ListView {
                id: inViewCombo

                currentIndex: indexTodayDay;

                visible: false
                height: comboEl.height * dataModel.count
                anchors.top: parent.bottom
                model: dataModel

                delegate: Rectangle {
                    width: comboEl.width + 20
                    height: comboEl.height

                    color: "#2c3e50"

                    Rectangle{
                        id: delegDayField
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        color: parent.color

                        width: 120

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            color: "#ffffff"

                            text: model.text
                        }

                        border.width: 1
                        border.color: "#5c6ea0"
                    }

                    Rectangle{
                        anchors.left: delegDayField.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        width: (parent.width - delegDayField.width) / 2

                        color: parent.color

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
                                //console.log(model.index);
                                //view.currentIndex = model.index
                                //dayField.text = model.text + " (" + ch.text + ")"
                                inViewCombo.visible =! inViewCombo.visible

                                tSys.setDay(model.index);

                                inViewCombo.currentIndex = model.index

                                if(inViewCombo.currentIndex == 0){
                                    prevDateEnd();
                                }else{
                                    notEnd();
                                }
                            }
                        }

                        border.width: inViewCombo.currentIndex == model.index ? 5 : indexTodayDay === model.index ? 3 : 1
                        border.color: indexTodayDay === model.index ? "#18bc9c" : "#5c6ea0"
                    }

                    Rectangle{
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        width: (parent.width - delegDayField.width) / 2

                        color: parent.color

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
                                //console.log(model.index);
                                //view.currentIndex = model.index
                                //dayField.text = model.text + " (" + zn.text + ")"
                                inViewCombo.visible =! inViewCombo.visible

                                tSys.setDay(model.index + 7);

                                inViewCombo.currentIndex = model.index + 6

                                if(inViewCombo.currentIndex == 11){
                                    nextDateEnd();
                                }else{
                                    notEnd();
                                }
                            }
                        }

                        border.width: inViewCombo.currentIndex == model.index + 6 ? 5 : 1
                        border.color: "#5c6ea0"
                    }
                }
            }
        }
    }
}
