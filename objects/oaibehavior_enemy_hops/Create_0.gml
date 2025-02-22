/// @description Insert description here
// You can write your code in this editor

event_inherited();

activeRange = 200; // A player must be within this radius for this object to be active

idealRangeFromPlayer = 40; // How far away we'd like to be from the player
idealRangeVariation = 15; // The variation (+ or -) on the above variable
idealRangeChosenVariation = 0; // Once a variation is chosen, it is stored here so that the Ai will not recalculate the variation each frame

platformWalkoffThreshold = 20; // How close this enemy is allowed to be from the edge of a platform

bottomlessPitDetectionDistance = 45; // How far away from our current position to check for a bottomless pit

jumpForwardsChance = 10; // How likely (out of 15) this enemy is to jump forwards

playerDistanceThreshold = 60; // How far away we must be in order to always jump towards the player;

hasJustAttacked = false; // Whether this enemy has picked attacking as its most recent action

// These vars determine how long we should be in the walk state for
currentWalkDuration = 0;
walkDurationLowerBound = 15;
walkDurationUpperBound = 30;

// Initialize this object's target position to its spawn location.
targetPositionX = x;
targetPositionY = y;

setTargetPosition = function(tryX, tryY)
{
	// Set the coordinates that we are attempting to check
	targetPositionX = tryX;
	targetPositionY = tryY;
}