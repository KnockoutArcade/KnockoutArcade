/// @description Insert description here
// You can write your code in this editor

event_inherited();

activeRange = 200; // A player must be within this radius for this object to be active

idealRangeFromPlayer = 40; // How far away we'd like to be from the player
idealRangeVariation = 8; // The variation (+ or -) on the above variable
idealRangeChosenVariation = 0; // Once a variation is chosen, it is stored here so that the Ai will not recalculate the variation each frame

attackSubstate = 0; // For Gin, determines whether it should be walking towards the player or mashing an attack.
// 0 == walking to player
// 1 == attacking

