import QtQuick 2.15
import QtQuick.Shapes 1.15
//import QtGraphicalEffects 1.12



//import QtGraphicalEffects 1.5

Item {

    id: progress
    width: 200;
    height: 200;

//   General Gauge Properties
    property bool roundCap: true
    property int startAngle: -210
    property real maxcpuValue: 100
    property string cpuPercentage: "0"
    property string cpuValue: "5" // Value for the number in the center
    property int samples: 12
    property string kmhOrMPH : "MPH" // Default is MPH
    property string celOrFarheit: "C" // Default is Celcius

//    Big Circle
    property color bgColor: "transparent"
    property color bgStrokeColor: "#7e7e7e"
    property int strokeBgWidth: 20

//    Progress Circle
    property color progressColor: (progress.cpuValue < 80)? "blue" : "red"
    property color lessColor: "blue"

    property int progressWidth: 20

//    Text Properties
    property string text: "%"
    property string textLabelValue: ""
    property string textFontFamily: "Segoe UI"
    property int textSize: 35
    property int cpuLabelSize: 30
    property color textColor: "white"

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    Shape{
        id:shape
        anchors.fill: parent
        layer.enabled: true
        layer.samples: progress.samples


        ShapePath{
            id: pathBG
            strokeColor: progress.bgStrokeColor
            fillColor: progress.bgColor
            strokeWidth: progress.strokeBgWidth
            capStyle: progress.roundCap ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc{
                radiusX: (progress.width /2) - (progress.progressWidth  / 2)
                radiusY: (progress.height /2) - (progress.progressWidth  / 2)
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: progress.startAngle
                sweepAngle: 360

            }
        }


        ShapePath{
            id: path
            strokeColor: progress.progressColor
            fillColor: "transparent"
            strokeWidth: progress.progressWidth
            capStyle: progress.roundCap ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc{
                radiusX: (progress.width /2) - (progress.progressWidth / 2)
                radiusY: (progress.height /2) - (progress.progressWidth / 2)
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: progress.startAngle
                sweepAngle: (240 / progress.maxcpuValue * progress.cpuValue)

            }

//            Glow {
//                anchors.fill: path
//                radius: 20
//                samples: 17
//                color: "red"
//                source: path
//            }
        }

        // Displays the CPU value
        // The text with the value is centered
        Text {
            id: textProgress
            text: progress.cpuValue + "%"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            color: progress.textColor
            font.pointSize: progress.textSize
            font.family: progress.textFontFamily
        }

        // The label underneath the actual value of the gauge
        Text {
            id: textProgressLabel
            text: textLabelValue

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: textProgress.bottom

            color: progress.textColor
            font.pointSize: progress.cpuLabelSize
            font.family: progress.textFontFamily
        }


    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:250;width:250}
}
##^##*/
