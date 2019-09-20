import QtQuick 2.12
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4

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
            ListElement{ text: "Day" }
            ListElement{ text: "Week" }
            ListElement{ text: "Month" }
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

                text: currentDay + " (" + currentWeek + ")";

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                color: "#ffffff"
            }

            MouseArea{
                anchors.fill: parent

                onClicked: {
                    console.log("clc");
                    inViewCombo.visible =! inViewCombo.visible
                }
            }

            ListView {
                id: inViewCombo

                visible: false
                height: comboEl.height * dataModel.count

                anchors.top: parent.bottom
                model: dataModel

                delegate: Rectangle {
                    width: comboEl.width
                    height: comboEl.height

                    color: "#2c3e50"

                    border.width: 1
                    border.color: "#2c3e90"

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        color: "#ffffff"

                        text: model.text
                    }

                    MouseArea{
                        anchors.fill: parent

                        onClicked: {
                            console.log(model.index);
                            view.currentIndex = model.index
                            dayField.text = model.text
                            inViewCombo.visible =! inViewCombo.visible
                        }
                    }
                }
            }
        }
    }
}
