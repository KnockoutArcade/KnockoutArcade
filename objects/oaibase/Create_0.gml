/// @description Insert description here
// You can write your code in this editor

characterID = noone; // Who this AI is controlling
controllerID = noone; // The controller object to communicate with
opponent = noone; // Who this AI is targeting

targetPositionX = 0; // Coordinate to walk/move towards 
targetPositionY = 0; //
closeEnoughToTargetRange = 1; // How close this object can be to the actual target position to be considered "There." (Done to prevent the AI from wiggling back and forth)

activeRange = 200; // A player must be within this radius for this object to be active

idealRangeFromPlayer = 50; // How far away we'd like to be from the player
idealRangeVariation = 10; // The variation (+ or -) on the above variable
idealRangeChosenVariation = 0; // Once a variation is chosen, it is stored here so that the Ai will not recalculate the variation each frame

AIEventTimer = 0; // General purpose timer for different behaviors
randomDelayTimer = 100; // When the event timer reaches this number, do something. (Can be set randomly)

// States that describe what the AI is currently doing
enum eAIState {
	INACTIVE, // Will not move, attack, etc. until allowed to
	IDLE, // Standing still
	WALK, // Walk towards target position
	ATTACK, // General attack state
	HURT // Handle getting hurt/getting up
}

AIState = eAIState.IDLE; // The state that the AI is currently in