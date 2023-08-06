/// @description Insert description here
// You can write your code in this editor

if (colorTimer >= colorInterval)
{
	if (circle == 0)
	{
		var circleObj = instance_create_layer(x, y, "KO_Text", oSuperKOFirst);
		circleObj.depth = depth - drawDepthSubtract;
		circle = 1;
	}
	else
	{
		var circleObj = instance_create_layer(x, y, "KO_Text", oSuperKOOrange);
		circleObj.depth = depth - drawDepthSubtract;
	}
	colorTimer = 0;
	drawDepthSubtract++;
}
else
{
	colorTimer++;
}

if (lifetime < 1) 
{
	instance_destroy(oSuperKOFirst);
	instance_destroy(oSuperKOOrange);
	instance_destroy();
}

lifetime--;