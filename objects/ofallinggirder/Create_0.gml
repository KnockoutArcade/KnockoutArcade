/// @description Insert description here
// You can write your code in this editor

vsp = 0;
fallSpeed = 0.25;

hasFallen = false; // Whether this object has already hit the ground

blinkInterval = 3; // Every x frames, switch from visable to invisible
despawnTimer = 0; // Timer that handles the object disappearing
despawnLength = 30; // The amount of time it takes for the object to despawn