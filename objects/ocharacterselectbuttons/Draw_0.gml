/// @description Insert description here
// You can write your code in this editor

// Draw joystick

// Neutral input
if (menuColMove == 0 && menuRowMove == 0)
{
	image_index = 0;
}
else if (menuColMove != 0 && menuRowMove == 0) // if we are moving left/right and NOT up/down
{
	// pressing left
	if (menuColMove == -1)
	{
		image_index = 3;
	}
	else // right
	{
		image_index = 7;
	}
}
else if (menuColMove == 0 && menuRowMove != 0) // Up and Down only
{
	// pressing up
	if (menuRowMove == 1)
	{
		image_index = 1;
	}
	else // down
	{
		image_index = 5;
	}
}
else if (menuColMove == menuRowMove && menuColMove != 0 && menuRowMove != 0) // if Up + right or Down + Left
{
	// Up + right
	if (menuColMove == 1)
	{
		image_index = 8;
	}
	else // down + left
	{
		image_index = 4;
	}
}
else if (menuColMove == -1 && menuRowMove == 1)
{
	// Up left
	image_index = 2;
}
else if (menuColMove == 1 && menuRowMove == -1)
{
	// down right
	image_index = 6;
}

draw_self();

// Draw Buttons
draw_sprite(sCharSel_Buttons, 0 + menuConfirmA, x + 20, y + 11);
