/// @description Insert description here
// You can write your code in this editor

vsp += fallSpeed;

// Crash onto the ground
if (place_meeting(x, y + vsp, oWall))
{
	floor(y);
	
	while (!place_meeting(x, y, oWall))
	{
		y += 1;
	}
	
	fallSpeed = 0;
	image_index = 1;
	vsp = 0;
}

y += vsp;
