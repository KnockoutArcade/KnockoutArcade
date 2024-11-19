/// @description Insert description here
// You can write your code in this editor

selectedCharacter = [];
//transferredCharacter = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Jay")
	{
		selectedCharacter = StructCopy(global.characterData[i]); // This is to make sure that each player has a seperate copy of their move data
		break;
	}
}

event_inherited();


// TODO: Put these things in the character editor so we don't have to implement them like this
// Primary hurtbox data
hurtboxStandingWidth = 14;
hurtboxStandingHeight = 36;
hurtboxCrouchingWidth = 18;
hurtboxCrouchingHeight = 20;
hurtboxXOffsetStanding = -7;
hurtboxXOffsetCrouching = -9;
hurtboxXOffset = hurtboxXOffsetStanding;
hurtboxYOffset = 0;

with (hurtbox) 
{
	primary = true;
	owner = other.id;
	image_xscale = other.hurtboxStandingWidth;
	image_yscale = other.hurtboxStandingHeight;
}


SetupSpirit();

//currentMovesetID = selectedCharacter.UniqueData.SpiritOnMoveset;
//OverwriteMoveset();