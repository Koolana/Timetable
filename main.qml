import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    //visibility: "FullScreen"
    visible: true

    width: 640
    height: 480
    title: qsTr("Hello World")

    Loader {
        source:"LessonView.qml";
    }

    Connections {
        target: fSys // Указываем целевое соединение
        /* Объявляем и реализуем функцию, как параметр
         * объекта и с имененем похожим на название сигнала
         * Разница в том, что добавляем в начале on и далее пишем
         * с заглавной буквы
         * */
        onSendOneLessonToQml: {
            dataModel.append({
                timeText: time,
                typeText: type,
                nameText: name,
                cabText: cab,
                lecturerText: lecturer
            });
            //buttonText.text = textField // Устанавливаем счётчик в текстовый лейбл
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
                timeFieldText: model.timeText
                typeFieldText: model.typeText
                nameFieldText: model.nameText
                cabFieldText: model.cabText
            }
        }
//        Очистить поле ListView по нажатию этой кнопки
//        Rectangle {
//            id: button

//            width: 100
//            height: 40
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.bottom: parent.bottom
//            border {
//                color: "black"
//                width: 1
//            }

//            Text {
//                id: buttonText
//                anchors.centerIn: parent
//                renderType: Text.NativeRendering
//                text: "Clear"
//            }

//            MouseArea {
//                anchors.fill: parent
//                //onClicked: dataModel.append({})
//                onClicked: {
//                    dataModel.clear()
//                }
//            }
//        }
    }


    Rectangle{
        id: header
        width: parent.width
        height: 50

        anchors.top: parent.top

        color: "green"
    }
}
