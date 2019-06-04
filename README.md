# GCMouse
GameCube Controller to Keyboard/Mouse Software

Still in development



notes:
-For the config app, the key recorder lets the combobox select most of the common keyboard keys. Mouse events are still selected manually

-Default config should have main stick toggle keys on, but c-stick toggle keys off

-Add options for holding the mouse (toggling it pressed or unpressed)

-For the node js app, use a Map where the button's name maps to a JS object containing:
  1) is it a key or a mouse event
  2) is toggling applicable
  3) what key/mouse event to tap/hold down/release from holding, etc)
  
  For the axes, you have to manually handle each direction individually
