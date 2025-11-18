/// @description Insert description here
// You can write your code in this editor

// We can get the data of a character by getting the data from an index of characterData. Since the index
// of each character may be different from build to build, I've set up this code that will iterate
// through each index to find the name of each index, with which we can use to access the correct
// character data
selectedCharacter = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Luchador")
	{
		selectedCharacter = global.characterData[i];
		break;
	}
}

event_inherited();


// TODO: Put these things in the character editor so we don't have to implement them like this
// Primary hurtbox data
hurtboxStandingWidth = 21;
hurtboxStandingHeight = 34;
hurtboxCrouchingWidth = 23;
hurtboxCrouchingHeight = 23;
hurtboxXOffsetStanding = -10;
hurtboxXOffsetCrouching = -11;
hurtboxXOffset = hurtboxXOffsetStanding;
hurtboxYOffset = 0;

// RUN ACCEL - PUT IN CHAR EDITOR
runSpeedAcceleration = 1; // How fast the character accelerates to their top speed


with (hurtbox) 
{
	primary = true;
	owner = other.id;
	image_xscale = other.hurtboxStandingWidth;
	image_yscale = other.hurtboxStandingHeight;
}





