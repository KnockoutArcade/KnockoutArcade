/// @description Insert description here
// You can write your code in this editor
owner = noone;

throwToCheck = 0;

distanceFromWall = 0;

image_yscale = 10;

startedTouchingWall = false;

mode = eThrowEnvironmentWallDetectionMode.CHECK_ONCE; // What method should this use to move the player (0 - only check once, 1 - Keep checking and keep moving the player out)

enum eThrowEnvironmentWallDetectionMode
{
	CHECK_ONCE,
	CONSTANT_CHECK
}