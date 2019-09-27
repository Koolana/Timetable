import QtQuick 2.0

Item{
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
        }
    }
}
