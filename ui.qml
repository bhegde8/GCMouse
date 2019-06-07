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
    signal applyTextChooser(string chooser, string text)
    signal saveConfig(string configJson)

    property bool loadedUI: false
    property var keyCodes : [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,49,50,51,52,53,54,55,56,57,48,16777219,16777223,16777220,16777217,16777216,16777235,16777237,16777236,16777234,16777238,16777239,16777264,16777265,16777266,16777267,16777268,16777269,16777270,16777271,16777272,16777273,16777274,16777275,16777251,16777249,16777248,32];
    property var chooserListArray : ["kb_a","kb_b","kb_c","kb_d","kb_e","kb_f","kb_g","kb_h","kb_i","kb_j","kb_k","kb_l","kb_m","kb_n","kb_o","kb_p","kb_q","kb_r","kb_s","kb_t","kb_u","kb_v","kb_w","kb_x","kb_y","kb_z","kb_1","kb_2","kb_3","kb_4","kb_5","kb_6","kb_7","kb_8","kb_9","kb_0","kb_backspace","kb_delete","kb_enter","kb_tab","kb_escape","kb_up","kb_down","kb_right","kb_left","kb_pageup","kb_pagedown","kb_f1","kb_f2","kb_f3","kb_f4","kb_f5","kb_f6","kb_f7","kb_f8","kb_f9","kb_f10","kb_f11","kb_f12","kb_alt","kb_control","kb_right_shift","kb_space","mouse_up","mouse_down","mouse_left","mouse_right","mouse_leftclick","mouse_rightclick","mouse_middleclick"];
    property var currentChoosingMouse : "";

    //Used to load the config as soon as this program starts up and the UI has been loaded
    onAfterSynchronizing: {
        if (!loadedUI) {
//            console.log("Loading config on app launch");
            appWindow.loadConfig("config.json")
            loadedUI = true;
        }
    }

    function getIndex(itemName) {
        return chooserListArray.indexOf(itemName);
    }

    function gatherAndSaveConfig() {

        //Can't iterate through these
        //due to limitations of QML
        var obj =
        {
            "config": {
                "LTrigger": chooser_LTrigger.text,
                "RTrigger": chooser_RTrigger.text,
                "ZButton": chooser_ZButton.text,
                "StartButton": chooser_StartButton.text,
                "XButton": chooser_XButton.text,
                "YButton": chooser_YButton.text,
                "AButton": chooser_AButton.text,
                "BButton": chooser_BButton.text,
                "DPUPButton": chooser_DPUPButton.text,
                "DPDOWNButton": chooser_DPDOWNButton.text,
                "DPRIGHTButton": chooser_DPRIGHTButton.text,
                "DPLEFTButton": chooser_DPLEFTButton.text,
                "MAINSTICKUPAxis": chooser_MAINSTICKUPAxis.text,
                "MAINSTICKDOWNAxis": chooser_MAINSTICKDOWNAxis.text,
                "MAINSTICKLEFTAxis": chooser_MAINSTICKLEFTAxis.text,
                "MAINSTICKRIGHTAxis": chooser_MAINSTICKRIGHTAxis.text,
                "CSTICKUPAxis": chooser_CSTICKUPAxis.text,
                "CSTICKDOWNAxis": chooser_CSTICKDOWNAxis.text,
                "CSTICKLEFTAxis": chooser_CSTICKLEFTAxis.text,
                "CSTICKRIGHTAxis": chooser_CSTICKRIGHTAxis.text,
                "ClickHold": chooser_ClickHold.checked,
                "WASDHold": chooser_WASDHold.checked
            }
        };

        saveConfig(JSON.stringify(obj));
    }

    function getKeyPress(keyCode) {
        var keyName = chooserListArray[keyCodes.indexOf(keyCode)];
        return keyName;
    }

    function sanitize(text) {
        if(text[text.length - 1] === text[text.length - 2])
        {
            text = text.substring(0, text.length - 1);
        }
        if(text === "kb_backspac") {
            text = "kb_backspace";
        }

        text = text.replace(/[^0-9a-zA-Z_]/g, "");
        return text.trim();
    }

    function handleMousePopup(choice) {
        applyTextChooser(currentChoosingMouse, choice);
    }

    Connections {
        target: funcHandler
        onApplyJsonConfig: {
//            console.log("Received JSON config. Applying...");
            var obj = JSON.parse(json).config;


            Object.keys(obj).forEach(function(key) {
                if(!key.endsWith("Hold")) {
                    applyTextChooser(key, obj[key]);
                }
                else {
                    if(key === "ClickHold") {
                        chooser_ClickHold.checked = obj.ClickHold;
                    }
                    else if(key === "WASDHold") {
                        chooser_WASDHold.checked = obj.WASDHold;
                    }
                }
            });

        }
    }

    Popup {
        id: popup
        x: 20
        y: 350
        width: 600
        height: 100
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        Button {
            id: popup_click_left
            y: 24
            width: 64
            height: 40
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            display: AbstractButton.IconOnly
            icon.source: "icons/click_left.png"

            onClicked: {
                handleMousePopup("mouse_click_left");
                popup.close();
            }
        }

        Button {
            id: popup_click_middle
            x: 4
            y: 31
            width: 64
            height: 40
            text: qsTr("Button")
            icon.source: "icons/click_middle.png"
            anchors.left: popup_click_left.right
            anchors.leftMargin: 20
            display: AbstractButton.IconOnly
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                handleMousePopup("mouse_click_middle");
                popup.close();
            }
        }

        Button {
            id: popup_click_right
            x: 4
            y: 26
            width: 64
            height: 40
            text: qsTr("Button")
            icon.source: "icons/click_right.png"
            anchors.left: popup_click_middle.right
            anchors.leftMargin: 20
            display: AbstractButton.IconOnly
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                handleMousePopup("mouse_click_right");
                popup.close();
            }
        }

        Text {
            id: label1
            x: 97
            y: 66
            text: qsTr("Mouse Buttons")
            font.pixelSize: 12
        }

        Button {
            id: popup_move_left
            x: 0
            y: 24
            width: 64
            height: 40
            text: qsTr("Button")
            icon.source: "icons/move_left.png"
            anchors.left: popup_click_right.right
            anchors.leftMargin: 40
            display: AbstractButton.IconOnly
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                handleMousePopup("mouse_left");
                popup.close();
            }
        }

        Button {
            id: popup_move_up
            x: 4
            y: 31
            width: 64
            height: 40
            text: qsTr("Button")
            icon.source: "icons/move_up.png"
            anchors.left: popup_move_left.right
            anchors.leftMargin: 10
            display: AbstractButton.IconOnly
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                handleMousePopup("mouse_up");
                popup.close();
            }
        }

        Button {
            id: popup_move_down
            x: 4
            y: 26
            width: 64
            height: 40
            text: qsTr("Button")
            icon.source: "icons/move_down.png"
            anchors.left: popup_move_up.right
            anchors.leftMargin: 10
            display: AbstractButton.IconOnly
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                handleMousePopup("mouse_down");
                popup.close();
            }
        }

        Text {
            id: label2
            x: 362
            y: 66
            text: qsTr("Move Mouse in a Direction")
            font.pixelSize: 12
        }

        Button {
            id: popup_move_right
            x: 1
            y: 30
            width: 64
            height: 40
            text: qsTr("Button")
            icon.source: "icons/move_right.png"
            anchors.left: popup_move_down.right
            anchors.leftMargin: 10
            display: AbstractButton.IconOnly
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                handleMousePopup("mouse_right");
                popup.close();
            }
        }
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_LTrigger
                            objectName: "chooser_LTrigger"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "LTrigger";
                                popup.open();
                            }
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_RTrigger
                            objectName: "chooser_RTrigger"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button1
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "RTrigger";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: zbutton_row
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
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_ZButton
                            objectName: "chooser_ZButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button2
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "ZButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: startbutton_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel3
                            text: qsTr("Start")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_StartButton
                            objectName: "chooser_StartButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button3
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "StartButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: xbutton_row
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
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_XButton
                            objectName: "chooser_XButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button4
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "XButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: ybutton_row
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_YButton
                            objectName: "chooser_YButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button5
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "YButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: abutton_row
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
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_AButton
                            objectName: "chooser_AButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button6
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "AButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: bbutton_row
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_BButton
                            objectName: "chooser_BButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button7
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "BButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: dpupbutton_row
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
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_DPUPButton
                            objectName: "chooser_DPUPButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button8
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "DPUPButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: dpdownbutton_row
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_DPDOWNButton
                            objectName: "chooser_DPDOWNButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button9
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "DPDOWNButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: dprightbutton_row
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_DPRIGHTButton
                            objectName: "chooser_DPRIGHTButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button10
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "DPRIGHTButton";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: dpleftbutton_row
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
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_DPLEFTButton
                            objectName: "chooser_DPLEFTButton"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button11
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "DPLEFTButton";
                                popup.open();
                            }
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }
                    }

                    Row {
                        id: mainstickupaxis_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel13
                            text: qsTr("Main Stick UP")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_MAINSTICKUPAxis
                            objectName: "chooser_MAINSTICKUPAxis"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button13
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "MAINSTICKUPAxis";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: mainstickdownaxis_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel14
                            text: qsTr("Main Stick DOWN")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_MAINSTICKDOWNAxis
                            objectName: "chooser_MAINSTICKDOWNAxis"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button14
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "MAINSTICKDOWNAxis";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: mainstickleftaxis_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel15
                            text: qsTr("Main Stick LEFT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_MAINSTICKLEFTAxis
                            objectName: "chooser_MAINSTICKLEFTAxis"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button15
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "MAINSTICKLEFTAxis";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: mainstickrightaxis_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel16
                            text: qsTr("Main Stick RIGHT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_MAINSTICKRIGHTAxis
                            objectName: "chooser_MAINSTICKRIGHTAxis"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button16
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "MAINSTICKRIGHTAxis";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: cstickupaxis_row
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
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_CSTICKUPAxis
                            objectName: "chooser_CSTICKUPAxis"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button17
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "CSTICKUPAxis";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: cstickdownaxis_row
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_CSTICKDOWNAxis
                            objectName: "chooser_CSTICKDOWNAxis"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button18
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "CSTICKDOWNAxis";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: cstickleftaxis_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel19
                            text: qsTr("C-Stick LEFT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_CSTICKLEFTAxis
                            objectName: "chooser_CSTICKLEFTAxis"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button19
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "CSTICKLEFTAxis";
                                popup.open();
                            }
                        }

                        visible: true
                    }

                    Row {
                        id: cstickrightaxis_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel20
                            text: qsTr("C-Stick RIGHT")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        TextInput {
                            id: chooser_CSTICKRIGHTAxis
                            objectName: "chooser_CSTICKRIGHTAxis"
                            width: 200
                            color: "#d00a0a"
                            text: "Press a key"
                            cursorVisible: false
                            readOnly: false
                            selectionColor: "#00801c"
                            anchors.right: parent.right
                            font.pointSize: 18
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter

                            onTextChanged: {
                                text = sanitize(text);
                            }

                            Keys.onPressed: {
                                text = getKeyPress(event.key);
                            }
                        }

                        Button {
                            id: button20
                            width: 100
                            text: qsTr("Mouse...")
                            anchors.right: parent.right
                            anchors.rightMargin: 270
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                currentChoosingMouse = "CSTICKRIGHTAxis";
                                popup.open();
                            }
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
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: clickhold_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel22
                            text: qsTr("Hold Left/Right Click?")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        CheckBox {
                            id: chooser_ClickHold
                            anchors.right: parent.right
                            anchors.rightMargin: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        visible: true
                    }

                    Row {
                        id: wasdhold_row
                        width: 640
                        height: 100
                        Text {
                            id: buttonlabel23
                            text: qsTr("Hold WASD?")
                            anchors.leftMargin: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.letterSpacing: 0
                            anchors.left: parent.left
                            font.wordSpacing: 0
                            horizontalAlignment: Text.AlignHCenter
                            font.pixelSize: 26
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: false
                        }

                        CheckBox {
                            id: chooser_WASDHold
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
                            onClicked: {
                                appWindow.gatherAndSaveConfig();
                                Qt.quit();
                            }
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
