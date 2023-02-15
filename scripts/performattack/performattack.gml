// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/*
		Dear future me,
		
		You're probably looking at the code below and thinking, "What the heck is going on here?" Don't
		worry, it's actually quite simple.
		
		You see, we needed a simple way to determine what frame of the animation needed to be shown
		at any time. The code below interates through every window to see what should be displayed,
		indicated by numOfWindows. It grabs this data from a global struct made when the game
		starts. If animTimer is greater than the value provided by that window's Length value,
		it sets the image_index to the value according to the image_index value of that window.
		
		window is a 2D matrix. The first value is the window's ID, the second value is the specific
		data partaining to that window. A value of 0 is the Length Value for that window, 1 is
		the image_index of that window.
			
		TLDR: I'm trying to future-proof this code when/if I add more characters.
*/

function PerformAttack(Action){
	var hitbox = 0;
	// Animations
	for (var i = 0; i < Action.numOfWindows; i++) {
			if animTimer >= Action.window[i][0] image_index = Action.window[i][1];
	}
	
	// Throws
	if Action.isThrow {
		for (var i = 0; i < Action.opponentPositionData.numOfWindows; i++) {
			//Key -   [frame, rel x, rel y, sprite, index, rotation, xscale]
			if animTimer >= Action.opponentPositionData.window[i][0] && heldOpponent != noone{
				heldOpponent.x = x + Action.opponentPositionData.window[i][1] * image_xscale;
				heldOpponent.y = y + Action.opponentPositionData.window[i][2];
				// Assigns the correct sprite to use. It will be different for every character, but we just want to use that character's hurt sprite
				if Action.opponentPositionData.window[i][3] == eSpritesToUse.HURT_SPRITE heldOpponent.sprite_index = heldOpponent.CharacterSprites.hurt_Sprite;
				if Action.opponentPositionData.window[i][3] ==eSpritesToUse.KNOCKDOWN_SPRITE heldOpponent.sprite_index = heldOpponent.CharacterSprites.knockdown_Sprite;
				heldOpponent.image_index = Action.opponentPositionData.window[i][4];
				heldOpponent.image_angle = Action.opponentPositionData.window[i][5] * image_xscale;
				heldOpponent.image_xscale = Action.opponentPositionData.window[i][6] * image_xscale;
			}
		}
	}
	
	
	// Momentum Data
	if Action.hasMovementData {
		var currentMovementWindow = 0; // The current window that we are using for momentum data
		for (var i = 0; i < Action.MovementData.numOfWindows; i++) {
			// We iterate through each window from left to right to determine which window should be active.
			// If animTimer is >= the current window's starting_frame, then it will become the active window.
			// If more than one window works, this code will allow the largest of the valid windows to be
			// the active window.
			if animTimer >= Action.MovementData.window[i][0] {
				currentMovementWindow = i;
			}
		}
		
		// If the overwrite flag is set to 1, then we overwrite the player's current momentum for the desired value
		// If not, the velocity gets added to our current velocity.
		if Action.MovementData.window[currentMovementWindow][3] = 1 {
			hsp = Action.MovementData.window[currentMovementWindow][1] * image_xscale; // hsp value 
			vsp = Action.MovementData.window[currentMovementWindow][2]; // vsp value
		} else {
			hsp += Action.MovementData.window[currentMovementWindow][1] * image_xscale;
			vsp += Action.MovementData.window[currentMovementWindow][2];
		}
	} else { // If the move does not have movementdata, then we simply set the hsp to 0
		if grounded && Action.isThrow == false {
			hsp = 0; // set hsp to 0 specifically on grounded moves so aerial moves still carry aerial moemntum.
		}
	}
	
	// Hitboxes
	for (var i = 0; i < Action.numOfHitboxes; i++;) {
		if animTimer == Action.attackProperty.start[i] {
			hitbox = instance_create_layer(x + (Action.attackProperty.widthOffset[i] * other.image_xscale) + 0.5, y - Action.attackProperty.heightOfset[i], "hitboxes", oHitbox);
			with hitbox {
				lifetime = Action.attackProperty.lifetime[i];
				hitboxID = i;
				image_xscale = Action.attackProperty.attackWidth[i] * other.image_xscale;
				image_yscale = Action.attackProperty.attackHeight[i];
				owner = other.id;
			
				// Pass through attack data
				attackProperty = Action.attackProperty;
			}
		}
	}
	
	
	// Re-hitting Hitboxes
	if variable_struct_exists(Action, "rehitData") {
		
		for (var i = 0; i < Action.rehitData.hitbox; i++;) {
			for (var j = 0; j < Action.rehitData.numOfHits; j++;) {
				if animTimer == Action.rehitData.frames[j] {
					hitbox = instance_create_layer(x + (Action.attackProperty.widthOffset[i] * other.image_xscale) + 0.5, y - Action.attackProperty.heightOfset[i], "hitboxes", oHitbox);
					with hitbox {
						lifetime = Action.attackProperty.lifetime[i];
						hitboxID = i;
						image_xscale = Action.attackProperty.attackWidth[i] * other.image_xscale;
						image_yscale = Action.attackProperty.attackHeight[i];
						owner = other.id;
			
						// Pass through attack data
						attackProperty = Action.attackProperty;
						
					}
					
					// Clears the hitBy data to allow attacks to connect properly
						ds_list_clear(hitByGroup);
						ds_list_clear(opponent.hitByGroup);
				}
			}
		}
	}
	
	// Hurtboxes
	hitbox = 0;
	for (var i = 0; i < Action.numOfHurtboxes; i++;) {
		if animTimer == Action.hurtboxProperty.start[i] {
			hitbox = instance_create_layer(x + (Action.hurtboxProperty.widthOffset[i] * other.image_xscale), y - Action.hurtboxProperty.heightOfset[i], "hitboxes", oPlayerHurtbox);
			with hitbox {
				lifetime = Action.hurtboxProperty.lifetime[i];
				hurtboxID = i;
				image_xscale = Action.hurtboxProperty.attackWidth[i] * other.image_xscale;
				image_yscale = Action.hurtboxProperty.attackHeight[i];
				owner = other.id;
				
				hurtboxProperty = Action.hurtboxProperty;
			}
		}
	}
	
}