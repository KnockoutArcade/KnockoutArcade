/// @description Insert description here
// You can write your code in this editor

// The current state of the character select screen
state = eCharacterSelectState.CONTROLLER_ASSIGN; 

enum eCharacterSelectState
{
	CONTROLLER_ASSIGN,
	CHARACTER_SELECT,
	STAGE_SELECT,
	MUSIC_SELECT,
	TRANSITION_TO_FIGHT
}

P1charSelRow = 0;
P1charSelCol = 0;
P1cursorCooldown = 5;
P2charSelRow = 0;
P2charSelCol = 2;
P2cursorCooldown = 5;

charSelRowMax = 1;
charSelColMax = 2;

P1mapSelRow = 0;
P1mapSelCol = 0;

mapSelRowMax = 1;
mapSelColMax = 3;

P1musicSelRow = 0;
musicSelRowMax = 5;


p1charSelFrameRate = 10;
p1charSelAnimTimer = 0;
p2charSelFrameRate = 10;
p2charSelAnimTimer = 0;

P1charSelCurrentFrame = 0;
P2charSelCurrentFrame = 0;

// Palettes to use for the selected character
p1LocalPalette = global.characterData[0];
p2LocalPalette = global.characterData[0];

RusselPaletteData = {};
BeverlyPaletteData = {};
JayPaletteData = {};
GuntherPaletteData = {};

// Run through palette data to make it easier to reference later
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Russel")
	{
		RusselPaletteData = global.characterData[i];
	}
	else if (global.characterData[i].Name == "Beverly")
	{
		BeverlyPaletteData = global.characterData[i];
	}
	else if (global.characterData[i].Name == "Jay")
	{
		JayPaletteData = global.characterData[i];
	}
	else if (global.characterData[i].Name == "Gunther")
	{
		GuntherPaletteData = global.characterData[i];
	}
}



charSelBoxTimer = 0;
charSelBoxAlt = false;

mapSelBoxTimer = 0;
mapSelBoxAlt = false;

musicSelBoxTimer = 0;
musicSelBoxAlt = false;

P1hasSelectedChar = false;
P2hasSelectedChar = false;
P1hasSelectedAlt = false;
P2hasSelectedAlt = false;
P1hasSelectedMap = false;
P1hasSelectedMusic = false;

selectedMusic = 0; // Values correspond with sprite frame in sStageSelect_MusicNames_strip4
selectedStage = 0; // The stage ID that we have selected to play on

RTF_animTimer = 0;
RTF_frameRate = 30;
RTF_currentFrame = 0;

transitionTimer = 0; // Time to keep track of the transition
transitionLength = 244; // How long the transition screen should stay up for (in frames)
transitionFrame = 240; // When the game switches to a new room (in frames)
transitionObject = noone; // The object that handles transition animations

// Controls Menu
P1ControlsMenuObj = noone;
P2ControlsMenuObj = noone;

// Controller Assignement
#region

// These are the 4 controllers that show up on the assignment screen
controllerAssign = [];
numberOfMaxAssignedControllers = 4;

controllerAssignData = [];

// Create an array of controller IDs for handling
var controllerArray = [];
	
// Add pads first
for (var i = 0; i < ds_list_size(oControllerManager.controllers); i++;)
{
	if (oControllerManager.controllers[| i].controllerType == CONTROLLER_TYPES.PAD)
	{
		array_push(controllerArray, oControllerManager.controllers[| i].controllerInstance);
	}
}
	
// If we have 2 or fewer controllers, add both keyboard controls to the array
if (array_length(controllerArray) <= 2)
{
	array_push(controllerArray, FindController(13));
	array_push(controllerArray, FindController(14));
}
else if (array_length(controllerArray) <= 3)
{
	array_push(controllerArray, FindController(13)); // Otherwise, only add WASD if there's exactly 3 controllers
}

// Assign the controllers
for (var j = 0; j < numberOfMaxAssignedControllers && j < array_length(controllerArray); j++;)
{
	controllerAssign[j] = controllerArray[j];
	
	controllerAssignData[j] = {
		xPos : 0,
		yPos : 0,
		
		playerSide : 0, // -1 = P1, 0 = middle, 1 = P2
		cursorCooldown : 0
	}
}



p1SideController = -1; // Whether each player side is currently occupied or not
p2SideController = -1;

p1SideControllerSlot = -1; // Which controller slot each player is watching for
p2SideControllerSlot = -1;

p1IsCPU = false; // Whether each side is a CPU or not
p2IsCPU = false;

sortControllers = function SortControllers() 
{
	var padControllers = [];
	var padControllersData = [];
	
	var nonPadControllers = [];
	var nonPadControllersData = [];
	
	// Go through each controller and sort them into different arrays
	for (var i = 0; i < array_length(controllerAssign); i++;)
	{
		if (controllerAssign[i].controllerType == CONTROLLER_TYPES.PAD)
		{
			array_push(padControllers, controllerAssign[i]);
			array_push(padControllersData, controllerAssignData[i]);
		}
		else
		{
			array_push(nonPadControllers, controllerAssign[i]);
			array_push(nonPadControllersData, controllerAssignData[i]);
		}
	}
	
	// Reset Controller Assign
	controllerAssign = [];
	controllerAssignData = [];
	
	// Rebuild Controller Assign
	for (var j = 0; j < array_length(padControllers); j++;)
	{
		array_push(controllerAssign, padControllers[j]);
		array_push(controllerAssignData, padControllersData[j]);
	}
	for (var k = 0; k < array_length(nonPadControllers); k++;)
	{
		array_push(controllerAssign, nonPadControllers[k]);
		array_push(controllerAssignData, nonPadControllersData[k]);
	}
	
	p1SideController = -1;
	p2SideController = -1;
	
	// Go through the new data one more time and update the player sides
	for (var l = 0; l < array_length(controllerAssignData); l++;)
	{
		if (controllerAssignData[l].playerSide == -1)
		{
			p1SideController = controllerAssign[l];
		}
		else if (controllerAssignData[l].playerSide == 1)
		{
			p2SideController = controllerAssign[l];
		}
	}
}

#endregion


#region // Controller Updating

// Add this to the list of objects to be notified when the controllers disconnect
// Check if this ID is already in there first
if (ds_list_find_index(oControllerManager.controllerUpdateNotifyList, id) == -1)
{
	ds_list_add(oControllerManager.controllerUpdateNotifyList, id);
}

// Update controller script
controllerUpdate = function ControllerUpdate(_isNewConnected, _controllerID)
{
	// If a controller was added
	if (_isNewConnected)
	{
			array_push(controllerAssign, FindController(_controllerID.controllerSlot));
		
			array_push(controllerAssignData, 
			{
				xPos : 0,
				yPos : 0,
		
				playerSide : 0, // -1 = P1, 0 = middle, 1 = P2
				cursorCooldown : 0
			}
			)
		
			sortControllers();
			
			// Handle reassigning the controller if it reconnects
			if (_controllerID.controllerSlot == p1SideControllerSlot)
			{
				p1SideController = _controllerID;
			}
			
			if (_controllerID.controllerSlot == p2SideControllerSlot)
			{
				p2SideController = _controllerID;
			}
			
			show_debug_message("Controller connected");
	}
	else
	{
		// Go through each controller to find the one that disconnected and remove it
		for (var i = 0; i < array_length(controllerAssign); i++;)
		{
			if (controllerAssign[i] == _controllerID)
			{
				// If it was on a side, remove it
				if (p1SideController == controllerAssign[i])
				{
					p1SideController = -1;
				}
				if (p2SideController == controllerAssign[i])
				{
					p2SideController = -1;
				}
				
				array_delete(controllerAssign, i, 1);
				array_delete(controllerAssignData, i, 1);
				
				show_debug_message(controllerAssign);
			}
		}
		
		sortControllers();
	}
}
#endregion