/// @description Insert description here
// You can write your code in this editor

// We can get the data of a character by getting the data from an index of characterData. Since the index
// of each character may be different from build to build, I've set up this code that will iterate
// through each index to find the name of each index, with which we can use to access the correct
// character data
selectedCharacter = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Gunther")
	{
		selectedCharacter = global.characterData[i];
		break;
	}
}

event_inherited();


// TODO: Put these things in the character editor so we don't have to implement them like this
// Primary hurtbox data
hurtboxStandingWidth = 20;
hurtboxStandingHeight = 48;
hurtboxCrouchingWidth = 22;
hurtboxCrouchingHeight = 28;
hurtboxXOffsetStanding = -11;
hurtboxXOffsetCrouching = -11;
hurtboxXOffset = hurtboxXOffsetStanding;
hurtboxYOffset = 0;

with (hurtbox) 
{
	primary = true;
	owner = other.id;
	image_xscale = other.hurtboxStandingWidth;
	image_yscale = other.hurtboxStandingHeight;
}


