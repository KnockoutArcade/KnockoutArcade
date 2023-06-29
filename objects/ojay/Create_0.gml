/// @description Insert description here
// You can write your code in this editor

selectedCharacter = [];
//transferredCharacter = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Jay")
	{
		selectedCharacter = StructCopy(global.characterData[i]) // This is to make sure that each player has a seperate copy of their move data
		break;
	}
}

event_inherited();


