// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// _speedToUse - Different states might have different speeds that they leave the ground on. Walking and running, for example, use 2 different speeds.

function HandleWalkingOffPlatforms(_speedToUse){
	//Handle walking off of platforms by checking if ground is below us
	if !(place_meeting(x, y+1, oWall))
	{
		state = eState.JUMPING;
		grounded = false;
		
		hsp = _speedToUse * movedir;
		jumpHsp = hsp;
		image_index = 2;
	}
}