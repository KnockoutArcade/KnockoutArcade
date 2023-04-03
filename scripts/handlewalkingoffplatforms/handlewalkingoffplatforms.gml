// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function HandleWalkingOffPlatforms(maintainState)
{
	//Handle walking off of platforms by checking if ground is below us
	if (!place_meeting(x, y+1, oWall))
	{
		if (!maintainState)
		{
			state = eState.JUMPING;
			image_index = 2;
		}
		grounded = false;
		
		jumpHsp = hsp;
	}
}