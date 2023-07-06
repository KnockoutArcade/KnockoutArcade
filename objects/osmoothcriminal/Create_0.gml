/// @description Insert description here
// You can write your code in this editor

// Spirit exclusive data
host = noone;
hostObject = noone;
nextToPlayer = true;
vulnerable = false;

selectedCharacter = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "SmoothCriminal")
	{
		selectedCharacter = global.characterData[i];
		break;
	}
}

event_inherited();

