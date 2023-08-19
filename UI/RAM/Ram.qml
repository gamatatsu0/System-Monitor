
import QtQuick 2.0
import QtCharts 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15





ColumnLayout{
    spacing: 2

    Rectangle {
        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth: parent.width *90
        Layout.preferredHeight: 20
        ProgressBar{
        value: 0.5
        }

        Text{
        text: "Memory"}
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




