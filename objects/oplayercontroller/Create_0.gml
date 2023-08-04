/// @description Insert description here
// You can write your code in this editor


// Determines which player port this object is using (Player 1, Player 2, etc)
playerID = 1;

// Movment Variables
hsp = 0; // Horizontal speed
environmentDisplacement = 0;
vsp = 0; // Vertical speed
walkSpeed = selectedCharacter.WalkSpeed; // How fast the character walks in pixels/frame
runSpeed = selectedCharacter.RunSpeed; // How fast the character runs in pixels/frame
traction = selectedCharacter.Traction; // How much this character slows down each frame in pixels/frame
jumpSpeed = selectedCharacter.JumpSpeed; // How high a character jumps - Initial Jump velocity
fallSpeed = selectedCharacter.FallSpeed; // How fast a character falls

// Movement SFX Variables
WalkingSoundEffect = selectedCharacter.NonmoveSoundData.WalkingSoundEffect; // What sound effect to play when walking
WalkForwardFootsteps = selectedCharacter.NonmoveSoundData.WalkForwardFootsteps; // List of which image frames should play a sound effect
WalkBackwardFootsteps = selectedCharacter.NonmoveSoundData.WalkBackwardFootsteps;
previousWalkFrame = 0; // Stores the image_index for the previous walk frame (used to know when a frame has been changed)

RunningSoundEffect = selectedCharacter.NonmoveSoundData.RunningSoundEffect;
RunForwardFootsteps = selectedCharacter.NonmoveSoundData.RunForwardFootsteps;
RunBackwardFootsteps = selectedCharacter.NonmoveSoundData.RunBackwardFootsteps;
initialDashSFX = sfx_Jump;

// Running variables
runningForward = false; // Used to tell if the player is running forward or not
runningBackward = false; // Used to tell if the player is running backward or not
holdForwardTimer = 8; // Determines the amount of time forward is held
holdBackwardTimer = 8; // Determines the amount of time backward is held
startedMovingForward = false; // Used to reset the runForwardTimer
startedMovingBackward = false; // Used to reset the runBackwardTimer
runForwardTimer = 16; // Used for running by double tapping forward
runBackwardTimer = 16; // Used for backdashing by double tapping backward

//Backdash Vars (The state is refered to as Run back for consistency)
backdashDuration = selectedCharacter.BackDashDuration; // The total duration of a character's backdash
backdashInvincibility = selectedCharacter.BackDashInvincibility; // How long the character is invincible for at the start of their backdash
backdashSpeed = selectedCharacter.BackDashSpeed; // How fast their backdash moves them back
backdashStartup = selectedCharacter.BackDashStartup; // The delay before the character starts moving back


// A short hop is when the player breifly taps up so they don't jump as high.

fastFallSpeed = selectedCharacter.FastFallSpeed; // How fast a character's short hop is if they have one
isShortHopping = false; // Whether or not a character is currently shorthopping
if (selectedCharacter.JumpType & 4 == 4)
{
	canShortHop = true; // Whether the player can shorthop or not
}
else
{
	canShortHop = false;
}

// A super jump is when the player presses Down just before jumping, allowing them to go higher.

if (selectedCharacter.JumpType & 2 == 2)
{
	canSuperJump = true; // Whether this character can Super Jump or not
}
else
{
	canSuperJump = false;
}
isSuperJumping = false; // Is the player currently super jumping?
storedSuperJump = false; // Whether the player has their super jump stored or not
superJumpTimer = 0; // The amount of time the player has stored their jump for
jumpAttackBuffer = 0; // Which attack to buffer out of jumpsquat

// A double jump is when the player jumps again in the air

if ((selectedCharacter.JumpType & 1) == 1)
{
	canDoubleJump = true; // Whether this character can Double Jump or not
}
else
{
	canDoubleJump = false;
}
hasSpentDoubleJump = false; // Whether the player has spent their Double Jump
heldUpFrames = 0; // How long the player has held UP for

jumpHsp = 0; // How much momentum the player is carrying with their jump
isJumpingForward = false; // Whether the player approaching the opponent with their jump or not.
movedir = 0;
verticalMoveDir = 0;
grounded = true;

// Variables for motion inputs
inputSet = false;
motionInput = []; // Determines the inputs to perform during each special move
listOfInputs = ds_list_create();
progressInInputs = []; // Holds the indexes of each motion input to determine progress through each input
enhanced = []; // Enhances the special move if the motion input is performed
changeFrame = 999; // Frame when the move changes if you perform the motion input if changeImmediately is false
changeImmediately = false; // If true, changes special move as soon as the input is performed
// How long the player has to perform the special move
inputWindowStart = 0;
inputWindowEnd = 0;
requireSpecialButton = false; // Check to see if the enhancer requires the special button to be pressed

// Variables for Rush Cancel
rcActivated = false;
rcBuffer = false; // Used to activate Rush Cancel after exiting screen freeze
rcBufferTimer = 0; // Doesn't activate Rush Cancel if in buffer for more than the designated interval
rcBufferInterval = 0;
rcFreezeTimer = 0; // Counts up to 30 frames, then deactivates the freeze frame
rcForwardTimer = 0; // Handles duration of Rush Cancel Forward run
runButtonPressed = false; // Triggers when the run button is pressed
holdRunButtonTimer = 8; // Determines the amount of frames the run button is held
pressSpecialButtonTimer = 8; // Determines the amount of frames since the special button was pressed

// Screen Freeze variables
activateFreeze = false; // Determines if opponent activated screen freeze
stateBeforeFreeze = 0; // Different from prevState
// Stores movement before SCREEN_FREEZE
freezeHSP = 0; // Horizontal speed
freezeEnvironmentDisplacement = 0;
freezeVSP = 0; // Vertical speed

// Controller Controls
controller = -1;

// Unused Buffer Variables
buffer = 0;
bufferTimer = 0;

// Animation Variables
animTimer = 0;
animOffset = 4; // How many frames to offset an animation by (specifically during hitstop)
depth = 0;

// These variables are from the destructable object. It lets us know that this object is not destructable
knockbackMultiplier = 1; // Multiplier for how much knockback this object takes.
launchable = true; // Whether this object can be launched or not
isDestructibleObject = false; // Identify this object as destructable
isThrowable = true; // whether we can throw this object around or not

enum eState {
	INTRO,
	IDLE,
	WALKING,
	RUN_FORWARD,
	RUN_BACKWARD,
	JUMPING,
	JUMPSQUAT,
	CROUCHING,
	STANDING_LIGHT_ATTACK,
	STANDING_LIGHT_ATTACK_2,
	STANDING_LIGHT_ATTACK_3,
	STANDING_MEDIUM_ATTACK,
	STANDING_HEAVY_ATTACK,
	CROUCHING_LIGHT_ATTACK,
	CROUCHING_MEDIUM_ATTACK,
	CROUCHING_HEAVY_ATTACK,
	JUMPING_LIGHT_ATTACK,
	JUMPING_MEDIUM_ATTACK,
	JUMPING_HEAVY_ATTACK,
	NEUTRAL_SPECIAL,
	SIDE_SPECIAL,
	UP_SPECIAL,
	DOWN_SPECIAL,
	ENHANCED_NEUTRAL_SPECIAL,
	ENHANCED_SIDE_SPECIAL,
	ENHANCED_UP_SPECIAL,
	ENHANCED_DOWN_SPECIAL,
	ENHANCED_NEUTRAL_SPECIAL_2,
	ENHANCED_SIDE_SPECIAL_2,
	ENHANCED_UP_SPECIAL_2,
	ENHANCED_DOWN_SPECIAL_2,
	COMMAND_NORMAL_1,
	COMMAND_NORMAL_2,
	COMMAND_NORMAL_3,
	REKKA_LAUNCHER,
	REKKA_FINISHER,
	REKKA_CONNECTER,
	REKKA_LOW,
	REKKA_HIGH,
	SUPER,
	GRAB,
	COMMAND_GRAB,
	HOLD,
	FORWARD_THROW,
	BACKWARD_THROW,
	BEING_GRABBED,
	THROW_TECH,
	HURT,
	LAUNCHED,
	KNOCKED_DOWN,
	GETUP,
	HITSTOP,
	BLOCKING,
	RUSH_CANCEL_FORWARD,
	RUSH_CANCEL_UP,
	RUSH_CANCEL_AIR,
	SCREEN_FREEZE
}

enum eAttackType {
	HIGH = 0, // Must be stand blocking
	MID = 1, // Block high or low
	LOW = 2, // Must Block Crouching
	GRAB = 3, // Basic grab
	COMMAND_GRAB = 4 // Advanced type of grab with special properties
}

enum eSpritesToUse {
	HURT_SPRITE,
	GRAB_SPRITE,
	KNOCKDOWN_SPRITE,
}

CharacterSprites = {
	idle_Sprite : selectedCharacter.Sprites.Idle,
	crouch_Sprite : selectedCharacter.Sprites.Crouch,
	standBlock_Sprite : selectedCharacter.Sprites.StandBlock,
	crouchBlock_Sprite : selectedCharacter.Sprites.CrouchBlock,
	walkForward_Sprite : selectedCharacter.Sprites.WalkForward,
	walkBackward_Sprite : selectedCharacter.Sprites.WalkBackward,
	runForward_Sprite : selectedCharacter.Sprites.RunForward,
	runBackward_Sprite : selectedCharacter.Sprites.RunBackward,
	jumpsquat_Sprite : selectedCharacter.Sprites.JumpSquat,
	jump_Sprite : selectedCharacter.Sprites.Jump,
	hurt_Sprite : selectedCharacter.Sprites.Hurt,
	grab_Sprite : selectedCharacter.Sprites.Grab,
	hold_Sprite : selectedCharacter.Sprites.Hold,
	launched_Sprite : selectedCharacter.Sprites.Launched,
	knockdown_Sprite : selectedCharacter.Sprites.Knockdown,
	getup_Sprite : selectedCharacter.Sprites.GetUp,
}

// State-related Variables
state = eState.IDLE;
prevState = 0;
inAttackState = false;
canTurnAround = true;
cancelOnLanding = true; // whether or not the character should cancel their current air attack if they land

// Intro
hasPerformedIntro = true;

//This variable stores who we are up against in a 1v1 fight
opponent = noone;

//This variable stores who we are currently attacking
target = noone;

// Hurtbox Variables
hurtbox = instance_create_layer(x - 7, y, "hitboxes", oPlayerHurtbox);
with (hurtbox) 
{
	primary = true;
	owner = other.id;
	image_xscale = 15;
	image_yscale = 32;
}
hurtboxOffset = -9;

hitstun = 0; // How long we are in hitSTUN for
hitstop = 0; // How long we are in hitSTOP for
hitstopBuffer = false;
prevSprite = 0;
blockstun = 0;
isCrouchBlocking = false;
blockbuffer = false;
xHome = x;
hitstunShuffleTimer = 0;
shuffle = 0;
framesSinceHitstun = 0; // Used to help make attacks connect when cancelling special moves

isGrabbed = false;

invincible = false;
projectileInvincible = false;

hitByGroup = ds_list_create();
ds_list_clear(hitByGroup);
// Note to self: any time the player exits the move they are currently doing, the hitByGroup list MUST be cleared!


toggleIdleBlock = false;
cancelable = false;
canBlock = false;

knockbackVel = 0;
pushbackVel = 0;

maxHitPoints = selectedCharacter.MaxHP;
hp = maxHitPoints;

frameAdvantage = false;
FAvictim = false;

heldOpponent = noone;

// Combo Related Variables
combo = 0;
comboCounterID = noone;
comboScaling = 0; // How much the next hit will be scaled
startCombo = false;
cancelCombo = false;
comboDamage = 0; // Records how much damage a combo did
storedComboDamage = 0; // Used as a debug variable to display combo damage

//Meter Related Variables
superMeter = 100; // the amount of meter the player has
meterBuildRate = 0.05; // The rate at which the player builds meter by approaching
meterScaling = 1; // How much meter gain will be scaled (multiplier)
hasUsedMeter = false; // Whether the player has used a move that requires meter or not

// Palette Init
PaletteSetup(0, selectedCharacter);
isEXFlash = false; // Whether or not the player should be flashing
EXFlashTimer = 0; // Timer for EXFlash
displayEXFlash = false; // Toggle for the flashing

// Character speed trail variables
speedTrailTimer = 0;

// Moveset-switching related variables
currentMovesetID = 1; // Which sub-set of a character's moves are we using (starts at 1)
if (selectedCharacter.UniqueData.AdditionalMovesets > 0) // If this character has multiple movesets...
{
	// Iterate through each entry in MoveData (this contains every attack, used or not)
	// Within each entry, iterate through InMovesets to determine if each move belongs in the player's
	// current moveset. If InMovesets[j] = currentMovesetID, then we know that that move should be in
	// the active moveset. To add the move, simply overwrite what was already there.
	OverwriteMoveset();
}

// Spirit Data
spiritState = false; // false = Spirit OFF, false = Spirit ON
spirit = noone;
spiritObject = noone;
spiritSummoned = false;
spiritBroken = false; // Host cannot summon spirit when the spirit loses all its health
spiritMaxHealth = 0;
spiritCurrentHealth = 0;
spiritRegenSpeed = 0;
spiritKORegenSpeed = 0;
if (selectedCharacter.UniqueData.SpiritData == 1)
{
	for (var i = 0; i < array_length(global.characterData); i++)
	{
		if (selectedCharacter.UniqueData.Spirit == global.characterData[i].Name)
		{
			spirit = global.characterData[i];
			spiritMaxHealth = spirit.MaxHP;
			spiritCurrentHealth = spiritMaxHealth;
			spiritRegenSpeed = spirit.RegenSpeed;
			spiritKORegenSpeed = spirit.KORegenSpeed;
			break;
		}
	}
}
// If host is trying to summon/unsummon spirit but gets interrupted, spirit gets summoned after hitstop
pendingToggle = false;

// Data used by spirits, but kept here to avoid errors
host = noone;
hostObject = noone;