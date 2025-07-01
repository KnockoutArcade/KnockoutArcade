/// @description Insert description here
// You can write your code in this editor

// When adding a new button to the game, the 2 scripts to edit are the GetPlayerInputs script and the
// SetPlayerButton script. After that, you can reference the new button elsewhere by checking if
// global.pXbuttonY is true, where x is the player to check and Y is the button


// Get the number of controllers
var gp_num = gamepad_get_device_count();
var numOfControllers = 0;
for (var i = 0; i < gp_num; i++;)	
{
	if (gamepad_is_connected(i))
	{
		numOfControllers++;
	}
}

// Create a list with however many controllers are connected
// We always add 2 for WASD and Arrow Keys
controllers = ds_list_create();

// Iterate through each controller and initialize them
for (var i = 0; i < (numOfControllers); i++;)
{
	var controllerSlotData = {
		controllerInstance : instance_create_depth(0, 0, 0, oController),
		controllerSlotID : i,
		controllerType : "pad"
	}
	
	ds_list_add(controllers, controllerSlotData);
}

// Add WASD and Arrow Keys to the controls
var controllerSlotData = {
	controllerInstance : instance_create_depth(0, 0, 0, oController),
	controllerSlotID : 13, // Specific slot for WASD
	controllerType : "wasd"
}
ds_list_add(controllers, controllerSlotData);

controllerSlotData = {
	controllerInstance : instance_create_depth(0, 0, 0, oController),
	controllerSlotID : 14, // Specific slot for Arrow Keys
	controllerType : "arrow"
}
ds_list_add(controllers, controllerSlotData);

//show_debug_message(controllers[| 0]);

global.lastControllerButton = -1;

global.player1ControllerSlot = -1;
global.player2ControllerSlot = -1;

global.player1ControllerType = "KEYBOARD";
global.player2ControllerType = "KEYBOARD";

// Set Default Controls
ControllerSetup();

LoadControls();

// If the controls do not have a version number, update them
if (!variable_struct_exists(global.player1Controls, "versionNumber"))
{
	SetPlayerButtons();
	SaveControls();
	LoadControls();
	
	show_debug_message("Updated old control data");
}


