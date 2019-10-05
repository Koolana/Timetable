import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    function refreshMargin(){
        view.positionViewAtBeginning();
    }

    id: listLesIt;
    property string colorFont: "#ffffff";
    property string colorType0: "#2c3e50";
    property string colorType1: "#18bc9c";
    property string colorType2: "#3498db";
    property string colorType3: "#6c7eb0";
    property string colorType4: "#888888";

    function addLessonToView(data){
        dataModel.append(data);
    }

    ListModel {
        id: dataModel
    }

    ListView {
        id: view

        anchors.fill: parent
        spacing: 10
        model: dataModel

        anchors.bottomMargin: 10

        contentHeight: 10

        delegate: LessonView {
            id: lessonView
            width: mainView.width
            height: (model.typeText == "date") ? 40 : 120

            color: colorType0
            //border.color: model.color

            timeFieldText: model.timeText
            typeFieldText: model.typeText
            nameFieldText: model.nameText
            cabFieldText: model.cabText

            Rectangle {
                id: backEl
                visible: !(model.typeText == "date")
                color: {
                    if( model.typeText === "(лек)"){
                        colorType1;
                    }else{
                        if( model.typeText === "(сем)")
                        {
                            colorType2
                        }else{
                            if( model.typeText === "(лаб)"){
                                colorType3
                            }else{
                                colorType4
                            }
                        }
                    }
                }

                width: parent.width + 8
                height: parent.height + 8
                anchors.leftMargin: - 4
                anchors.topMargin: - 4

                smooth: true

                radius: parent.radius

                z: -1
                opacity: 1/*0.7*/
                anchors.left: parent.left
                anchors.top: parent.top
            }
        }
    }
}
