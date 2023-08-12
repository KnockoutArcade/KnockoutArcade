/// @description Insert description here
// You can write your code in this editor

//creates the foundFloor var
var foundFloor = false;
	
	//makes sure the Tub always spawns at the floor
	while (!place_meeting(x, floor(y)+1, oWall) && !foundFloor)
	{
		y += 1;	
	}

//pauses the bathtub on its 3rd fame
if (image_index >= 2.5 && !isBeingDestroyed) 
{
	
	image_speed = 0;
}

//once Gunther's timer hits 99, which will always be when he hits the ground, the bathtub will play the rest of its animation
if (owner.animTimer >= 99)
{
	isBeingDestroyed = true;
	image_speed =1;
}

//destroys the bathtub after its animation is finished
if (isBeingDestroyed && image_index >= 10.4)
{
	instance_destroy();	
}




