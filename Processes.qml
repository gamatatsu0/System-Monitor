import QtQuick 2.15
Item{
    id:processHolder
    property variant passedDict: ({})
    property color myColor: "red"

    Rectangle {

        width: 200
        height: 200
        color: myColor


        ListModel {
            id: contactModel

            property variant dict1: processHolder.passedDict.id1.name
//            property variant dict2:  processHolder.passedDict[1]
//            property variant dict3:  processHolder.passedDict[2]

            // 1. Initialize the list model:
            property bool completed: false

            onDict1Changed: {
                var idCounter = 1;
                var pid = "id".concat(1)
                for(var x in passedDict){
                    append({pid:idCounter, name:processHolder.passedDict.pid.name, username:processHolder.passedDict.pid.username})
                }
            }
            Component.onCompleted: {
                append({id1: processHolder.passedDict.id1.name, name:"aa"});
//                append({pid: "the ID 2", name:"bb"});
//                append({pid: "the ID 3", name:"cc"});
                console.log(processHolder.passedDict.id1.name)
                contactModel.completed = true
            }

            // 2. Update the list model:
//            onDict1Changed: {
//                if(completed) setProperty(0,"id1:", processHolder.passedDict.id1.name, "name:", processHolder.passedDict);
//            }
//            onDict2Changed: {
//                if(completed) setProperty(1,"pid:", processHolder.passedDict[1].pid, "name:", processHolder.passedDict[1].name);
//            }
//            onDict3Changed: {
//                if(completed) setProperty(2,"pid:", processHolder.passedDict[2].pid, "name:", processHolder.passedDict[2].name);
//            }
        }

        Component {
            id: contactDelegate
            Row {
                spacing: 10
                Text {
                    text: 'ID: ' + id1
                    color: "black"
                }
                Text {
                    text: 'Name: ' + name
                }
            }
        }

        ListView {
            anchors.fill: parent
            model: contactModel
            delegate: contactDelegate
        }
    }
}
