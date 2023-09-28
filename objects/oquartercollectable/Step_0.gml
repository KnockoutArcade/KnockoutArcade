/// @description Insert description here
// You can write your code in this editor

if (obeyGravity)
{
	vsp += fallSpeed;
	
	// Wall Collision
	if (place_meeting(x+hsp, y, oWall))
	{
		while (!place_meeting(x + sign(hsp), y, oWall))
		{
			x += sign(hsp);
		}
		
		hsp = -hsp;
	}
	
	if (place_meeting(x, y+vsp, oWall))
	{
		while (!place_meeting(x, y + sign(vsp), oWall))
		{
			y += sign(vsp);
		}
		
		// If our downwards velocity is low enough, bounce off the ground
		if (vsp > 1)
		{
			vsp = -vsp * .5;
		}
		else
		{
			vsp = 0;
			
			// Apply traction
			if (abs(hsp) - traction >= 0)
			{
				hsp += traction * -sign(hsp);
			}
			else
			{
				hsp = 0;
			}
		}
	}
}

y += vsp;
x += hsp;

