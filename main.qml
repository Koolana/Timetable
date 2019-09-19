import QtQuick 2.12
import QtQuick.Window 2.12

import "qrc:/"

Window {
    //visibility: "FullScreen"
    visible: true

    width: 640
    height: 480
    title: qsTr("Hello World")

    Connections {
        target: fSys

        onSendOneLessonToQml: {
            dataModel.append({
                timeText: time,
                typeText: type,
                nameText: name,
                cabText: cab,
                lecturerText: lecturer
            });
        }
    }

    Connections {
        target: tSys

        onSendCurrentTimeToQml: {
            header.currentTime = time
        }

        onSendDayAndWeekTypeToQml: {
            header.currentDay = day
            header.currentWeek = weekType
            dataModel.clear()
        }
    }

    ListModel {
        id: dataModel
    }

    Column{
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        spacing: 10

        ListView {
            id: view

            anchors.fill: parent
            spacing: 10
            model: dataModel

            delegate: LessonView {
                width: parent.width
                height: 100

                timeFieldText: model.timeText
                typeFieldText: model.typeText
                nameFieldText: model.nameText
                cabFieldText: model.cabText
            }
        }
    }


    HeaderView{
        id: header

        width: parent.width
        height: 50

        anchors.top: parent.top

        currentTime: "--:--"
        currentDay: "--"
        currentWeek: "--"
    }

    LeftRightControlPanel{
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10

        height: 70
        width: 150
    }
}
