
import QtQuick 2.0
import QtCharts 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15




Item{

    property variant ramDictPassed: ({})
    property variant swapDictPassed: ({})

    //dict_keys(['total', 'available', 'percent', 'used', (used Calculated), 'active', 'inactive', 'buffers', 'cached', 'shared', 'slab'])
    ColumnLayout{
        spacing: 2

        Rectangle {
            Layout.preferredWidth: parent.width *90
            Layout.preferredHeight: 30
            color: "red"

            Row{

                ProgressBar{            id:ramProgressBar

                    value: ramDictPassed[4]
                    //                        verticalPadding: 10
                }
                Text{
                    text: ramDictPassed[2]
                }
            }
            Text{
                text:  "Memory : " + ramDictPassed[0] + " GB"
                anchors.top:  ramProgressBar.bottom
                anchors.topMargin: 10


            }
        }

        //    sswap(total=2097147904L, used=886620160L, free=1210527744L, percent=42.3, sin=1050411008, sout=1906720768)

        Rectangle {
            //            Layout.alignment: Qt.AlignBottom
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width *90
            Layout.preferredHeight: 30
            anchors.top: ramProgressBar.bottom



            Row{
                ProgressBar{
                    value: swapDictPassed[5]
                    //                        verticalPadding: 10
                }


                Text{
                    text:swapDictPassed[3]
                }
            }

            Text{
                text: "Swap Memory : " + (swapDictPassed[0] - 0.01)+ " GB"
            }
        }

    }
}



