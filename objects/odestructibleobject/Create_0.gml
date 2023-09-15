// Destructable objects act as obsticales that the player can collide with and destroy. They rely on the same
// system that players use for hit detection, which is why a lot of the variables here are shared.

hp = 50;

// Prevents crashes from ProcessHit
spiritObject = noone;
pendingToggle = false;

hsp = 0;
vsp = 0;

knockbackMultiplier = 0; // Multiplier for how much knockback this object takes.
launchable = false; // Whether this object can be launched or not
isDestructibleObject = true; // Identify this object as destructable
isThrowable = false; // whether we can throw this object around or not
knockbackDirection = 0; // Which way we should be taking knockback

hasWallCollision = true;
wallXScale = 4; // The wall object has an initial size of 16 px by 16px. These values are mulitplied by the scale values
wallYScale = 2;
wallCollisionBox = instance_create_layer(x, y, "Walls", oWall);
with (wallCollisionBox)
{
	image_xscale = other.wallXScale;
	image_yscale = -other.wallYScale;
}

sprite_index = sTrashBin;

hitstun = 0;
hitstop = 0;
inAttackState = false;

// Hurtbox Variables
hurtbox = instance_create_layer(x, y, "hitboxes", oPlayerHurtbox);
with (hurtbox) 
{
	primary = true;
	owner = other.id;
	image_xscale = 64;
	image_yscale = 32;
	x = other.x;
	x += hurtboxXOffset;
	y = other.y;
	y += hurtboxYOffset;
}
hurtboxOffset = 0;

// State
state = eState.IDLE;


#region // Variables that allow the Player to interact with this object
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
	
	grounded = true;
	fallSpeed = .25; // How fast a character falls

	// Combo Related Variables
	combo = 0;
	comboCounterID = noone;
	comboScaling = 0; // How much the next hit will be scaled
	startCombo = false;
	cancelCombo = true; // Combo Counter shouldn't show up on Destructable Objects
	
	//Meter Related Variables
	superMeter = 0; // the amount of meter the player has
	meterBuildRate = 0.05; // The rate at which the player builds meter by approaching
#endregion

CharacterSprites = {
	idle_Sprite : sprite_index,
	hurt_Sprite : sprite_index,
	grab_Sprite : sprite_index,
	hold_Sprite : sprite_index,
	launched_Sprite : sprite_index,
	knockdown_Sprite : sprite_index,
	getup_Sprite : sprite_index,
}
