import QtQuick 2.12
import QtQuick.Window 2.12

//import "qrc:/" //в винде это надо комментить //линухе !//

Window {
    //visibility: "FullScreen"
    visible: true

    width: 450
    height: 800
    title: qsTr("Timetable")

    Connections {
        target: fSys

//        onSendCurrentLessonToQml:{
//            view.currentIndex = num;
//        }

        onSendOneLessonToQml: {
            dataModel.append({
                timeText: time,
                typeText: type,
                nameText: name,
                cabText: cab,
                lecturerText: lecturer,
                color: isCur ? "#18bc9c" : "#ffffff",
            });
        }
    }

    Connections {
        target: tSys

        onSendFirstInitToQml: {
            header.isCh = isCh
            header.indexTodayDay = indexTodayDay - 1

//            if(indexTodayDay == 1){
//                lrButtons.offPrevDay();
//            }

            header.setTodayIndex();
        }

        onSendCurrentTimeToQml: {
            header.currentTime = time
        }

        onSendDayAndWeekTypeToQml: {
            header.currentDay = day
            header.currentWeek = weekType
            header.currentDate = date
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
                id: lessonView
                width: parent.width
                height: 120

                color: {
                    if( model.typeText === "(лек)"){
                        "#18bc9c";
                    }else{
                        if( model.typeText === "(сем)")
                        {
                            "#3498db"
                        }else{
                            "#dddddd"
                        }
                    }
                }
                //border.color: model.color
                backColor: model.color

                timeFieldText: model.timeText
                typeFieldText: model.typeText
                nameFieldText: model.nameText
                cabFieldText: model.cabText

                MouseArea {//выделение объекта ListView при нажатии
                    anchors.fill: parent

                    onClicked: {
                        header.offComboBox();
                        //view.currentIndex = index;
                    }

                    onPressed: {
                        header.offComboBox();
                    }
                }
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
        currentDate: "--"

        onNextDateEnd: {
            lrButtons.offNextDay();
        }

        onPrevDateEnd: {
            lrButtons.offPrevDay();
        }

        onNotEnd: {
            lrButtons.unlockNextDay();
            lrButtons.unlockPrevDay();
        }
    }

//    BackButton{
//        id: bckButton

//        anchors.right: parent.right
//        anchors.bottom: lrButtons.top
//        anchors.rightMargin: 10
//        anchors.bottomMargin: 10

//        height: 70
//        width: 70

//        indexTodayDay: header.indexTodayDay

//        onPrevDateEnd: {
//            lrButtons.offPrevDay();

//            header.setTodayIndex();
//            header.offComboBox();
//        }

//        onNotEnd: {
//            lrButtons.unlockNextDay();
//            lrButtons.unlockPrevDay();

//            header.setTodayIndex();
//            header.offComboBox();
//        }
//    }

    LeftRightControlPanel{
        id: lrButtons

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10

        height: 70
        width: 150

        onNextDate: {
            header.nextDate();
        }

        onPrevDate: {
            header.prevDate();
        }
    }
}
