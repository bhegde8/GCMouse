import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Window 2.0

ApplicationWindow {
    visible: true
    title: qsTr("GCMouse Configuration")
    width: 640
    height: 900

    ListModel {
        id: chooserList
        ListElement { text: "kb_backspace"; }
        ListElement { text: "kb_delete"; }
        ListElement { text: "kb_enter"; }
        ListElement { text: "kb_tab"; }
        ListElement { text: "kb_escape"; }
        ListElement { text: "kb_up"; }
        ListElement { text: "kb_down"; }
        ListElement { text: "kb_right"; }
        ListElement { text: "kb_left"; }
        ListElement { text: "kb_home"; }
        ListElement { text: "kb_end"; }
        ListElement { text: "kb_pageup"; }
        ListElement { text: "kb_pagedown"; }
        ListElement { text: "kb_f1"; }
        ListElement { text: "kb_f2"; }
        ListElement { text: "kb_f3"; }
        ListElement { text: "kb_f4"; }
        ListElement { text: "kb_f5"; }
        ListElement { text: "kb_f6"; }
        ListElement { text: "kb_f7"; }
        ListElement { text: "kb_f8"; }
        ListElement { text: "kb_f9"; }
        ListElement { text: "kb_f10"; }
        ListElement { text: "kb_f11"; }
        ListElement { text: "kb_f12"; }
        ListElement { text: "kb_command"; }
        ListElement { text: "kb_alt"; }
        ListElement { text: "kb_control"; }
        ListElement { text: "kb_right_shift"; }
        ListElement { text: "kb_space"; }
        ListElement { text: "kb_printscreen"; }
        ListElement { text: "kb_insert"; }
        ListElement { text: "kb_audio_mute"; }
        ListElement { text: "kb_audio_vol_down"; }
        ListElement { text: "kb_audio_vol_up"; }
        ListElement { text: "kb_audio_play"; }
        ListElement { text: "kb_audio_stop"; }
        ListElement { text: "kb_audio_pause"; }
        ListElement { text: "kb_audio_prev"; }
        ListElement { text: "kb_audio_next"; }
        ListElement { text: "kb_audio_rewind"; }
        ListElement { text: "kb_audio_forward"; }
        ListElement { text: "kb_audio_repeat"; }
        ListElement { text: "kb_audio_random"; }
        ListElement { text: "kb_numpad_0"; }
        ListElement { text: "kb_numpad_1"; }
        ListElement { text: "kb_numpad_2"; }
        ListElement { text: "kb_numpad_3"; }
        ListElement { text: "kb_numpad_4"; }
        ListElement { text: "kb_numpad_5"; }
        ListElement { text: "kb_numpad_6"; }
        ListElement { text: "kb_numpad_7"; }
        ListElement { text: "kb_numpad_8"; }
        ListElement { text: "kb_numpad_9"; }
        ListElement { text: "kb_audio_prev"; }
        ListElement { text: "kb_audio_next"; }

        ListElement { text: "mouse_up" }
        ListElement { text: "mouse_down" }
        ListElement { text: "mouse_left" }
        ListElement { text: "mouse_right" }
        ListElement { text: "mouse_scrollup" }
        ListElement { text: "mouse_scrolldown" }
        ListElement { text: "mouse_scrollleft" }
        ListElement { text: "mouse_scrollright" }
        ListElement { text: "mouse_leftclick" }
        ListElement { text: "mouse_rightclick" }
        ListElement { text: "mouse_middleclick" }
    }

    Rectangle {
        id: header
        width: 640
        height: 333
        color: "#a4d4e4"
        clip: true

        Text {
            id: element
            x: 0
            y: 0
            width: 640
            height: 79
            text: qsTr("GCMouse Configuration")
            clip: true
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
            clip: true
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

        ScrollView {
            id: scrollView1
            width: 640
            height: 567
            clip: true

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
                        Text {
                            id: buttonlabel
                            text: qsTr("L Trigger")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_LTrigger
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: rtrigger_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel1
                            text: qsTr("R Trigger")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_RTrigger
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: z_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel2
                            text: qsTr("Z Button")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_ZButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: start_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel3
                            text: qsTr("Start Button")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_StartButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: x_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel4
                            text: qsTr("X Button")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_XButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: y_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel5
                            text: qsTr("Y Button")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_YButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: a_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel6
                            text: qsTr("A Button")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_AButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            anchors.rightMargin: 50
                            font.pointSize: 8
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: b_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel7
                            text: qsTr("B Button")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_BButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: up_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel8
                            text: qsTr("D-Pad UP")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_DPUPButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            anchors.rightMargin: 50
                            font.pointSize: 8
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: down_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel9
                            text: qsTr("D-Pad DOWN")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_DPDOWNButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: right_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel10
                            text: qsTr("D-Pad RIGHT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_DPRIGHTButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: left_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel11
                            text: qsTr("D-Pad LEFT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_DPLEFTButton
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            anchors.rightMargin: 50
                            font.pointSize: 8
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: separator
                        width: 640
                        height: 100
                        visible: true

                        Text {
                            id: buttonlabel12
                            color: "#2cabfc"
                            text: qsTr("Axes:")
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }
                    }

                    Row {
                        id: mainaxisup_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel13
                            text: qsTr("Control Stick UP")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_MAINSTICKUPAxis
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: mainaxisdown_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel14
                            text: qsTr("Control Stick DOWN")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_MAINSTICKDOWNAxis
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            anchors.rightMargin: 50
                            font.pointSize: 8
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: mainaxisright_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel15
                            text: qsTr("Control Stick RIGHT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_MAINSTICKRIGHTAxis
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            anchors.rightMargin: 50
                            font.pointSize: 8
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: mainaxisleft_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel16
                            text: qsTr("Control Stick LEFT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_MAINSTICKLEFTAxis
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: caxisup_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel17
                            text: qsTr("C-Stick UP")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_CSTICKUPAxis
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            anchors.rightMargin: 50
                            font.pointSize: 8
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: caxisdown_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel18
                            text: qsTr("C-Stick DOWN")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_CSTICKDOWN
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: caxisright_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel19
                            text: qsTr("C-Stick RIGHT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_CSTICKRIGHTAxis
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            font.pointSize: 8
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: caxisleft_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel20
                            text: qsTr("C-Stick LEFT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        ComboBox {
                            id: chooser_CSTICKLEFTAxis
                            model: chooserList
                            width: 200
                            anchors.right: parent.right
                            focusPolicy: Qt.ClickFocus
                            anchors.rightMargin: 50
                            font.pointSize: 8
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: separator2
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel21
                            color: "#2cabfc"
                            text: qsTr("Other Settings:")
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 0
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: mainsticktoggle_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel22
                            text: qsTr("Control Stick: Toggle Keys?")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        CheckBox {
                            id: option_MAINSTICKToggle
                            text: qsTr("Yes")
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: csticktoggle_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel23
                            text: qsTr("C-Stick: Toggle Keys?")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 33
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        CheckBox {
                            id: option_CSTICKToggle
                            text: qsTr("Yes")
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: separator3
                        width: 640
                        height: 100
                        visible: true

                        Button {
                            id: button_saveExit
                            text: qsTr("Save and Exit")
                            display: AbstractButton.TextOnly
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 50
                        }

                        Button {
                            id: button_loadDefaults
                            text: qsTr("Load Defaults")
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }


                }
            }
        }
    }

    Connections {
        target: button_loadDefaults
        onClicked: print("clicked")
    }

}





































































/*##^## Designer {
    D{i:10;anchors_width:200}D{i:13;anchors_width:200}D{i:16;anchors_width:200}D{i:19;anchors_width:200}
D{i:22;anchors_width:200}D{i:25;anchors_width:200}D{i:28;anchors_width:200}D{i:31;anchors_width:200}
D{i:34;anchors_width:200}D{i:37;anchors_width:200}D{i:40;anchors_width:200}D{i:43;anchors_width:200}
D{i:48;anchors_width:200}D{i:51;anchors_width:200}D{i:54;anchors_width:200}D{i:57;anchors_width:200}
D{i:60;anchors_width:200}D{i:63;anchors_width:200}D{i:66;anchors_width:200}D{i:69;anchors_width:200}
}
 ##^##*/
