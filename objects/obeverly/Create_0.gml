/// @description Insert description here
// You can write your code in this editor

selectedCharacter = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Beverly")
	{
		selectedCharacter = global.characterData[i];
		break;
	}
}

event_inherited();


// TODO: Put these things in the character editor so we don't have to implement them like this
// Primary hurtbox data
hurtboxStandingWidth = 16;
hurtboxStandingHeight = 37;
hurtboxCrouchingWidth = 18;
hurtboxCrouchingHeight = 23;
hurtboxXOffsetStanding = -8;
hurtboxXOffsetCrouching = -9;
hurtboxXOffset = hurtboxXOffsetStanding;
hurtboxYOffset = 0;

// RUN ACCEL - PUT IN CHAR EDITOR
runSpeedAcceleration = 1.2; // How fast the character accelerates to their top speed

with (hurtbox) 
{
	primary = true;
	owner = other.id;
	image_xscale = other.hurtboxStandingWidth;
	image_yscale = other.hurtboxStandingHeight;
}