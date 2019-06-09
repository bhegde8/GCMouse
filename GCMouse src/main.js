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

//Account for insignificant axes inputs
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
    	var buttonActive = (buttons[buttonName] === 1); //whether the button is pressed
    	var buttonCommand = config[buttonName];

    	if(buttonActive) {

	    	if(buttonReady(buttonName)) { //account for timeout (only applies to non-holding buttons?)

	    		if(buttonCommand.startsWith("kb")) { //handle keyboard presses
	    			var key = buttonCommand.substring(3, buttonCommand.length);
	    			robot.keyTap(key);
	    		} else if(buttonCommand.startsWith("mouse")) { //handle mouse actions

	    			if(buttonCommand.startsWith("mouse_click")) { //mouse clicks
	    				var click = buttonCommand.substring(12, buttonCommand.length);
	    				robot.mouseClick(click, false);
	    			} else { //mouse movements
	    				var direction = buttonCommand.substring(6, buttonCommand.length);	
	    				var curPos = robot.getMousePos();

	    				robot.moveMouse(curPos.x + mouseMovement[direction].xShift, curPos.y + mouseMovement[direction].yShift);
	    			}
	    		}

	    		buttonTimeout(buttonName);
	    	}

    	}

    });

    //Handle axes
    var mainStickDegrees = Math.atan2(axes.MAINSTICKVertical, axes.MAINSTICKHorizontal) * 180/Math.PI;
    if(mainStickDegrees < 0) { mainStickDegrees += 360; }

    var cStickDegrees = Math.atan2(axes.CSTICKVertical, axes.CSTICKHorizontal) * 180/Math.PI;
    if(cStickDegrees < 0) { cStickDegrees += 360; }

    //Round degrees to the nearest 45 degree notch
    //At 45 degree notches, input both directions. At 0, 90, 180, and 270, input only one direction.


    return;
});

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