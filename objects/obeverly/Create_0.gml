/// @description Insert description here
// You can write your code in this editor

// Determines which player port this object is using (Player 1, Player 2, etc)
playerID = 1;

// Movment Variables
hsp = 0; // Horizontal speed
environmentDisplacement = 0;
vsp = 0; // Verticle speed
walkSpeed = 1.25; // How fast the character walks in pixels/frame
runSpeed = 2.5; // How fast the character runs in pixels/frame
traction = .5; // How much this character slows down each frame in pixels/frame
jumpSpeed = 4.5 // How high a character jumps - Initial Jump velocity
fallSpeed = .25; // How fast a character falls

//Backdash Vars (The state is refered to as Run back for consistency)
backdashDuration = 25; // The total duration of a character's backdash
backdashInvincibility = 8; // How long the character is invincible for at the start of their backdash
backdashSpeed = 5; // How fast their backdash moves them back
backdashStartup = 3; // The delay before the character starts moving back

fastFallSpeed = .35; // How fast a character's short hop is if they have one
isShortHopping = false; // Whether or not a character is currently shorthopping
canShortHop = false; // Whether the player can shorthop or not

canSuperJump = true; // Whether this character can Super Jump or not
isSuperJumping = false; // Is the player currently super jumping?
storedSuperJump = false; // Whether the player has their super jump stored or not
superJumpTimer = 0; // The amount of time the player has stored their jump for

canDoubleJump = false; // Whether this character can Double Jump or not
hasSpentDoubleJump = false; // Whether the player has spent their Double Jump
heldUpFrames = 0; // How long the player has held UP for

jumpHsp = 0; // How much momentum the player is carrying with their jump
isJumpingForward = false; // Whether the player approaching the opponent with their jump or not.
movedir = 0;
verticalMoveDir = 0;
grounded = true;

// Controller Controls
controller = -1;

// Unused Buffer Variables
buffer = 0;
bufferTimer = 0;

// Animation Variables
animTimer = 0;
animOffset = 4; // How many frames to offset an animation by (specifically during hitstop)
depth = 0;

CharacterSprites = {
	idle_Sprite : sBeverly_Idle,
	crouch_Sprite : sBeverly_Crouch_MOCKUP,
	standBlock_Sprite : sRussel_Block,
	crouchBlock_Sprite : sRussel_Crouch_Block,
	walkForward_Sprite : sRussel_Walk_Forward,
	walkBackward_Sprite : sRussel_Walk_Backward,
	runForward_Sprite : sRussel_Run_Forward,
	runBackward_Sprite : sRussel_Run_Backward,
	jumpsquat_Sprite : sRussel_Jumpsquat,
	jump_Sprite : sRussel_Jump,
	hurt_Sprite : sRussel_Hurt,
	grab_Sprite : sRussel_Grab,
	hold_Sprite : sRussel_Hold,
	launched_Sprite : sRussel_Launched,
	knockdown_Sprite : sRussel_KnockedDown,
	getup_Sprite : sRussel_Getup,
}

// Which Character we are currently playing as
selectedCharacter = global.stBeverlyMoves;

// State-related Variables
state = eState.IDLE;
prevState = 0;
inAttackState = false;
canTurnAround = true;

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
	image_yscale = 35;
}
hurtboxOffset = -9;

hitstun = 0;
hitstopBuffer = false;
prevSprite = 0;
blockstun = 0;
isCrouchBlocking = false;
blockbuffer = false;
xHome = x;
hitstunShuffleTimer = 0;
shuffle = 0;

isGrabbed = false;

invincible = false;

hitByGroup = ds_list_create();
ds_list_clear(hitByGroup);
// Note to self: any time the player exits the move they are currently doing, the hitByGroup list MUST be cleared!


toggleIdleBlock = false;
cancelable = false;
canBlock = false;

knockbackVel = 0;
pushbackVel = 0;

hp = 100;

frameAdvantage = false;
FAvictim = false;

heldOpponent = noone;

// Combo Related Variables
combo = 0;
comboCounterID = noone;
comboScaling = 0; // How much the next hit will be scaled
startCombo = false;
cancelCombo = false;

//Meter Related Variables
superMeter = 0; // the amount of meter the player has
meterBuildRate = 0.05; // The rate at which the player builds meter by approaching

// Palette Init
PaletteSetup(0, global.RusselPalettes);
