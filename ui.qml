import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Window 2.0

ApplicationWindow {
    id: appWindow
    objectName: "appWindow"
    visible: true
    title: qsTr("GCMouse Configuration")
    width: 640
    height: 900

    signal loadConfig(string filename)

    property bool loadedUI: false
    property var chooserListArray :
    [
    "kb_a",
    "kb_b",
    "kb_c",
    "kb_d",
    "kb_e",
    "kb_f",
    "kb_g",
    "kb_h",
    "kb_i",
    "kb_j",
    "kb_k",
    "kb_l",
    "kb_m",
    "kb_n",
    "kb_o",
    "kb_p",
    "kb_q",
    "kb_r",
    "kb_s",
    "kb_t",
    "kb_u",
    "kb_v",
    "kb_w",
    "kb_x",
    "kb_y",
    "kb_z",
    "kb_1",
    "kb_2",
    "kb_3",
    "kb_4",
    "kb_5",
    "kb_6",
    "kb_7",
    "kb_8",
    "kb_9",
    "kb_0",
    "kb_backspace",
    "kb_delete",
    "kb_enter",
    "kb_tab",
    "kb_escape",
    "kb_up",
    "kb_down",
    "kb_right",
    "kb_left",
    "kb_pageup",
    "kb_pagedown",
    "kb_f1",
    "kb_f2",
    "kb_f3",
    "kb_f4",
    "kb_f5",
    "kb_f6",
    "kb_f7",
    "kb_f8",
    "kb_f9",
    "kb_f10",
    "kb_f11",
    "kb_f12",
    "kb_alt",
    "kb_control",
    "kb_right_shift",
    "kb_space",
    "mouse_up",
    "mouse_down",
    "mouse_left",
    "mouse_right",
    "mouse_leftclick",
    "mouse_rightclick",
    "mouse_middleclick"
    ];

    //Used to load the config as soon as this program starts up and the UI has been loaded
    onAfterSynchronizing: {
        if (!loadedUI) {
            console.log("Loading config on app launch");
            appWindow.loadConfig("config.json")
            loadedUI = true;
        }
    }

    function getIndex(itemName) {
        return chooserListArray.indexOf(itemName);
    }

    function gatherAndSaveConfig() {

    }


    Connections {
        target: funcHandler
        onApplyJsonConfig: {
            console.log("Received JSON config. Applying...");
            var obj = JSON.parse(json).config;

            //Unfortunately, limitations with QML prevent me from
            //iterating through this in a much simpler way.
            //I have to go through each one individually.
            chooser_LTrigger.currentIndex = getIndex(obj.LTrigger);
            chooser_RTrigger.currentIndex = getIndex(obj.RTrigger);
            chooser_ZButton.currentIndex = getIndex(obj.ZButton);
            chooser_StartButton.currentIndex = getIndex(obj.StartButton);
            chooser_XButton.currentIndex = getIndex(obj.XButton);
            chooser_YButton.currentIndex = getIndex(obj.YButton);
            chooser_AButton.currentIndex = getIndex(obj.AButton);
            chooser_BButton.currentIndex = getIndex(obj.BButton);
            chooser_DPUPButton.currentIndex = getIndex(obj.DPUPButton);
            chooser_DPDOWNButton.currentIndex = getIndex(obj.DPDOWNButton);
            chooser_DPRIGHTButton.currentIndex = getIndex(obj.DPRIGHTButton);
            chooser_DPLEFTButton.currentIndex = getIndex(obj.DPLEFTButton);
            chooser_MAINSTICKUPAxis.currentIndex = getIndex(obj.MAINSTICKUPAxis);
            chooser_MAINSTICKDOWNAxis.currentIndex = getIndex(obj.MAINSTICKDOWNAxis);
            chooser_MAINSTICKLEFTAxis.currentIndex = getIndex(obj.MAINSTICKLEFTAxis);
            chooser_MAINSTICKRIGHTAxis.currentIndex = getIndex(obj.MAINSTICKRIGHTAxis);
            chooser_CSTICKUPAxis.currentIndex = getIndex(obj.CSTICKUPAxis);
            chooser_CSTICKDOWNAxis.currentIndex = getIndex(obj.CSTICKDOWNAxis);
            chooser_CSTICKLEFTAxis.currentIndex = getIndex(obj.CSTICKLEFTAxis);
            chooser_CSTICKRIGHTAxis.currentIndex = getIndex(obj.CSTICKRIGHTAxis);
            chooser_MAINSTICKToggle.checked = obj.MAINSTICKToggle;
            chooser_CSTICKToggle.checked = obj.CSTICKToggle;
        }
    }


    ListModel {
        id: chooserList
        ListElement { text: "kb_a"; }
        ListElement { text: "kb_b"; }
        ListElement { text: "kb_c"; }
        ListElement { text: "kb_d"; }
        ListElement { text: "kb_e"; }
        ListElement { text: "kb_f"; }
        ListElement { text: "kb_g"; }
        ListElement { text: "kb_h"; }
        ListElement { text: "kb_i"; }
        ListElement { text: "kb_j"; }
        ListElement { text: "kb_k"; }
        ListElement { text: "kb_l"; }
        ListElement { text: "kb_m"; }
        ListElement { text: "kb_n"; }
        ListElement { text: "kb_o"; }
        ListElement { text: "kb_p"; }
        ListElement { text: "kb_q"; }
        ListElement { text: "kb_r"; }
        ListElement { text: "kb_s"; }
        ListElement { text: "kb_t"; }
        ListElement { text: "kb_u"; }
        ListElement { text: "kb_v"; }
        ListElement { text: "kb_w"; }
        ListElement { text: "kb_x"; }
        ListElement { text: "kb_y"; }
        ListElement { text: "kb_z"; }
        ListElement { text: "kb_1"; }
        ListElement { text: "kb_2"; }
        ListElement { text: "kb_3"; }
        ListElement { text: "kb_4"; }
        ListElement { text: "kb_5"; }
        ListElement { text: "kb_6"; }
        ListElement { text: "kb_7"; }
        ListElement { text: "kb_8"; }
        ListElement { text: "kb_9"; }
        ListElement { text: "kb_0"; }
        ListElement { text: "kb_backspace"; }
        ListElement { text: "kb_delete"; }
        ListElement { text: "kb_enter"; }
        ListElement { text: "kb_tab"; }
        ListElement { text: "kb_escape"; }
        ListElement { text: "kb_up"; }
        ListElement { text: "kb_down"; }
        ListElement { text: "kb_right"; }
        ListElement { text: "kb_left"; }
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
        ListElement { text: "kb_alt"; }
        ListElement { text: "kb_control"; }
        ListElement { text: "kb_right_shift"; }
        ListElement { text: "kb_space"; }
        ListElement { text: "mouse_up"; }
        ListElement { text: "mouse_down"; }
        ListElement { text: "mouse_left"; }
        ListElement { text: "mouse_right"; }
        ListElement { text: "mouse_leftclick"; }
        ListElement { text: "mouse_rightclick"; }
        ListElement { text: "mouse_middleclick"; }
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
                            objectName: "chooser_LTrigger"
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
                            id: testLabel
                            objectName: "testLabel"
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
                            id: chooser_CSTICKDOWNAxis
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
                            id: chooser_MAINSTICKToggle
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
                            id: chooser_CSTICKToggle
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
                            onClicked: appWindow.getQmlObjectByName("test")
                            text: qsTr("Save and Exit")
                            display: AbstractButton.TextOnly
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 50
                        }

                        Button {
                            id: button_loadDefaults
                            onClicked: appWindow.loadConfig("defaultConfig.json")
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



}













































































/*##^## Designer {
    D{i:10;anchors_width:200}D{i:13;anchors_width:200}D{i:16;anchors_width:200}D{i:19;anchors_width:200}
D{i:22;anchors_width:200}D{i:25;anchors_width:200}D{i:28;anchors_width:200}D{i:31;anchors_width:200}
D{i:34;anchors_width:200}D{i:37;anchors_width:200}D{i:40;anchors_width:200}D{i:43;anchors_width:200}
D{i:48;anchors_width:200}D{i:51;anchors_width:200}D{i:54;anchors_width:200}D{i:57;anchors_width:200}
D{i:60;anchors_width:200}D{i:63;anchors_width:200}D{i:66;anchors_width:200}D{i:69;anchors_width:200}
}
 ##^##*/
