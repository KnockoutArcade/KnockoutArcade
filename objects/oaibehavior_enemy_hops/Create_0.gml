/// @description Insert description here
// You can write your code in this editor

event_inherited();

activeRange = 200; // A player must be within this radius for this object to be active

idealRangeFromPlayer = 40; // How far away we'd like to be from the player
idealRangeVariation = 15; // The variation (+ or -) on the above variable
idealRangeChosenVariation = 0; // Once a variation is chosen, it is stored here so that the Ai will not recalculate the variation each frame

platformWalkoffThreshold = 20; // How close this enemy is allowed to be from the edge of a platform

bottomlessPitDetectionDistance = 30; // How far away from our current position to check for a bottomless pit

jumpBackwardsChance = 3; // How likely (out of 15) this enemy is to walk backwards instead of forwards.

attackSubstate = 0; // For Hops, 
// 0 == walking to player
// 1 == attacking

hasJustAttacked = false; // Whether this enemy has picked attacking as its most recent action

// Initialize this object's target position to its spawn location.
targetPositionX = x;
targetPositionY = y;

// This is the starting positition for this enemy
homePositionX = x;
homePosiitonY = y;

setTargetPosition = function(tryX, tryY)
{
	// Set the coordinates that we are attempting to check
	targetPositionX = tryX;
	targetPositionY = tryY;
}