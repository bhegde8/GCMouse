import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

Item {
    height: 900
    Rectangle {
        id: header
        width: 640
        height: 333
        color: "#a4d4e4"

        Text {
            id: element
            x: 0
            y: 0
            width: 640
            height: 79
            text: qsTr("GCMouse Configuration")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 40
        }

        Image {
            id: image
            x: 0
            y: 79
            width: 640
            height: 254
            fillMode: Image.PreserveAspectFit
            source: "gclayout.png"
        }



    }

    Rectangle {
        id: configPanel
        x: 0
        y: 333
        width: 640
        height: 567
        color: "#ffffff"

        Flickable {
            id: scrollPane
            width: 640
            height: 567

            ColumnLayout {
                id: columnLayout
                width: 640
                height: 567

                Column {
                    id: column
                    width: 200
                    height: 400

                    Row {
                        id: ltrigger_row
                        width: 640
                        height: 100
                        visible: true

                        Text {
                            id: buttonlabel
                            text: qsTr("L Trigger")
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                            font.family: "Arial"
                            font.letterSpacing: 0
                            font.wordSpacing: 0
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                        }

                        ComboBox {
                            id: chooser_LTrigger
                            width: 200
                            font.pointSize: 8
                            anchors.verticalCenter: parent.verticalCenter
                            focusPolicy: Qt.ClickFocus
                        }
                    }

                    Row {
                        id: rtrigger_row
                        width: 640
                        height: 100
                        visible: true
                        Text {
                            id: buttonlabel1
                            text: qsTr("R Trigger")
                            font.letterSpacing: 0
                            anchors.verticalCenter: parent.verticalCenter
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            font.family: "Arial"
                            font.bold: false
                            verticalAlignment: Text.AlignVCenter
                        }

                        ComboBox {
                            id: chooser_RTrigger
                            width: 200
                            anchors.verticalCenter: parent.verticalCenter
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                        }
                    }

                    Row {
                        id: z_row
                        width: 640
                        height: 100
                        visible: true
                        Text {
                            id: buttonlabel2
                            text: qsTr("Z Button")
                            font.letterSpacing: 0
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            font.family: "Arial"
                            font.bold: false
                            verticalAlignment: Text.AlignVCenter
                        }

                        ComboBox {
                            id: chooser_ZButton
                            width: 200
                            anchors.verticalCenter: parent.verticalCenter
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                        }
                    }

                    Row {
                        id: start_row
                        width: 640
                        height: 100
                        visible: true
                        Text {
                            id: buttonlabel3
                            text: qsTr("Start Button")
                            font.letterSpacing: 0
                            anchors.verticalCenter: parent.verticalCenter
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            font.family: "Arial"
                            font.bold: false
                            verticalAlignment: Text.AlignVCenter
                        }

                        ComboBox {
                            id: chooser_StartButton
                            width: 200
                            anchors.verticalCenter: parent.verticalCenter
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                        }
                    }

                    Row {
                        id: x_row
                        width: 640
                        height: 100
                        visible: true
                        Text {
                            id: buttonlabel4
                            text: qsTr("X Button")
                            font.letterSpacing: 0
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            font.family: "Arial"
                            font.bold: false
                            verticalAlignment: Text.AlignVCenter
                        }

                        ComboBox {
                            id: chooser_XButton
                            width: 200
                            anchors.verticalCenter: parent.verticalCenter
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                        }
                    }

                    Row {
                        id: y_row
                        width: 640
                        height: 100
                        visible: true
                        Text {
                            id: buttonlabel5
                            text: qsTr("Y Button")
                            font.letterSpacing: 0
                            anchors.verticalCenter: parent.verticalCenter
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            font.family: "Arial"
                            font.bold: false
                            verticalAlignment: Text.AlignVCenter
                        }

                        ComboBox {
                            id: chooser_YButton
                            width: 200
                            anchors.verticalCenter: parent.verticalCenter
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                        }
                    }

                }
            }
        }
    }

}





















/*##^## Designer {
    D{i:10;anchors_width:200}D{i:13;anchors_width:200}D{i:16;anchors_width:200}D{i:19;anchors_width:200}
D{i:22;anchors_width:200}D{i:25;anchors_width:200}
}
 ##^##*/
