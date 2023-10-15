/// @description Insert description here
// You can write your code in this editor

characterID = noone; // Who this AI is controlling
controllerID = noone; // The controller object to communicate with
opponent = noone; // Who this AI is targeting

targetPositionX = 0; // Coordinate to walk/move towards 
targetPositionY = 0; //

activeRange = 200; // A player must be within this radius for this object to be active

AIEventTimer = 0; // General purpose timer for different behaviors

// States that describe what the AI is currently doing
enum eAIState {
	INACTIVE, // Will not move, attack, etc. until allowed to
	IDLE, // Standing still
	WALK, // Walk towards target position
	ATTACK, // General attack state
	HURT // Handle getting hurt/getting up
}

AIState = eAIState.IDLE; // The state that the AI is currently in