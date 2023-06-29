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

shader_set(sh_CharPalettes);

shader_set_uniform_f(sh_handle_range, 1);

// Set up color Matches
#region
shader_set_uniform_f(sh_handle_match1,
	colorMatch1.red,
	colorMatch1.green,
	colorMatch1.blue,
	
);
shader_set_uniform_f(sh_handle_match2,
	colorMatch2.red,
	colorMatch2.green,
	colorMatch2.blue,
	
);
shader_set_uniform_f(sh_handle_match3,
	colorMatch3.red,
	colorMatch3.green,
	colorMatch3.blue,
	
);
shader_set_uniform_f(sh_handle_match4,
	colorMatch4.red,
	colorMatch4.green,
	colorMatch4.blue,
	
);
shader_set_uniform_f(sh_handle_match5,
	colorMatch5.red,
	colorMatch5.green,
	colorMatch5.blue,
	
);
shader_set_uniform_f(sh_handle_match6,
	colorMatch6.red,
	colorMatch6.green,
	colorMatch6.blue,
	
);
shader_set_uniform_f(sh_handle_match7,
	colorMatch7.red,
	colorMatch7.green,
	colorMatch7.blue,
	
);
shader_set_uniform_f(sh_handle_match8,
	colorMatch8.red,
	colorMatch8.green,
	colorMatch8.blue,
	
);
shader_set_uniform_f(sh_handle_match9,
	colorMatch9.red,
	colorMatch9.green,
	colorMatch9.blue,
	
);
shader_set_uniform_f(sh_handle_match10,
	colorMatch10.red,
	colorMatch10.green,
	colorMatch10.blue,
	
);
shader_set_uniform_f(sh_handle_match11,
	colorMatch11.red,
	colorMatch11.green,
	colorMatch11.blue,
	
);
shader_set_uniform_f(sh_handle_match12,
	colorMatch12.red,
	colorMatch12.green,
	colorMatch12.blue,
	
);
shader_set_uniform_f(sh_handle_match13,
	colorMatch13.red,
	colorMatch13.green,
	colorMatch13.blue,
	
);
shader_set_uniform_f(sh_handle_match14,
	colorMatch14.red,
	colorMatch14.green,
	colorMatch14.blue,
	
);
shader_set_uniform_f(sh_handle_match15,
	colorMatch15.red,
	colorMatch15.green,
	colorMatch15.blue,
	
);
shader_set_uniform_f(sh_handle_match16,
	colorMatch16.red,
	colorMatch16.green,
	colorMatch16.blue,
	
);
shader_set_uniform_f(sh_handle_EXmatch,
	EXmatch.red,
	EXmatch.green,
	EXmatch.blue,
	
);

#endregion

// Set up color Replaces
#region
shader_set_uniform_f(sh_handle_replace1,
	colorReplace1.red,
	colorReplace1.green,
	colorReplace1.blue,
	
);
shader_set_uniform_f(sh_handle_replace2,
	colorReplace2.red,
	colorReplace2.green,
	colorReplace2.blue,
	
);
shader_set_uniform_f(sh_handle_replace3,
	colorReplace3.red,
	colorReplace3.green,
	colorReplace3.blue,
	
);
shader_set_uniform_f(sh_handle_replace4,
	colorReplace4.red,
	colorReplace4.green,
	colorReplace4.blue,
	
);
shader_set_uniform_f(sh_handle_replace5,
	colorReplace5.red,
	colorReplace5.green,
	colorReplace5.blue,
	
);
shader_set_uniform_f(sh_handle_replace6,
	colorReplace6.red,
	colorReplace6.green,
	colorReplace6.blue,
	
);
shader_set_uniform_f(sh_handle_replace7,
	colorReplace7.red,
	colorReplace7.green,
	colorReplace7.blue,
	
);
shader_set_uniform_f(sh_handle_replace8,
	colorReplace8.red,
	colorReplace8.green,
	colorReplace8.blue,
	
);
shader_set_uniform_f(sh_handle_replace9,
	colorReplace9.red,
	colorReplace9.green,
	colorReplace9.blue,
	
);
shader_set_uniform_f(sh_handle_replace10,
	colorReplace10.red,
	colorReplace10.green,
	colorReplace10.blue,
	
);
shader_set_uniform_f(sh_handle_replace11,
	colorReplace11.red,
	colorReplace11.green,
	colorReplace11.blue,
	
);
shader_set_uniform_f(sh_handle_replace12,
	colorReplace12.red,
	colorReplace12.green,
	colorReplace12.blue,
	
);
shader_set_uniform_f(sh_handle_replace13,
	colorReplace13.red,
	colorReplace13.green,
	colorReplace13.blue,
	
);
shader_set_uniform_f(sh_handle_replace14,
	colorReplace14.red,
	colorReplace14.green,
	colorReplace14.blue,
	
);
shader_set_uniform_f(sh_handle_replace15,
	colorReplace15.red,
	colorReplace15.green,
	colorReplace15.blue,
	
);
shader_set_uniform_f(sh_handle_replace16,
	colorReplace16.red,
	colorReplace16.green,
	colorReplace16.blue,
	
);

if (displayEXFlash)
{
	shader_set_uniform_f(sh_handle_EXreplace,
		1,
		1,
		0,
	
	);
}
else
{
	shader_set_uniform_f(sh_handle_EXreplace,
		0,
		0,
		0,
	
	);
}
#endregion

draw_self();

shader_reset();