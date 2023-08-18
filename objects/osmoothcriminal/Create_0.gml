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