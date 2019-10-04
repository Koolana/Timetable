import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

//import "qrc:/" //в винде это надо комментить //линухе !//

Window {
    id: appWindow

    property string colorFont: "#ffffff";
    property string colorType0: "#2c3e50";
    property string colorType1: "#18bc9c";
    property string colorType2: "#3498db";
    property string colorType3: "#6c7eb0";
    property string colorType4: "#888888";
    //visibility: "FullScreen"
    visible: true

    width: 450
    height: 800
    title: qsTr("Timetable")

    color: colorType0

    Connections {
        target: Controller

        onFinishSendDayToQml: {
            mainView.addPage(mainView.createPage())
            dataModel.clear();
        }

        onSendOneLessonToQml: {
            dataModel.append({
                                 timeText: time,
                                 typeText: type,
                                 nameText: name,
                                 cabText: cab,
                                 lecturerText: lecturer,
                             });
        }

        onSendDayNumberToQml: {
            //console.log(num);
            header.indexTodayDay = num
            mainView.currentIndex = num
            //header.reDrawTextFields();
            header.setIndex(num);
        }

        onSendDateToQml: {
            header.addDateToList(date, dateLongName, dateShortName, isCh)
        }

        onSendClearAllToQml: {
            header.clearAll();

            while(mainView.count)
            {
                mainView.removeItem(mainView.itemAt(0));
            }

            header.indexTodayDay = 0
            mainView.currentIndex = 0
            //header.isCh = true
        }
    }

    ListModel {
        id: dataModel
    }

    SwipeView{
        id: mainView
//        property int curIndexWitouthZero: 0
//        property int flag: 0

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

        onCurrentIndexChanged: {
//            if(curIndexWitouthZero - mainView.currentIndex < 0 && flag > 1){
//                //console.log("next")
//            }else{
//                if(curIndexWitouthZero - mainView.currentIndex > 0 && flag > 1){
//                    //console.log("prev")
//                }
//            }

//            curIndexWitouthZero = mainView.currentIndex
//            flag++;
            header.setIndex(mainView.currentIndex);
        }

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
    }

    MenuView{
        id: menuView

        onChangedState: {
            header.changeHamburger();
        }

        headerHeight: header.height
        windowWidth: parent.width
    }

    HeaderView{
        id: header

        height: 50

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

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
            //mainView.flag = 1;
            mainView.currentIndex = num;
            //console.log(num)
        }

        onMenuClicked: {
            menuView.changeState();
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
            //mainView.curIndexWitouthZero = mainView.currentIndex;
            //console.log(mainView.currentIndex)
        }

        onPrevDate: {
            //header.prevDate();
            //tSys.prevDay();
            mainView.currentIndex--;
            //mainView.curIndexWitouthZero = mainView.currentIndex;
            //console.log(mainView.currentIndex)
        }
    }
}
