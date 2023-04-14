/// @description Insert description here
// You can write your code in this editor

selectedCharacter = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Beverly")
	{
		selectedCharacter = global.characterData[i];
	}
}

event_inherited();


