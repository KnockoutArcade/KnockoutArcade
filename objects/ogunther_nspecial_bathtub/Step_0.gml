/// @description Insert description here
// You can write your code in this editor
var foundFloor = false;

	while (!place_meeting(x, floor(y)+1, oWall) && !foundFloor)
	{
		y += 1;	
	}


if (image_index >= 2.5 && !isBeingDestoryed) 
{
	
	image_speed = 0;
}

if (owner.animTimer >= 99)
{
	isBeingDestoryed = true;
	image_speed =1;
}

if (isBeingDestoryed && image_index >= 10.4)
{
	instance_destroy();	
}




