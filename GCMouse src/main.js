process.stdin.resume();

var gca = require('./gca.js'); //I modified gca-js for the purpose of this program, so use my modified version instead of the npm version.
var robot = require('robotjs');
var fs = require('fs');

var adapter = gca.getAdaptersList()[0];

if(adapter === undefined) {
	console.log("NO GC USB ADAPTER DETECTED. Make sure you have it plugged in, have the drivers set up, and have it set to Wii U mode if it's a Mayflash adapter.");
	quitProgram();
} else {
	gca.startAdapter(adapter);
}

//Account for initial stick offset
var gotOffset = false;
var mainStickInitial = {};
var cStickInitial = {};

//Read the button mapping configuration (this is a user editable config file)
var config = JSON.parse(fs.readFileSync("config.json")).config;

//Accounting for too many rapid button presses using a timeout system
var programStartTime = Date.now();
var pollingTimeout = 100;
var lastButtonTimes = {};

//Account for holding buttons
var heldButtons = {};

//Account for insignificant axis inputs
var axisThreshold = 0.1;

//Mouse movement map
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

//Start dealing with inputs from the GC adapter
gca.pollData(adapter, function(data) {
    var controller = gca.objectData(data)[0]; //only look at the controller on Port 1 of the adapter

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
    var axes = {
    	"MAINSTICKHorizontal": sanitizeAxis(controller.axes.MAINSTICKHorizontal, mainStickInitial.x),
    	"MAINSTICKVertical": sanitizeAxis(controller.axes.MAINSTICKVertical, mainStickInitial.y),
    	"CSTICKHorizontal": sanitizeAxis(controller.axes.CSTICKHorizontal, cStickInitial.x),
    	"CSTICKVertical": sanitizeAxis(controller.axes.CSTICKVertical, cStickInitial.y)
    };


    
    //Handle buttons
    Object.keys(buttons).forEach(function(buttonName) {
    	var buttonActive = buttons[buttonName]; //whether the button is pressed
    	var buttonCommand = config[buttonName];
    	var holdStatus = heldButtons[buttonName];

    	if(buttonActive) {

	    	if(buttonReady(buttonName)) { //account for timeout (only applies to non-holding buttons?)
	    		performCommand(buttonName, buttonCommand);
	    		buttonTimeout(buttonName);
	    	}

    	} else if(holdStatus !== undefined && holdStatus.holding) {
    		stopHolding(holdStatus);
    	}

    });

    //Handle axes
    //Round degrees to the nearest notch (45 degrees) using a separate function
    //At 45 degree notches, input both directions. At 0, 90, 180, and 270, input only one direction.
    var directionalAxisInput = {};

    //Main stick
    if(axes.MAINSTICKVertical != 0 && axes.MAINSTICKHorizontal != 0) {
    	splitSanitizedAxes("MAINSTICK", directionalAxisInput);
    }

    //C stick
    if(axes.CSTICKVertical != 0 && axes.CSTICKHorizontal != 0) {
    	splitSanitizedAxes("CSTICK", directionalAxisInput);
    }

    Object.keys(directionalAxisInput).forEach(function(direction) {
    	var directionActive = directionalAxisInput[direction]; //whether the direction on the stick is being inputted
    	var directionCommand = config[direction];
    	var holdStatus = heldButtons[direction];

    	if(directionActive) {
    		performCommand(direction, directionCommand);
    	} else if(holdStatus !== undefined && holdStatus.holding) {
    		stopHolding(holdStatus);
    	}

    });

    return;
});

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
function splitSanitizedAxes(stickName, outputObj) {
	var stickDegrees = Math.atan2(axes[stickName + "Vertical"], axes[stickName + "Horizontal"]) * 180/Math.PI;
    if(stickDegrees < 0) { stickDegrees += 360; }

    var stickNotch = nearest45(stickDegrees);

    outputObj[stickName + "UPAxis"] = (stickNotch === 45 || stickNotch === 90 || stickNotch === 135);
    outputObj[stickName + "DOWNAxis"] = (stickNotch === 225 || stickNotch === 270 || stickNotch === 315);
    outputObj[stickName + "LEFTAxis"] = (stickNotch === 135 || stickNotch === 180 || stickNotch === 225);
    outputObj[stickName + "RIGHTAxis"] = (stickNotch === 0 || stickNotch === 45 || stickNotch === 315);	
}

function nearest45(degrees) {
	return Math.round(degrees/45.0) * 45;
}

function performCommand(button, command) {

	if(command.startsWith("kb")) { //handle keyboard presses
	    var key = command.substring(3, command.length);

	    if(config.WASDHold && (key === "w" || key === "a" || key === "s" || key === "d")) {
	    	robot.keyToggle(key, "down");

	    	heldButtons[button] = {
	    		holding: true,
	    		isClick: false,
	    		cmd: key
	    	};

	    } else {
	    	robot.keyTap(key);	
	    }

	} else if(command.startsWith("mouse")) { //handle mouse actions

	    if(command.startsWith("mouse_click")) { //mouse clicks
	    	
	    	var click = command.substring(12, command.length);

	    	if(config.ClickHold) { //hold the mouse down and release it later
	    		robot.mouseToggle("down", click);

	    		heldButtons[button] = {
	    			holding: true,
	    			isClick: true,
	    			cmd: click
	    		};

	    	} else { //click the mouse once
	    		robot.mouseClick(click, false);
	    	}	
	    	
	    } else { //mouse movements
	    	var direction = command.substring(6, command.length);	
	    	var curPos = robot.getMousePos();

	    	robot.moveMouse(curPos.x + mouseMovement[direction].xShift, curPos.y + mouseMovement[direction].yShift);
	    }	
	}

}

function buttonReady(buttonName) {
	var lastTime = lastButtonTimes[buttonName];

	return lastTime === undefined || (Date.now() > lastTime + pollingTimeout);
}

function buttonTimeout(buttonName) {
	lastButtonTimes[buttonName] = Date.now();
}

function quitProgram() {
    gca.stopAdapter(adapter);
    process.exit();
}

function sanitizeAxis(reading, initial) {
    var change = reading - initial; //get the current input relative to the stick's neutral (initial) position
        
    //If there is no difference in the reading vs the initial reading, or it's not enough to pass the
    //threshold, discard the input (by setting it to 0)
    if(change === 0 || Math.abs(change) < axisThreshold) {
        change = 0;
    }

    return change;
}