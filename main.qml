import QtQuick 2.1
import QtQuick.Window 2.1
//import QtQuick.Layouts 2.15
import "UI/Gauges"
import "UI/RAM"

Window {
    id: mainWindows
    width: 1080
    height: 680
    visible: true
    title: qsTr("Performance")
    color: 'black'

    property variant myDictionary: ({})
    property variant myRam: ({})

    Connections {
        target: backend

        function onPrintCPU(cpu) {

            tile1Gauge.cpuValue = cpu
        }
        function onPrintCPUTemperature(temp) {

            tile2Temperature.cpuTemperatureValuePassed = temp
        }
        function onPrintProcess(proc) {

            mainWindows.myDictionary = proc
        }
        function onPrintNVMETemperature(temp) {

            tile2Temperature.nvmeTemperatureValuePassed = temp
        }
        function onPrintWIFITemperature(temp) {

            tile2Temperature.wifiTemperatureValuePassed = temp
        }
        function onPrintFansSpeed(speed) {

            tile2Temperature.fanSpeedValuePassed = speed
        }
        function onPrintRamTotal(ram){
            // dict_keys(['total', 'available', 'percent', 'used', 'free', 'active', 'inactive', 'buffers', 'cached', 'shared', 'slab'])
            mainWindows.myRam = ram
            console.log(mainWindows.myRam[1])

        }
    }

    Rectangle {
        id: section1
        color: "black"

        width: parent.width
        height: parent.height / 3

        // This container is used to hold the the rest of the tiles.
        // Adjustment may be needed here to make the files adjust to the screen size
        Rectangle {
            id: tileHolder
            color: "transparent"

            width: parent.width
            height: parent.height

            // Holder for the gauge with CPU usage information
            Rectangle {
                id: tile1

                color: "grey"
                width: parent.width / 4.2
                height: parent.height - 10

                anchors.left: parent.left
                anchors.leftMargin: 5

                anchors.top: parent.top
                anchors.topMargin: 5

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                // Round Gauge used for the CPU usage
                RoundGauge {
                    id: tile1Gauge

                    maxcpuValue: 100
                    cpuValue: "0"

                    textLabelValue: "CPU"
                    cpuLabelSize: 15
                }
            }

            Rectangle {
                id: tile2

                color: "grey"
                width: parent.width / 4.2
                height: parent.height - 10

                anchors.left: tile1.right
                anchors.leftMargin: 5

                anchors.top: parent.top
                anchors.topMargin: 5

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5

                Temperature {
                    id: tile2Temperature
                    cpuTemperatureLabelSizePassed: 10
                    cpuTemperatureValuePassed: "0"
                    nvmeTemperatureValuePassed: "0"
                    wifiTemperatureValuePassed: "0"
                    fanSpeedValuePassed: "0"


                }
            }
            Rectangle {
                id: tile3

                color: "pink"
                width: parent.width / 4.2
                height: parent.height - 10

                anchors.left: tile2.right
                anchors.leftMargin: 5

                anchors.top: parent.top
                anchors.topMargin: 5

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5

                Ram{
                    id:tile3Ram
                    ramDictPassed : mainWindows.myRam

                }
            }

            Rectangle {
                id: tile4

                color: "grey"
                width: parent.width / 4.2
                height: parent.height - 10

                anchors.left: tile3.right
                anchors.leftMargin: 5

                anchors.right: parent.right
                anchors.rightMargin: 5

                anchors.top: parent.top
                anchors.topMargin: 5

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5

                RoundGauge {




                }
            }
        }
    }

    // Section 2 rectangle holds larger graphics
    Rectangle {

        id: section2
        color: "grey"

        width: parent.width * 7 / 12
        height: parent.height * 2 / 3

        anchors.left: parent.left
        anchors.leftMargin: 5

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5

        anchors.top: section1.bottom
        anchors.topMargin: 5

        // Displays the active processes
        Rectangle {
            id: procHolder
            height: parent.height*0.90
            width: parent.width*0.90
            color: "blue"
            //            visible:true

            Row{
                id:rowSection
                Rectangle{
                    height: 20
                    width: procHolder.width/5
                    Text{text:"ID"}
                }
                Rectangle{
                    height: 20
                    width: procHolder.width/5
                    Text{text:"Name"}
                }
                Rectangle{
                    height: 20
                    width: procHolder.width/5
                    Text{text:"Memeory %"}
                }
                Rectangle{
                    height: 20
                    width: procHolder.width/5
                    Text{text:"CmdLine"}
                }
                Rectangle{
                    height: 20
                    width: procHolder.width/5
                    Text{text:"CPU Time"}
                }
            }


            Column{
                anchors.top: rowSection.bottom
                Repeater{
                    model:  20
                    Row{
                        required property int index

                        Rectangle{
                            height: 20
                            width: procHolder.width/5

                            Text{
                                text:mainWindows.myDictionary[index].pid
                            }

                        }
                        Rectangle{
                            height: 20
                            width: procHolder.width/5

                            Text{
                                text:mainWindows.myDictionary[index].name
                            }

                        }
                        Rectangle{
                            height: 20
                            width: procHolder.width/5

                            Text{
                                text:mainWindows.myDictionary[index].memory_percent}
                        }
                        Rectangle{
                            height: 20
                            width: procHolder.width
                            Text{
                                text:mainWindows.myDictionary[index].memory_info}
                        }
                        Rectangle{
                            height: 20
                            width: procHolder.width/5

                            Text{
                                text:mainWindows.myDictionary[index].cpu_times}
                        }

                    }
                }
            }
        }
    }
    // Section 3 rectangle holds larger graphics
    Rectangle {
        id: section3
        color: "red"

        width: parent.width * 19 / 48
        height: parent.height * 2 / 3

        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.leftMargin: 5

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5

        anchors.top: section1.bottom
        anchors.topMargin: 5
    }
}
