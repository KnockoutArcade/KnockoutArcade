/// @description Insert description here
// You can write your code in this editor

// When adding a new button to the game, the 2 scripts to edit are the GetPlayerInputs script and the
// SetPlayerButton script. After that, you can reference the new button elsewhere by checking if
// global.pXbuttonY is true, where x is the player to check and Y is the button

global.lastControllerButton = -1;

global.player1ControllerSlot = -1;
global.player2ControllerSlot = -1;

global.player1ControllerType = "KEYBOARD";
global.player2ControllerType = "KEYBOARD";


SetPlayerButtons();

ControllerSetup();

LoadControls();