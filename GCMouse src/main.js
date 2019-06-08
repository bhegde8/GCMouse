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

//Start dealing with inputs from the GC adapter
gca.pollData(adapter, function(data) {
    var controller = gca.objectData(data)[0]; //only look at the controller on Port 1 of the adapter
    var buttons = controller.buttons;
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

    
    //Handle buttons
    Object.keys(buttons).forEach(function(buttonName) {
    	var buttonActive = (buttons[buttonName] === 1); //whether the button is pressed
    	var buttonCommand = config[buttonName];

    	

    }



    return;
})

function quitProgram() {
    gca.stopAdapter(adapter);
    process.exit();
}

function getAnalogStickMagnitude(reading, initial) {
    var change = reading - initial; //get the current input relative to the stick's neutral (initial) position
        
    //If there is a difference and it is significant enough to pass the 0.1 threshold, scale the magnitude to the mouse sensitivity setting
    if(change != 0 && Math.abs(change) > 0.1) {
        change *= sensitivity;
    } else { //Otherwise, the magnitude should be 0 so that nothing happens.
        change = 0;
    }

    return change;
}