import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
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

        delegate: LessonView {
            id: lessonView
            width: mainView.width
            height: 120

            color: colorType0
            //border.color: model.color

            timeFieldText: model.timeText
            typeFieldText: model.typeText
            nameFieldText: model.nameText
            cabFieldText: model.cabText

            Rectangle {
                id: backEl
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

    //                        "#dddddd"
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

//                RadialGradient
//                {
//                    anchors.fill: parent
//                    gradient: Gradient{
//                        GradientStop {position: 0.5; color: backEl.color;}
//                        GradientStop {position: 1;color: Qt.rgba(0, 0, 0, 1);}
//                    }
//                }

//                gradient: Gradient
//                {
//                    GradientStop {position: 0.000;color: Qt.rgba(1, 0, 0, 1);}
//                    GradientStop {position: 0.167;color: Qt.rgba(1, 1, 0, 1);}
//                    GradientStop {position: 0.333;color: Qt.rgba(0, 1, 0, 1);}
//                    GradientStop {position: 0.500;color: Qt.rgba(0, 1, 1, 1);}
//                    GradientStop {position: 0.667;color: Qt.rgba(0, 0, 1, 1);}
//                    GradientStop {position: 0.833;color: Qt.rgba(1, 0, 1, 1);}
//                    GradientStop {position: 1.000;color: Qt.rgba(1, 0, 0, 1);}
//                }
            }
        }
    }
}
