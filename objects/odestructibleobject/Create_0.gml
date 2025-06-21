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
hasSpawnedCoins = false; // Ensure that a chest that opens only spawns its coins once

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
	isAbleToBlock = false;
	isCrouchBlocking = false;
	blockbuffer = false;
	xHome = x;
	yHome = y;
	hitstunShuffleTimer = 0;
	shuffle = 0;
	spiritON = false;

	isGrabbed = false;

	invincible = false;

	// This contains a list of all the objects we have hit recently
	objectsHitList = ds_list_create();

	// This is a struct which contains the IDs of every object that has recently hit us
	hasBeenHitByIds = {};

	// The most recent object to have hit us
	// This is mostly just used for the kickable object, since its owner changes depending
	// on who hit it last.
	mostRecentIDHitBy = noone;

	toggleIdleBlock = false;
	cancelable = false;
	canBlock = false;

	projectileInvincible = false;

	knockbackVel = 0;
	knockbackVelTimer = 0;
	knockbackVelDuration = 5; // How long to make knockback/pushback last for
	pushbackVel = 0;
	pushbackVelTimer = 0;
	pushbackVelDuration = 5;
	
	grounded = true;

	// Combo Related Variables
	combo = 0;
	comboCounterID = noone;
	comboScaling = 0; // How much the next hit will be scaled
	startCombo = false;
	cancelCombo = false; // Combo Counter shouldn't show up on Destructable Objects
	
	// Gravity Scaling
	gravityScaling = 0;
	
	//Meter Related Variables
	superMeter = 0; // the amount of meter the player has
	meterBuildRate = 0.05; // The rate at which the player builds meter by approaching
	meterPenalty = 0;
	
	// Singleplayer stats
	totalDamageTaken = 0;
	totalKOs = 0;
	
	// Teams
	teamID = 0; // Which team this player is on
	
	// Throw Protection
	throwProtectionTimer = 0; // How much throw protection this player currently has
	throwProtectionAmount = 0; // The amount of throw protection to give this player when applicable.

	// Cross-Up Protection
	crossupProtectionTimer = 0; // How long the player currently has crossup protection for.
	crossupProtectionAmount = 0; // How much crossup protection to give.
	crossupPreviousSide = 0; // Which side the opponent was previously on.
	
	// Wall bounce Variables
	wallBouncing = false;
	wallHit = false; // this is to dectect when the player hits the wall
	hasUsedWallBounce = false; // Has this player already been wallbounced in a combo?
	
	// Floor bounce Variables
	floorBouncing = false;
	floorHit = false; // This is to detect when a player hits the floor
	hasUsedFloorBounce = false; // Has this player already been floorbounced in a combo?
	
	environmentDisplacement = 0;

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

image_speed = animationSpeed; // Prevent sprite from animating until we tell it to

// Variables for destruction animation
blinkInterval = 3; // Every x frames, switch from visable to invisible
despawnTimer = 0; // Timer that handles the object disappearing
despawnLength = 30; // The amount of time it takes for the object to despawn