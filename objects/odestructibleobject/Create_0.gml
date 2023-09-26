// Destructable objects act as obsticales that the player can collide with and destroy. They rely on the same
// system that players use for hit detection, which is why a lot of the variables here are shared.

hp = MaxHitPoints;

// Prevents crashes from ProcessHit
spiritObject = noone;
pendingToggle = false;

hsp = 0;
vsp = 0;

isDestructibleObject = true; // Identify this object as destructable
knockbackDirection = 0; // Which way we should be taking knockback

isOpened = false; // For chests, determine if they are open

// Wall Collision
if (hasWallCollision)
{
	if (collisionIsSemisolid)
	{
		wallCollisionBox = instance_create_layer(x, y, "Walls", oSemiSolid);
	}
	else
	{
		wallCollisionBox = instance_create_layer(x, y, "Walls", oWall);
	}

	with (wallCollisionBox)
	{
		image_xscale = other.wallXScale;
		image_yscale = other.wallYScale;
		y = other.y + (16 * -other.wallYScale);
	}
}

hitstun = 0;
hitstop = 0;
inAttackState = false;

// Hurtbox Variables
hurtbox = instance_create_layer(x, y, "hitboxes", oPlayerHurtbox);
with (hurtbox) 
{
	primary = true;
	owner = other.id;
	image_xscale = other.hurtboxXSize;
	image_yscale = other.hurtboxYSize;
}

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

image_speed = 0; // Prevent sprite from animating until we tell it to