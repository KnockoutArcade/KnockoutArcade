/// @description Insert description here
// You can write your code in this editor

state = eSetControlsState.OPENING; // The current state of this object

enum eSetControlsState
{
	OPENING, // Menu is opening
	WAIT_FOR_INPUT, // Menu is currently waiting for it's player to press START
	TURN_TO_FACE, // Menu is turning to face the screen
	ACTIVE, // Menu is currently allowing you to set controls
	TURN_AWAY, // Menu is turning to face away from camera
	LEAVE // Menu is exiting
}

animTimer = 0; // The animation timer for this object

playerNumber = 0; // Which player is currently controlling this object (0 = P1, 1 = P2)
playerControls = global.player1Controls;
playerControlsType = global.player1ControllerType;

// Selection Vars
selectedRow = 0; // Which row we have currently selected
selectedOption = 0; // Which option we currently have selected
maxSelections = 13; // How many options the player can select from
topRowOption = 0; // Which option is currently at the top of the list
maxOnScreenOptions = 8; // The maximum number of options allowed to be displayed on screen at a time

cursorCooldown = 0; // How long until the cursor can move again
cursorCooldownAmount = 13; // How much cooldown to add when the cursor moves

isCurrentlySettingButton = false;

// Options Array
controlsOptions = [
	eControlsOptions.UP,
	eControlsOptions.DOWN,
	eControlsOptions.LEFT,
	eControlsOptions.RIGHT,
	
	eControlsOptions.LIGHT,
	eControlsOptions.MEDIUM,
	eControlsOptions.HEAVY,
	eControlsOptions.SPECIAL,
	
	eControlsOptions.GRAB,
	eControlsOptions.RUN,
	eControlsOptions.SUPER,
	
	eControlsOptions.RESTORE_DEFAULTS,
	eControlsOptions.CONFIRM
];

enum eControlsOptions
{
	UP,
	DOWN,
	LEFT,
	RIGHT,
	LIGHT,
	MEDIUM,
	HEAVY,
	SPECIAL,
	GRAB,
	RUN,
	SUPER,
	RESTORE_DEFAULTS,
	CONFIRM
}