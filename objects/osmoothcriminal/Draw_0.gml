/// @description Insert description here
// You can write your code in this editor

// Find the closest floor within 100 px of our y height
var foundFloor = false;
for (var i = 0; i < 100; i++;)
{
	if (place_meeting(x, floor(y)+i, oWall) && !foundFloor && !isGrabbed)
	{
		if (i < 25)
		{
			draw_sprite(sShadow, 0, x, floor(y)+i);
		}
		else if (i < 50)
		{
			draw_sprite(sSmallShadow, 0, x, floor(y)+i);
		}
		else
		{
			draw_sprite(sEvenSmallerShadow, 0, x, floor(y)+i);
		}
		foundFloor = true;
	}
}

if (isEXFlash)
{
	EXFlashTimer++;
	if (EXFlashTimer >= 2 && !displayEXFlash)
	{
		displayEXFlash = true; // Toggle flash
		EXFlashTimer = 0;
	}
	else if (EXFlashTimer >= 2 && displayEXFlash)
	{
		displayEXFlash = false; // Toggle flash
		EXFlashTimer = 0;
	}
}
else
{
	displayEXFlash = false; // Disable flash
	EXFlashTimer = 0;
}

draw_self();