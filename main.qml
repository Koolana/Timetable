import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

//import "qrc:/" //в винде это надо комментить //линухе !//

Window {
    //visibility: "FullScreen"
    visible: true

    width: 450
    height: 800
    title: qsTr("Timetable")

    color: "#5c6ea0"

    Connections {
        target: fSys

//        onSendCurrentLessonToQml:{
//            view.currentIndex = num;
//        }

        onSetDayByNum: {
            mainView.currentIndex = num
        }

        onFinishSendDay: {
            mainView.addPage(mainView.createPage())
            dataModel.clear();
        }

        onSendOneLessonToQml: {//сделать сигнла символизирующий о конце передачи списка или передвавть сам список
            dataModel.append({
                timeText: time,
                typeText: type,
                nameText: name,
                cabText: cab,
                lecturerText: lecturer,
                color: isCur ? "#18bc9c" : "#5c6ea0"/*"#ffffff"*/,
            });
        }
    }

    Connections {
        target: tSys

        onSendFirstInitToQml: {
            header.isCh = isCh
            header.indexTodayDay = indexTodayDay - 1

            header.setTodayIndex();
        }

        onSendCurrentTimeToQml: {
            header.currentTime = time
        }

        onSendDayAndWeekTypeToQml: {
            header.currentDay = day
            header.currentWeek = weekType
            header.currentDate = date
//            dataModel.clear()
            //console.log("change");
        }
    }

    ListModel {
        id: dataModel
    }

    SwipeView{
        id: mainView
        property int curIndexWitouthZero: 0//хз зачем
        property int flag: 0

        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        spacing: 20

        contentItem: ListView {
            model: mainView.contentModel
            interactive: mainView.interactive
            currentIndex: mainView.currentIndex

            spacing: mainView.spacing
            orientation: mainView.orientation
            snapMode: ListView.SnapOneItem
            boundsBehavior: Flickable.StopAtBounds

            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: 0
            preferredHighlightEnd: 0
            highlightMoveDuration: 250

            maximumFlickVelocity: 10 * (mainView.orientation === /*//10 - скорость анимации листания*/Qt.Horizontal ? width : height)
        }

//        Component.onCompleted: {//хз зачем
//            curIndexWitouthZero = mainView.currentIndex
//            curIndexWitouthZero += 1
//            addPage(createPage())
//        }

        onCurrentIndexChanged: {
            //console.log(curIndexWitouthZero - mainView.currentIndex);
            if(curIndexWitouthZero - mainView.currentIndex < 0 && flag > 1){
                tSys.nextDay();
                //console.log("next")
            }else{
                if(curIndexWitouthZero - mainView.currentIndex > 0 && flag > 1){
                    tSys.prevDay();
                    //console.log("prev")
                }
            }

            curIndexWitouthZero = mainView.currentIndex
            flag++;
            header.setIndex(mainView.currentIndex);
        }

//        onCurrentIndexChanged: {
//            console.log("");
//        }

        function addPage(page) {
            for(var i = 0; i < dataModel.count; i++)
            {
                page.addLessonToView(dataModel.get(i));
            }
            addItem(page)
            page.visible = true
        }

        function createPage(){
            var component = Qt.createComponent("ListLessonView.qml");
            var page = component.createObject(mainView, {});
            return page
        }

//        Item{
//            ListLessonView{
//                id: first
////                model: dataModel

//                MouseArea{
//                    anchors.fill: parent

//                    onPressed: {
//                        header.offComboBox();
//                    }
//                }
//            }
//        }
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

        onChangeDate: {
            mainView.flag = 1;
            mainView.currentIndex = num;
            //console.log(num)
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
            //header.nextDate();
            //tSys.nextDay();
            //view.state = "2"
            //view.state = "1"
            mainView.currentIndex++;
            mainView.curIndexWitouthZero = mainView.currentIndex;
            //console.log(mainView.currentIndex)
        }

        onPrevDate: {
            //header.prevDate();
            //tSys.prevDay();
            mainView.currentIndex--;
            mainView.curIndexWitouthZero = mainView.currentIndex;
            //console.log(mainView.currentIndex)
        }
    }
}
