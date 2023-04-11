/// @description Insert description here
// You can write your code in this editor


// Determines which player port this object is using (Player 1, Player 2, etc)
playerID = 1;

// Movment Variables
hsp = 0; // Horizontal speed
environmentDisplacement = 0;
vsp = 0; // Verticle speed
walkSpeed = global.characterData[characterID].WalkSpeed; // How fast the character walks in pixels/frame
runSpeed = global.characterData[characterID].RunSpeed; // How fast the character runs in pixels/frame
traction = global.characterData[characterID].Traction; // How much this character slows down each frame in pixels/frame
jumpSpeed = global.characterData[characterID].JumpSpeed; // How high a character jumps - Initial Jump velocity
fallSpeed = global.characterData[characterID].FallSpeed; // How fast a character falls

//Backdash Vars (The state is refered to as Run back for consistency)
backdashDuration = global.characterData[characterID].BackDashDuration; // The total duration of a character's backdash
backdashInvincibility = global.characterData[characterID].BackDashInvincibility; // How long the character is invincible for at the start of their backdash
backdashSpeed = global.characterData[characterID].BackDashSpeed; // How fast their backdash moves them back
backdashStartup = global.characterData[characterID].BackDashStartup; // The delay before the character starts moving back


// A short hop is when the player breifly taps up so they don't jump as high.

fastFallSpeed = global.characterData[characterID].FastFallSpeed; // How fast a character's short hop is if they have one
isShortHopping = false; // Whether or not a character is currently shorthopping
if (global.characterData[characterID].JumpType & 4 == 4)
{
	canShortHop = true; // Whether the player can shorthop or not
}
else
{
	canShortHop = false;
}

// A super jump is when the player presses Down just before jumping, allowing them to go higher.

if (global.characterData[characterID].JumpType & 2 == 2)
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

// A double jump is when the player jumps again in the air

if ((global.characterData[characterID].JumpType & 1) == 1)
{
	canDoubleJump = true; // Whether this character can Super Jump or not
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
	BLOCKING
}

enum eAttackType {
	HIGH, // Must be stand blocking
	MID, // Block high or low
	LOW, // Must Block Crouching
	GRAB, // Basic grab
	COMMAND_GRAB // Advanced type of grab with special properties
}

enum eSpritesToUse {
	HURT_SPRITE,
	GRAB_SPRITE,
	KNOCKDOWN_SPRITE,
}

CharacterSprites = {
	idle_Sprite : global.characterData[characterID].Sprites.Idle,
	crouch_Sprite : global.characterData[characterID].Sprites.Crouch,
	standBlock_Sprite : global.characterData[characterID].Sprites.StandBlock,
	crouchBlock_Sprite : global.characterData[characterID].Sprites.CrouchBlock,
	walkForward_Sprite : global.characterData[characterID].Sprites.WalkForward,
	walkBackward_Sprite : global.characterData[characterID].Sprites.WalkBackward,
	runForward_Sprite : global.characterData[characterID].Sprites.RunForward,
	runBackward_Sprite : global.characterData[characterID].Sprites.RunBackward,
	jumpsquat_Sprite : global.characterData[characterID].Sprites.JumpSquat,
	jump_Sprite : global.characterData[characterID].Sprites.Jump,
	hurt_Sprite : global.characterData[characterID].Sprites.Hurt,
	grab_Sprite : global.characterData[characterID].Sprites.Grab,
	hold_Sprite : global.characterData[characterID].Sprites.Hold,
	launched_Sprite : global.characterData[characterID].Sprites.Launched,
	knockdown_Sprite : global.characterData[characterID].Sprites.Knockdown,
	getup_Sprite : global.characterData[characterID].Sprites.GetUp,
}

// Which Character we are currently playing as
selectedCharacter = global.stRusselMoves;

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
	image_yscale = 32;
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
