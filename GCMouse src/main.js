process.stdin.resume();

//Print basic info
console.log("GCMouse 1.0");
console.log("Run the configuration app (GCConfig.exe) to set up your controls");
console.log("\nYou can minimize this window, but don't close it.");

//Required inclusions
var gca = require('./gca.js'); //I modified gca-js for the purpose of this program, so use my modified version instead of the npm version.
var robot = require('./robotJSCustom/robotjs'); //custom version of robot JS made by EJTH for relative mouse movement in FPS games
var fs = require('fs');

var adapter = gca.getAdaptersList()[0]; //Select the first GameCube controller USB adapter from any connected to the PC. (there'll usually only be 1 anyway)

//Quit the program if no adapter was found
if(adapter === undefined) {
	quitProgram("NO GC USB ADAPTER DETECTED. Make sure you have it plugged in, have the drivers set up, and have it set to Wii U mode if it's a Mayflash adapter.");
} else {
	gca.startAdapter(adapter);
}

//Account for initial stick offset
var gotOffset = false; //whether the initial stick offset has been recorded yet
var mainStickInitial = {}; //initial stick offset data (horizontal and vertical offset) for the main control stick
var cStickInitial = {}; //initial stick offset data (horizontal and vertical offset) for the c stick

//Read the button mapping configuration (this is a user editable config file)
var config = JSON.parse(fs.readFileSync("config.json")).config;

//When one of the analog sticks makes the mouse move up, down, left, and right,
//make the analog stick a "360 degree mouse stick", meaning 
//the mouse cursor moves "naturally" in a 360 degree range (at a speed based on how far the stick is pressed).
var mouse360Stick = "";

if(config.CSTICKUPAxis === "mouse_up" && config.CSTICKDOWNAxis === "mouse_down" && config.CSTICKLEFTAxis === "mouse_left" && config.CSTICKRIGHTAxis === "mouse_right") {
	mouse360Stick = "CSTICK"; 
} else if(config.MAINSTICKUPAxis === "mouse_up" && config.MAINSTICKDOWNAxis === "mouse_down" && config.MAINSTICKLEFTAxis === "mouse_left" && config.MAINSTICKRIGHTAxis === "mouse_right") {
	mouse360Stick = "MAINSTICK"; 
}

//Accounting for too many rapid button presses using a timeout system
var programStartTime = Date.now();
var pollingTimeout = 100;
var lastButtonTimes = {};

//Account for holding buttons down (like the WASD keys or holding left click in FPS games)
var heldButtons = {};

//Account for insignificant axis inputs. Axis inputs must pass this threshold to be registered
var axisThreshold = 0.1;

//Mouse movement map for non-natural movement (when neither analog stick is set to a 360 degree mouse)
//Such as when keyboard keys are used to move the mouse. (In these cases, a 360 range isn't possible because
//keyboard keys can only move in 45 degree angles).
var mouseMovement = {
	"up" : {
		xShift: 0,
		yShift: -1 * config.MouseSensitivity
	},
	"down" : {
		xShift: 0,
		yShift: config.MouseSensitivity
	},
	"right" : {
		xShift: config.MouseSensitivity,
		yShift: 0
	},
	"left" : {
		xShift: -1 * config.MouseSensitivity,
		yShift: 0
	}
};

//Main polling loop: deal with inputs from the GC adapter
gca.pollData(adapter, function(data) {
	
    var controller = gca.objectData(data)[0]; //only look at the controller on Port 1 of the adapter

    if(!controller.connected) {
    	quitProgram("Controller on Port 1 disconnected. Closing program.");
    }
    
    var axes = controller.axes;

	//Record the initial x/y position of each axis to account for offset (if it hasn't already been recorded)
    if(!gotOffset) {

        mainStickInitial = {
        	x: axes.MAINSTICKHorizontal,
        	y: axes.MAINSTICKVertical
        }; 
        
        cStickInitial = {
        	x: axes.CSTICKHorizontal,
        	y: axes.CSTICKVertical
        };

        gotOffset = true;
    }

    var buttons = controller.buttons;

    //Sanitize each of the analog stick axes before we use the inputs from them
    //(e.g. disregard inputs that are too small to pass the threshold, etc.)
    axes = {
    	"MAINSTICKHorizontal": sanitizeAxis(controller.axes.MAINSTICKHorizontal, mainStickInitial.x),
    	"MAINSTICKVertical": sanitizeAxis(controller.axes.MAINSTICKVertical, mainStickInitial.y),
    	"CSTICKHorizontal": sanitizeAxis(controller.axes.CSTICKHorizontal, cStickInitial.x),
    	"CSTICKVertical": sanitizeAxis(controller.axes.CSTICKVertical, cStickInitial.y)
    };
    
    //Handle button presses
    Object.keys(buttons).forEach(function(buttonName) {
    	var buttonActive = buttons[buttonName]; //whether the button is pressed
    	var buttonCommand = config[buttonName]; //what keyboard/mouse event the button should activate
    	var holdStatus = heldButtons[buttonName]; //whether the button is being held down (instead of single press)

    	if(buttonActive) { //If the button is being pressed

	    	if(buttonReady(buttonName)) { //account for too many rapid preses: make sure the button is "ready" after a timeout to be activated again
	    		performCommand(buttonName, buttonCommand); //perform the keyboard/mouse event that the button corresponds to
	    		buttonTimeout(buttonName); //timeout this button to prevent it from being rapidly pressed
	    	}

    	} else if(holdStatus !== undefined && holdStatus.holding) { //If the button is not being pressed, and was being held down, stop holding it down.
    		stopHolding(holdStatus);
    	}

    });

    //Handle analog stick axes

    //Round the angle of the stick's inputted direction to the nearest notch (45 degrees) using a separate function
    //At 45 degree notches, input both directions. At 0, 90, 180, and 270, input only one direction.
    //However, if the analog stick is designated as a "360 mouse movement stick", move it naturally without rounding to a 45 degree notch.
    var directionalAxisInput = {};

    //Main stick - convert into notches if it's not the mouse movement 360 stick
    if(mouse360Stick !== "MAINSTICK") {
    	splitSanitizedAxes(axes, "MAINSTICK", directionalAxisInput);
    }

    //C stick - convert into notches if it's not the mouse movement 360 stick
    if(mouse360Stick !== "CSTICK") {
    	splitSanitizedAxes(axes, "CSTICK", directionalAxisInput);
    }

    //Check if there is a mouse movement 360 stick and handle it naturally if there is
    if(mouse360Stick != "" && (axes[mouse360Stick + "Horizontal"] !== 0 || axes[mouse360Stick + "Vertical"] !== 0)) {
    	moveMouseNatural(axes[mouse360Stick + "Horizontal"], axes[mouse360Stick + "Vertical"]);
    }

    //Handle axis inputs based on each direction (up, down, left, right)
    Object.keys(directionalAxisInput).forEach(function(direction) {
    	var directionActive = directionalAxisInput[direction]; //whether the direction on the stick is being inputted
    	var directionCommand = config[direction]; //what keyboard/mouse event the direction corresponds to
    	var holdStatus = heldButtons[direction]; //whether the direction is being held down

    	if(directionActive) { //If the direction is being inputted, perform the corresponding command
    		performCommand(direction, directionCommand);
    	} else if(holdStatus !== undefined && holdStatus.holding) { //If it's not, and the corresponding command is being held down, release it.
    		stopHolding(holdStatus);
    	}

    });

    return;
});

//Test if a JS object is empty
function objIsEmpty(obj) {
	return Object.keys(obj).length === 0 && obj.constructor === Object;
}

//Release (stop holding down) a mouse event/key that is being held down
function stopHolding(holdStatus) {
	if(holdStatus.isClick) {
    	robot.mouseToggle("up", holdStatus.cmd);
    } else {
    	robot.keyToggle(holdStatus.cmd, "up");
    }

    holdStatus.holding = false;
}

//Get a 0-360 degree measure of the stick's input and split
//it into 4 directions (up, down, left, and right) for individual processing
function splitSanitizedAxes(axes, stickName, outputObj) {

	var axisVertical = axes[stickName + "Vertical"];
	var axisHorizontal = axes[stickName + "Horizontal"];

	var stickNotch = -1;

	if(axisVertical !== 0 || axisHorizontal !== 0) {
		var stickDegrees = Math.atan2(axisVertical, axisHorizontal) * 180/Math.PI;
    	if(stickDegrees < 0) { stickDegrees += 360; }

    	stickNotch = nearest45(stickDegrees);
	}

    stickNotch = (stickNotch === 360) ? 0 : stickNotch;

    outputObj[stickName + "UPAxis"] = (stickNotch === 45 || stickNotch === 90 || stickNotch === 135);
    outputObj[stickName + "DOWNAxis"] = (stickNotch === 225 || stickNotch === 270 || stickNotch === 315);
    outputObj[stickName + "LEFTAxis"] = (stickNotch === 135 || stickNotch === 180 || stickNotch === 225);
    outputObj[stickName + "RIGHTAxis"] = (stickNotch === 0 || stickNotch === 45 || stickNotch === 315);	
}

//Round an angle from 0-360 to the nearest 45 degrees (i.e. an octagonal notch)
function nearest45(degrees) {
	return Math.round(degrees/45.0) * 45;
}

//Perform a keyboard/mouse event
function performCommand(button, command) {

	if(command.startsWith("kb")) { //handle keyboard presses
	    var key = command.substring(3, command.length); //Strip the kb_ prefix (e.g. convert kb_enter into enter)

	    if(config.WASDHold && (key === "w" || key === "a" || key === "s" || key === "d")) { //If WASD holding is on, WASD keys must be held down instead of single pressed.
	    	robot.keyToggle(key, "down");

	    	heldButtons[button] = {
	    		holding: true,
	    		isClick: false,
	    		cmd: key
	    	};

	    } else { //If WASD holding is off or the key is not w, a, s, or d, just single press the key.
	    	robot.keyTap(key);	
	    }

	} else if(command.startsWith("mouse")) { //handle mouse actions

	    if(command.startsWith("mouse_click")) { //mouse clicks
	    	
	    	var click = command.substring(12, command.length);

	    	if(config.ClickHold) { //If click holding is on, clicks must be held down instead of single pressed.
	    		robot.mouseToggle("down", click);

	    		heldButtons[button] = {
	    			holding: true,
	    			isClick: true,
	    			cmd: click
	    		};

	    	} else { //otherwise, click the mouse once
	    		robot.mouseClick(click, false);
	    	}	
	    	
	    } else { //mouse movements
	    	var direction = command.substring(6, command.length);	
	    	var curPos = robot.getMousePos();

	    	robot.moveMouse(curPos.x + mouseMovement[direction].xShift, curPos.y + mouseMovement[direction].yShift);
	    }	
	}

}

//Move the mouse cursor "naturally". It can move in a 360 degree range and the cursor speed 
//changes depending on how far the stick is pressed.
function moveMouseNatural(horizontal, vertical) {
	var curPos = robot.getMousePos();

	//Scale the horizontal and vertical shift by the mouse sensitivity set in the config
	horizontal *= config.MouseSensitivity;
	vertical *= config.MouseSensitivity * -1;

	robot.moveMouseRelative(horizontal, vertical); //Move the mouse cursor relative to where it currently is.
}

//Check if a button is ready to be pressed (after being timed out)
function buttonReady(buttonName) {
	var lastTime = lastButtonTimes[buttonName];

	return lastTime === undefined || (Date.now() > lastTime + pollingTimeout);
}

//Timeout a button to prevent it from being rapidly pressed
function buttonTimeout(buttonName) {
	lastButtonTimes[buttonName] = Date.now();
}

//Quit the program with a message
function quitProgram(errorMsg) {
	console.log("\n" + errorMsg);
    gca.stopAdapter(adapter);
    process.exit();
}

//Sanitize an analog stick input to see if it passes the threshold to register
function sanitizeAxis(reading, initial) {
    var change = reading - initial; //get the current input relative to the stick's neutral (initial) position
        
    //If there is no difference in the reading vs the initial reading, or it's not enough to pass the
    //threshold, discard the input (by setting it to 0)
    if(change === 0 || Math.abs(change) < axisThreshold) {
        change = 0;
    }

    return change;
}