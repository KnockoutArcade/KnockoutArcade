/// @description Insert description here
// You can write your code in this editor

event_inherited();

activeRange = 200; // A player must be within this radius for this object to be active

idealRangeFromPlayer = 40; // How far away we'd like to be from the player
idealRangeVariation = 20; // The variation (+ or -) on the above variable
idealRangeChosenVariation = 0; // Once a variation is chosen, it is stored here so that the Ai will not recalculate the variation each frame

attackSubstate = 0; // For Gin, determines whether it should be walking towards the player or mashing an attack.
// 0 == walking to player
// 1 == attacking

// Initialize this object's target position to its spawn location.
targetPositionX = x;
targetPositionY = y;

tryTargetX = 0;
tryTargetY = 0;

setTargetPosition = function(tryX, tryY)
{
	// Set the coordinates that we are attempting to check
	targetPositionX = tryX;
	targetPositionY = tryY;
	//var collisionsToCheck = [oSlope, oWall, oSemiSolid];
	
	/*
	// If there is floor beneath the point we are trying to walk to, then this is a valid target position
	if (collision_point(tryTargetX, tryTargetY + 1, oWall, false, true) != noone || collision_point(tryTargetX, tryTargetY + 1, oSemiSolid, false, true) != noone)
	{
		targetPositionX = tryTargetX;
		targetPositionY = tryTargetY;
	}
	
	// Otherwise, the target position is not updated.
	*/
}