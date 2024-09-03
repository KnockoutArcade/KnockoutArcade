/// @description Insert description here
// You can write your code in this editor

// Spirit exclusive data
nextToPlayer = true;
vulnerable = false;
hurtboxSet = false;
attack = 0; // Matches Jay's attack
creatingHitbox = false;

// Variables for when spirit is summoned in Spirit OFF
inSpiritOff = false;
startingMove = 0;

// Active state vars
spiritOffsetDistance = 15; // How far away the spirit should be from the host laterally
shouldCreateSpiritFire = false; // Whether we should create a spiritFire

// Attack state vars
moveToPerform = 0; // The attack that needs to be done.

selectedCharacter = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "SmoothCriminal")
	{
		selectedCharacter = StructCopy(global.characterData[i]) // This is to make sure that each player has a seperate copy of their move data
		break;
	}
}

event_inherited();

// Spirit exclusive State Variables
// Spirits operate in a unique way from characters. They have unique higher level functionality.
spiritState = eSpiritState.DEACTIVATED;
enum eSpiritState {
	DEACTIVATED,
	ACTIVE,
	ATTACK,
	HITSTOP,
	SCREEN_FREEZE,
	HURT,
	LAUNCHED,
	ON_THE_GROUND
}

createSpiritFire = function CreateSpiritFire() 
{
	var spiritFire = instance_create_layer(x, y, "Instances", oSpiritFire);
	spiritFire.depth = depth + 1;
}