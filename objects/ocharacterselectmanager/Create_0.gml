/// @description Insert description here
// You can write your code in this editor

state = 0; // 0 for character select, 1 for stage select, 2 for music select

P1charSelRow = 0;
P1charSelCol = 0;
P1cursorCooldown = 5;
P2charSelRow = 0;
P2charSelCol = 2;
P2cursorCooldown = 5;

charSelRowMax = 1;
charSelColMax = 2;

P1mapSelRow = 0;
P1mapSelCol = 0;

mapSelRowMax = 1;
mapSelColMax = 3;

P1musicSelRow = 0;
musicSelRowMax = 5;


p1charSelFrameRate = 10;
p1charSelAnimTimer = 0;
p2charSelFrameRate = 10;
p2charSelAnimTimer = 0;

P1charSelCurrentFrame = 0;
P2charSelCurrentFrame = 0;

// Palettes to use for the selected character
p1LocalPalette = global.characterData[0];
p2LocalPalette = global.characterData[0];

RusselPaletteData = {};
BeverlyPaletteData = {};
JayPaletteData = {};

// Run through palette data to make it easier to reference later
for (var i = 0; i < global.numberOfCharacters; i++;)
{
	if (global.characterData[i].Name == "Russel")
	{
		RusselPaletteData = global.characterData[i];
	}
	else if (global.characterData[i].Name == "Beverly")
	{
		BeverlyPaletteData = global.characterData[i];
	}
	else if (global.characterData[i].Name == "Jay")
	{
		JayPaletteData = global.characterData[i];
	}
}



charSelBoxTimer = 0;
charSelBoxAlt = false;

mapSelBoxTimer = 0;
mapSelBoxAlt = false;

musicSelBoxTimer = 0;
musicSelBoxAlt = false;

P1hasSelectedChar = false;
P2hasSelectedChar = false;
P1hasSelectedAlt = false;
P2hasSelectedAlt = false;
P1hasSelectedMap = false;
P1hasSelectedMusic = false;

selectedMusic = 0; // Values correspond with sprite frame in sStageSelect_MusicNames_strip4

RTF_animTimer = 0;
RTF_frameRate = 30;
RTF_currentFrame = 0;