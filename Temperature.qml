import QtQuick 2.1
import QtQuick.Shapes 1.15

Item {
    id:temperature
    width:200
    height:200


    // CPU Label Properties
    property string cpuTemperatureValuePassed:"Value"
    property string cpuTemperatureLabelPassed: "label"

    // NVME Label Properties
    property string nvmeTemperatureValuePassed: "Value"

    // WIFI Label Properties
    property string wifiTemperatureValuePassed: "Value"

    // Fan Speed
    property string fanSpeedValuePassed: "Value"




    // Font Properties
    property int cpuTemperatureLabelSizePassed:  10
    property color textColor: "white"
    property string textFontFamily: "Segoe UI"

    property int titleFont: 15


    // Main rectangle that holds ALL the temperature information
    Rectangle{
        id:cpuTemperatureSection

        height: parent.height
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right

        color: "transparent"


        // The Title of the tile "Temperature"
        Rectangle{
            id:titleHolder

            width: parent.width
            height: 20
            color: "transparent"

            anchors.top: parent.top
            Text {
                id: tileLabel
                text: "Temperature"
                //                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                font.pointSize: temperature.titleFont
                font.family: temperature.textFontFamily
                color:temperature.textColor

            }
        }

        // The CPU Temperature information
        Rectangle{
            id:cpuTemperatureHolder
            width: parent.width
            height: 20
            color: "transparent"

            anchors.top: titleHolder.bottom

            Text {
                id: cpuTemperatureValue
                text: "CPU :::" + temperature.cpuTemperatureValuePassed

                font.pointSize: temperature.cpuTemperatureLabelSizePassed
                font.family: temperature.textFontFamily
                color:temperature.textColor
            }
        }


        Rectangle{
            id:nvmeTemperatureHolder
            width: parent.width
            height: 20
            color: "transparent"

            anchors.top: cpuTemperatureHolder.bottom
            Text {
                id: nvmeTemperatureValue
                text: "NVME :::" + temperature.nvmeTemperatureValuePassed

                font.pointSize: temperature.cpuTemperatureLabelSizePassed
                font.family: temperature.textFontFamily
                color:temperature.textColor
            }
        }

        // The CPU Temperature information
        Rectangle{
            id:wifiTemperatureHolder
            width: parent.width
            height: 20
            color: "transparent"

            anchors.top: nvmeTemperatureHolder.bottom

            Text {
                id: wifiTemperatureValue
                text: "WI-FI :::" + temperature.wifiTemperatureValuePassed

                font.pointSize: temperature.cpuTemperatureLabelSizePassed
                font.family: temperature.textFontFamily
                color:temperature.textColor
            }
        }
        // This row holds the the fan icon and the fan speed in HZ
        Rectangle{
            id:fanSpeedHolder
            width: parent.width
            height: 20
            color: "transparent"




        }
        Row{            anchors.top: wifiTemperatureHolder.bottom
            anchors.topMargin: 10
            Image {
                id: fanImage
                source: "./Resources/Images/white-fan-48.png"

                Text{
                    id: fanSpeedValue
                    text: temperature.fanSpeedValuePassed + " RPM"

                    anchors.left: fanImage.right
                    font.pointSize: temperature.cpuTemperatureLabelSizePassed
                    font.family: temperature.textFontFamily
                    color:temperature.textColor
                }

            }
        }


    }



}
