
import QtQuick 2.0
import QtCharts 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15




Item{

    property variant ramDictPassed: ({})
//dict_keys(['total', 'available', 'percent', 'used', 'free', 'active', 'inactive', 'buffers', 'cached', 'shared', 'slab'])
ColumnLayout{
    spacing: 2

    Rectangle {
        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth: parent.width *90
        Layout.preferredHeight: 20
        ProgressBar{
        value: Number((ramDictPassed[1]/1000000)/1000).toLocaleString(Qt.locale("de_DE"))
        }

        Text{
        text:  "Memory : " + Number((ramDictPassed[0]/1000000)/1000).toLocaleString(Qt.locale("de_DE"))

        }
    }

    Rectangle {
        Layout.alignment: Qt.AlignRight
        Layout.preferredWidth: parent.width *90
        Layout.preferredHeight: 20
        ProgressBar{
        value: 0.5
        }
        Text{
        text: "Virtual Memory"}
    }

    Rectangle {
        Layout.alignment: Qt.AlignBottom
        Layout.fillHeight: true
        Layout.preferredWidth: parent.width *90
        Layout.preferredHeight: 20
        ProgressBar{
        value: 0.5
        }

        Text{
        text: "Swap Memory"}
    }
}
}



