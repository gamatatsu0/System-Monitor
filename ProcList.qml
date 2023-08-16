import QtQuick 2.1

Item {
    id:myProceessHolder
    property string procName: "Holder"
    property color color: "red"



    Rectangle{
        id:theRect
        width: 300
        height: 100

        Text{
            text:myProceessHolder.procName
            color: myProceessHolder.color
        }



    }


}
