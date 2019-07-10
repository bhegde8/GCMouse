# GCMouse
GameCube Controller to Keyboard/Mouse Software
(For Windows x64 only as of now)

## Introduction
This program lets you use a GameCube controller on your PC to control the mouse and keyboard.
For example, it could allow you to play FPS games on your PC.

## Supported USB Adapters
Any adapters not listed here might not work with this software.
However, as long as the adapter is a WUP-028 device and can work with Dolphin's GameCube controller adapter
option, there's a good chance it will work here.

* Mayflash GameCube Controller Adapter (Wii U/PC/Switch) --> MUST BE SET TO Wii U/NS mode, not PC mode!
* Nintendo GameCube Controller Adapter (Wii U)
* Nintendo GameCube Controller Adapter (Switch)

## Installation
1. If you haven't set up the drivers for your GameCube controller adapter yet,
see [this guide](https://www.maketecheasier.com/use-gamecube-controller-with-dolphin/)

2. Get [the latest release of GCMouse](https://github.com/bhegde8/GCMouse/releases)

3. Extract the GCMouse folder inside the .zip file somewhere

## Usage
[Tutorial video (targeted at PC shooter games)](https://www.youtube.com/watch?v=ybhIr61W2OM)

1. Plug the GameCube controller adapter (the black USB cable) into your PC

2. Plug a GameCube controller into Port 1 of the adapter

3. Set up your controls in GCConfig.exe
* By default, FPS optimized controls are set. (see the video for info)
* Click the red text and press a key on your keyboard to map the controller button to a keyboard key press
* Click the Mouse... button and select a mouse event to map the controller button to a mouse click/movement
* The Mouse Sensitivity slider controls the cursor movement speed
* The check boxes control whether the controller single presses or holds the WASD keys and mouse clicks (keep enabled for games)
* The Load Defaults button loads the default configuration
* Press Save and Exit to save the config and exit
* Note: If you set the Main Stick or the C-Stick to move the mouse up, down, left, and right, these mouse movements will be full 360 range smooth movements. If you use the D-Pad to control the mouse cursor, the movements won't be as natural since it's only 4 directions.

4. Run the GCMouse.exe program to use your controller after your config is set up
* If all goes well, the window should stay open and you will be able to use your controller to control your PC now. You can use it for games, web browsing, etc.
* If the program closes, make sure:
    * Your adapter's black USB cable is plugged into the PC
    * You have set up the WinUSB driver for the adapter with Zadig. You can use the Dolphin Emulator to verify.
    * Your controller is on __Port 1__ of the adapter.
    * You're using a 64-bit Windows OS
* If you still can't get it to work, try this:
    * Open a game in the Dolphin Emulator with your GameCube controller and use it in Dolphin for a few seconds before using this program.
    * Or move the sticks on your controller, and keep reopening the program until it works. Sometimes, the adapter doesn't work initially.

## Problems/Bugs/Suggestions
[Please open an issue here if you find any problems or want to suggest something](https://github.com/bhegde8/GCMouse/issues)


