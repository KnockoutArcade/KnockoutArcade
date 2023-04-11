/// @description Insert description here
// You can write your code in this editor

// We can get the data of a character by getting the data from an index of characterData. Since the index
// of each character may be different from build to build, I've set up this code that will iterate
// through each index to find the name of each index, with which we can use to access the correct
// character data
characterID = -1;
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Russel")
	{
		characterID = i;
	}
}

event_inherited();

// Which Character we are currently playing as
selectedCharacter = global.stRusselMoves;

