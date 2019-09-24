import QtQuick 2.0

Item {
    property int indexTodayDay: 0

    signal prevDateEnd();
    signal notEnd();

    Rectangle{
        id: leftBut

        width: parent.width;
        radius: parent.width/2;

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        //anchors.right: parent.right

        color: "White"

        Rectangle {
            color: "#444444"

            width: parent.width + 4
            height: parent.height + 4
            anchors.leftMargin: -2
            anchors.topMargin: -2

            smooth: true

            z: -1
            opacity: 0.3
            radius: parent.radius
            anchors.left: parent.left
            anchors.top: parent.top
        }

        MouseArea{
            anchors.fill: parent

            onClicked: {
                tSys.setDay(indexTodayDay);

                if(indexTodayDay == 0){
                    prevDateEnd();
                }else{
                    notEnd();
                }
            }
        }
    }
}
