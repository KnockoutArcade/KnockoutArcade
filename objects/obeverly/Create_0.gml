/// @description Insert description here
// You can write your code in this editor

characterID = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Beverly")
	{
		characterID = i;
	}
}

event_inherited();

// Which Character we are currently playing as
selectedCharacter = global.stBeverlyMoves;

