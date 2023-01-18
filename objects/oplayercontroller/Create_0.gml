/// @description Insert description here
// You can write your code in this editor

// Determines which player port this object is using (Player 1, Player 2, etc)
playerID = 1;

// Movment Variables
hsp = 0; // Horizontal speed
environmentDisplacement = 0;
vsp = 0; // Verticle speed
walkSpeed = 1.5; // How fast the character walks in pixels/frame
jumpSpeed = 4 // How high a character jumps - Initial Jump velocity
fallSpeed = .25; // How fast a character falls
fastFallSpeed = .35; // How fast a character's short hop is if they have one
isShortHopping = false; // Whether or not a character is currently shorthopping
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

enum eState {
	INTRO,
	IDLE,
	WALKING,
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
	GRAB,
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
	GRAB
}

enum eSpritesToUse {
	HURT_SPRITE,
	GRAB_SPRITE,
	KNOCKDOWN_SPRITE,
}

CharacterSprites = {
	hurt_Sprite : sRussel_Hurt,
	grab_Sprite : sRussel_Grab,
	knockdown_Sprite : sRussel_KnockedDown,
}

// State-related Variables
state = eState.IDLE;
prevState = 0;
inAttackState = false;
canTurnAround = true;

// Intro
hasPerformedIntro = true;

opponent = noone;

// Hurtbox Variables
hurtbox = instance_create_layer(x - 7, y, "hitboxes", oPlayerHurtbox);
with hurtbox {
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

combo = 0;
comboCounterID = noone;
startCombo = false;
cancelCombo = false;

// Palette Init
PaletteSetup(0, global.RusselPalettes);
