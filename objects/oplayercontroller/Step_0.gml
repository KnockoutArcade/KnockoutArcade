/// @description Insert description here
// You can write your code in this editor

// Handle Player Intros
if hasPerformedIntro = false {
	sprite_index = sRussel_Intro;
	state = eState.INTRO;
	if image_index > (image_number - 1) {
		sprite_index = sRussel_Idle;
		state = eState.IDLE;
		hasPerformedIntro = true;
		}
}

//Pause function, cancel event
if (global.game_paused) exit;

if !global.gameHalt {

// Handle Inputs
if playerID = 1 {
	//Movement Buttons
	var moveleft = global.p1ButtonLeft;
	var moveright = global.p1ButtonRight;
	movedir = moveleft + moveright;
	var jumpButton = global.p1ButtonUp;
	var crouchButton = global.p1ButtonDown;
	verticalMoveDir = jumpButton + crouchButton;

	// Attack Buttons
	var lightattack = global.p1ButtonLight;
	var mediumattack = 2 * global.p1ButtonMedium;
	var heavyattack = 3 * global.p1ButtonHeavy;
	var grab = 4 * global.p1ButtonGrab;
	var special = 5 * global.p1ButtonSpecial;
	var attack = max(lightattack, mediumattack, heavyattack, grab, special);

} else {
	var moveleft = global.p2ButtonLeft;
	var moveright = global.p2ButtonRight;
	movedir = moveleft + moveright;
	var jumpButton = global.p2ButtonUp;
	var crouchButton = global.p2ButtonDown;
	verticalMoveDir = jumpButton + crouchButton;

	// Attack Buttons
	var lightattack = global.p2ButtonLight;
	var mediumattack = 2 * global.p2ButtonMedium;
	var heavyattack = 3 * global.p2ButtonHeavy;
	var grab = 4 * global.p2ButtonGrab;
	var special = 5 * global.p2ButtonSpecial;
	var attack = max(lightattack, mediumattack, heavyattack, grab, special);

}

canBlock = false;
inAttackState = false;
canTurnAround = true;


// Initialize Hurtbox Values
hurtbox.image_xscale = 15;
hurtbox.image_yscale = 32;
hurtboxOffset = -8;





// IDLE and CROUCH are being handled outside of the state machine, as doing them inside would cause 1 frame delays between switching states.
if state == eState.IDLE {
	animTimer = 0;
	cancelable = false;
	isShortHopping = false;
	//grounded = true;
	
	if toggleIdleBlock canBlock = true;
	sprite_index = CharacterSprites.idle_Sprite;
	image_speed = 1;
	
	if (movedir != 0) state = eState.WALKING;
	
	if verticalMoveDir == 1 {
		state = eState.JUMPSQUAT;
		hsp = walkSpeed * movedir;
		// Is the player jumping forward?
		if movedir = image_xscale isJumpingForward = true;
		else isJumpingForward = false;
	} else if verticalMoveDir == -1 {
		state = eState.CROUCHING;
	}
	
	frameAdvantage = false;
	
	PressAttackButton(attack);
}

if state == eState.CROUCHING {
	animTimer = 0;
	cancelable = false;
	sprite_index = CharacterSprites.crouch_Sprite;
	image_speed = 1;
	//grounded = true;
	frameAdvantage = false;
	isShortHopping = false;
		
	hsp = 0;
	
	hurtbox.image_xscale = 15;
	hurtbox.image_yscale = 27;

	if movedir == -image_xscale canBlock = true;
	else canBlock = false;
	
	if (movedir == 0 && verticalMoveDir != -1) state = eState.IDLE;
	if (movedir != 0 && verticalMoveDir != -1) state = eState.WALKING;
	if verticalMoveDir == 1 state = eState.JUMPSQUAT;
	
	PressAttackButton(attack);
}

// Animation
if (global.hitstop == 0) animTimer++;
else state = eState.HITSTOP;

if state == eState.HITSTOP {
		
		hitstunShuffleTimer++;
		
		if hitstun > 0 {
			if !isGrabbed sprite_index = CharacterSprites.hurt_Sprite;
			FAvictim = true;
			blockstun = 0;
			
			if hitstunShuffleTimer mod 2 = 1 shuffle++;
			if shuffle mod 2 = 1 x = xHome + min(global.hitstop, 3);
			else x = xHome - min(global.hitstop, 3);
		
		}
		else {
			if blockstun <= 0 inAttackState = true;
			if (!hitstopBuffer && blockstun <= 0) {
				if ((prevState == eState.STANDING_LIGHT_ATTACK) && attack != 0)
				{
					var cancels = [eState.STANDING_LIGHT_ATTACK_2, eState.STANDING_MEDIUM_ATTACK, eState.CROUCHING_MEDIUM_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
					CancelData(cancels, attack, false);
				} 
				else if prevState == eState.CROUCHING_LIGHT_ATTACK && attack != 0
				{
					var cancels = [eState.STANDING_MEDIUM_ATTACK, eState.CROUCHING_MEDIUM_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
					CancelData(cancels, attack, false);
				}
				else if (prevState == eState.STANDING_LIGHT_ATTACK_2 && attack != 0) 
				{
					var cancels = [eState.STANDING_LIGHT_ATTACK_3, eState.STANDING_MEDIUM_ATTACK, eState.CROUCHING_MEDIUM_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
					CancelData(cancels, attack, false);
				}
				else if ((prevState == eState.STANDING_MEDIUM_ATTACK || prevState == eState.CROUCHING_MEDIUM_ATTACK) && attack != 0)
				{
					var cancels = [ eState.STANDING_HEAVY_ATTACK, eState.CROUCHING_HEAVY_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
					CancelData(cancels, attack, false);
				}
				else if ((prevState == eState.STANDING_HEAVY_ATTACK || prevState == eState.CROUCHING_HEAVY_ATTACK) && attack != 0) 
				{
					var cancels = [eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
					CancelData(cancels, attack, false);
				} else if ((prevState == eState.JUMPING_LIGHT_ATTACK || prevState == eState.JUMPING_MEDIUM_ATTACK || prevState == eState.JUMPING_HEAVY_ATTACK) && attack != 0) 
				{
					var cancels = [eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
					CancelData(cancels, attack, false);
				}
			}
		}
		if blockstun > 0 {
			if isCrouchBlocking sprite_index = CharacterSprites.crouchBlock_Sprite;
			else sprite_index = CharacterSprites.standBlock_Sprite; // Set Crouching Anim
			FAvictim = true;
			
			if hitstunShuffleTimer mod 2 = 1 shuffle++;
			if shuffle mod 2 = 1 x = xHome + min(global.hitstop, 1);
			else x = xHome - min(global.hitstop, 1);
		}
		
		// When Hitstop Ends
		if (global.hitstop < 1) {
			state = prevState;
			if hitstopBuffer {
				//sprite_index = prevSprite;
				image_index = 0;
				cancelable = false;
				animTimer = animOffset;
				animOffset = 0;
			}
			hitstopBuffer = false;
			prevSprite = 0;
			shuffle = 0;
			
			isGrabbed = false;
			image_angle = 0;
			
			if hitstun > 0 {
				image_index = 0;
				hitstun++;
			}
			
			if blockstun > 0 blockstun++;
		}
		image_speed = 0;
	}


// Handle Being Grabbed
if !isGrabbed {
	image_angle = 0;
}

// Handle Enviornmental Displacement
environmentDisplacement = 0;

// State Machine
switch state {
	case eState.WALKING: {
		animTimer = 0;
		cancelable = false;
		grounded = true;
		isShortHopping = false;
		
		if (movedir = image_xscale) {
			sprite_index = CharacterSprites.walkForward_Sprite;
			superMeter += meterBuildRate; // Walking forwards builds meter
		}
		else {
			sprite_index = CharacterSprites.walkBackward_Sprite;
			canBlock = true;
		}
		image_speed = 1;
		
		hsp = walkSpeed * movedir;


		if (movedir == 0) state = eState.IDLE;
		
		// Handle Jumping And Crouching
		if verticalMoveDir == 1 {
			state = eState.JUMPSQUAT;
			hsp = walkSpeed * movedir;
			// Is the player jumping forward?
			if movedir = image_xscale isJumpingForward = true;
			else isJumpingForward = false;
		} else if verticalMoveDir == -1 {
			state = eState.CROUCHING;
		}
		
		// Hitstun
		if hitstun > 0 state = eState.HURT;
		
		PressAttackButton(attack);
	}
	break;
	
	
	case eState.JUMPSQUAT: {
		cancelable = false;
		sprite_index = CharacterSprites.jumpsquat_Sprite;
		image_speed = 1;
		grounded = true;
		isShortHopping = false;
		
		
		
		if animTimer > 4 {
			state = eState.JUMPING;
			grounded = false;
			if verticalMoveDir == 1 {
				vsp = -jumpSpeed;
				isShortHopping = false;
				jumpHsp = hsp;
			}
			else {
				vsp = -(jumpSpeed * 0.75);
				isShortHopping = true;
				jumpHsp = hsp;
			}
		}
		
	}
	break;
	
	
	case eState.JUMPING: {
		animTimer = 0;
		cancelable = false;
		sprite_index = CharacterSprites.jump_Sprite;
		image_speed = 1;
		grounded = false;
		canTurnAround = false;
		
		if isJumpingForward superMeter += meterBuildRate;
		
		hsp = jumpHsp;
		if !isShortHopping vsp += fallSpeed;
		else vsp += fastFallSpeed;
		
		PressAttackButton(attack);
	}
	break;
	
	
	case eState.STANDING_LIGHT_ATTACK: {
		hsp = 0;
		
		GroundedAttackScript(selectedCharacter.StandLight, true, 7, false, 0);
		
		var cancels = [eState.STANDING_LIGHT_ATTACK_2, eState.STANDING_MEDIUM_ATTACK, eState.CROUCHING_MEDIUM_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
	}
	break;
	
	case eState.STANDING_LIGHT_ATTACK_2: {
		hsp = 0;
		
		GroundedAttackScript(selectedCharacter.StandLight2, true, 14, false, 0);
		
		var cancels = [eState.STANDING_LIGHT_ATTACK_3, eState.STANDING_MEDIUM_ATTACK, eState.CROUCHING_MEDIUM_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
		
	}
	break;
	
	case eState.STANDING_LIGHT_ATTACK_3: {
		hsp = 0;
		
		GroundedAttackScript(selectedCharacter.StandLight3, true, 22, false, 0);
		
	}
	break;
	
	case eState.STANDING_MEDIUM_ATTACK: {
		//cancelable = false;
		if (animTimer == 3) hsp = 1 * image_xscale;
		else hsp = 0;

		GroundedAttackScript(selectedCharacter.StandMedium, true, 21, true, 23);
		
		// Cancelable into heavy
		var cancels = [eState.STANDING_HEAVY_ATTACK, eState.CROUCHING_HEAVY_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
	}
	break;
	
	case eState.STANDING_HEAVY_ATTACK: {
		//cancelable = false;
		
		if (animTimer == 12) hsp = 24 * image_xscale;
		else hsp = 0;

		GroundedAttackScript(selectedCharacter.StandHeavy, true, 39, false, 36);
		
		var cancels = [eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
	}
	break;
	
	
	case eState.CROUCHING_LIGHT_ATTACK: {
		hsp = 0;
		sprite_index = selectedCharacter.CrouchingLight.spriteID;
		grounded = true;
		image_index = 0;
		inAttackState = true;
		
		PerformAttack(selectedCharacter.CrouchingLight);
		
		if (animTimer > 9) {
			state = eState.CROUCHING;
			frameAdvantage = true;
		}
		
		var cancels = [eState.STANDING_MEDIUM_ATTACK, eState.CROUCHING_MEDIUM_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
	}
	break;
	
	case eState.CROUCHING_MEDIUM_ATTACK: {
		//cancelable = false;
		hsp = 0;
		grounded = true;
		inAttackState = true;
		
		sprite_index = selectedCharacter.CrouchingMedium.spriteID;
		image_index = 0;
		
		PerformAttack(selectedCharacter.CrouchingMedium);

		if (animTimer > 26) if (movedir != 0) state = eState.WALKING;
		
		if (animTimer > 27) {
			state = eState.CROUCHING;
			frameAdvantage = true;
		}
		
		var cancels = [eState.STANDING_HEAVY_ATTACK, eState.CROUCHING_HEAVY_ATTACK, eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
	}
	break;
	
	
	case eState.CROUCHING_HEAVY_ATTACK: {
		//cancelable = false;
		hsp = 0;
		grounded = true;
		inAttackState = true;
		
		sprite_index = selectedCharacter.CrouchingHeavy.spriteID;
		image_index = 0;
		
		PerformAttack(selectedCharacter.CrouchingHeavy);
		
		hurtboxOffset = -7;
		hurtbox.image_xscale = 18;
		hurtbox.image_yscale = 27;
		
		if animTimer > 8 {
			hurtbox.image_yscale = 20;
		}
		
		if (animTimer > 34) if (movedir != 0) state = eState.WALKING;
		
		if (animTimer > 34) {
			state = eState.CROUCHING;
			frameAdvantage = true;
		}
		
		var cancels = [eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
	}
	break;
	
	
	case eState.JUMPING_LIGHT_ATTACK: {
		//cancelable = false;
		grounded = false;
		inAttackState = true;
		
		if !isShortHopping vsp += fallSpeed;
		else vsp += fastFallSpeed;
		
		sprite_index = selectedCharacter.JumpingLight.spriteID;
		image_index = 0;
		
		PerformAttack(selectedCharacter.JumpingLight);
		
		var cancels = [eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
		
	}
	break;
	
	
	case eState.JUMPING_MEDIUM_ATTACK: {
		//cancelable = false;
		grounded = false;
		inAttackState = true;
		
		if !isShortHopping vsp += fallSpeed;
		else vsp += fastFallSpeed;
		
		sprite_index = selectedCharacter.JumpingMedium.spriteID;
		image_index = 0;
		
		PerformAttack(selectedCharacter.JumpingMedium);
		
		if (animTimer > 27) {
			state = eState.JUMPING;
			frameAdvantage = true;
		}
		
		var cancels = [eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
	}
	break;
	
	
	case eState.JUMPING_HEAVY_ATTACK: {
		//cancelable = false;
		grounded = false;
		inAttackState = true;
		
		if !isShortHopping vsp += fallSpeed;
		else vsp += fastFallSpeed;
		
		sprite_index = selectedCharacter.JumpingHeavy.spriteID;
		image_index = 0;
		
		PerformAttack(selectedCharacter.JumpingHeavy);
		
		if (animTimer > 27) {
			state = eState.JUMPING;
			frameAdvantage = true;
		}
		
		var cancels = [eState.NEUTRAL_SPECIAL, eState.SIDE_SPECIAL];
		if cancelable && global.hitstop < 1 CancelData(cancels, attack, true);
	}
	break;


	case eState.NEUTRAL_SPECIAL: {
		if grounded {
			hsp = 0;
			
			GroundedAttackScript(selectedCharacter.NeutralSpecial, true, 50, false, 45);
		} else {
			grounded = false;
			inAttackState = true;
			if animTimer == 1 vsp = -2;
			
			if vsp > 0 vsp += fallSpeed/2;
			else vsp += fallSpeed;
		
			sprite_index = selectedCharacter.NeutralSpecial.spriteID;
			image_index = 0;
		
			PerformAttack(selectedCharacter.NeutralSpecial);
		
			if (animTimer > 50) {
				state = eState.JUMPING;
				frameAdvantage = true;
			}
		}
	}
	break;
	

	case eState.SIDE_SPECIAL: {
		if grounded {
			grounded = false;
			if animTimer == 1 hsp = 0;
			if animTimer == 6 vsp = -1.5;	
			if animTimer >= 6 && animTimer < 32 hsp = 2.5*image_xscale;
			
			vsp += fallSpeed/2;
			
			if animTimer >= 32 {
				hsp -= (hsp != 0) ? 0.5 * image_xscale : 0;
			}
			GroundedAttackScript(selectedCharacter.SideSpecial, true, 44, false, 45);
		} else {
			grounded = false;
			inAttackState = true;
			if animTimer < 6 {
				vsp = 0;
				//hsp = 0;
			}
			if animTimer == 6 vsp = -1.5;	
			
			if animTimer >= 6 && animTimer < 32 hsp = 2.5*image_xscale;
			
			if animTimer >= 32 {
				hsp -= (abs(hsp) > 1) ? hsp * (0.5) : 0;
			}
			
			vsp += fallSpeed/2;
		
			sprite_index = selectedCharacter.SideSpecial.spriteID;
			image_index = 0;
		
			PerformAttack(selectedCharacter.SideSpecial);
		
			if (animTimer > 49) {
				state = eState.JUMPING;
				frameAdvantage = true;
			}
		}
	}
	break


	case eState.GRAB : {
		hsp = 0;
		grounded = true;
		inAttackState = true;
		
		sprite_index = CharacterSprites.grab_Sprite;
		
		hurtbox.image_xscale = 15;
		hurtbox.image_yscale = 25;
		hurtboxOffset = -7;
		
		PerformAttack(selectedCharacter.Grab);
		
		if animTimer > 24 state = eState.IDLE;
	}
	break;
	
	case eState.HOLD : {
		hsp = 0;
		grounded = true;
		inAttackState = true;
		
		
		sprite_index = CharacterSprites.hold_Sprite;
		
		// Transition to a throw
		if animTimer > 4 {
			if movedir != -image_xscale {
				state = eState.FORWARD_THROW;
				animTimer = 0;
				ds_list_clear(opponent.hitByGroup);
			
				// Handle moving the player away from the wall
				var ThrowDistance = instance_create_layer(x, y-15, "hitboxes", oThrowEnvDetection);
				with ThrowDistance {
					owner = other.id;
					image_xscale = other.selectedCharacter.ForwardThrow.opponentPositionData.distanceFromWall * other.image_xscale;
					throwToCheck = other.selectedCharacter.ForwardThrow;
				}
			} else {
				state = eState.BACKWARD_THROW;
				animTimer = 0;
				ds_list_clear(opponent.hitByGroup);
			
				// Handle moving the player away from the wall
				var ThrowDistance = instance_create_layer(x, y-15, "hitboxes", oThrowEnvDetection);
				with ThrowDistance {
					owner = other.id;
					image_xscale = other.selectedCharacter.BackwardThrow.opponentPositionData.distanceFromWall * other.image_xscale;
					throwToCheck = other.selectedCharacter.BackwardThrow;
				}
			}
		}
	}
	break;
	
	case eState.BEING_GRABBED : {
		animTimer = 0;
		hsp = 0;
		grounded = true;
		inAttackState = false;
		canTurnAround = false;
		
		isGrabbed = true;
	}
	break;
	
	case eState.FORWARD_THROW : {
		grounded = true;
		inAttackState = true;
		
		sprite_index = selectedCharacter.ForwardThrow.spriteID;
		image_index = 0;
		
		PerformAttack(selectedCharacter.ForwardThrow);
		
		// Set our hsp to 0 if we are on the first active frame of the move
		if animTimer > selectedCharacter.ForwardThrow.attackProperty.start[0] hsp = 0;
		
		if animTimer > 42 {
			state = eState.IDLE;
			frameAdvantage = true;
		}
	}
	break;
	
	case eState.BACKWARD_THROW : {
		grounded = true;
		inAttackState = true;
		
		sprite_index = selectedCharacter.BackwardThrow.spriteID;
		image_index = 0;
		
		PerformAttack(selectedCharacter.BackwardThrow);
		
		// Set our hsp to 0 if we are on the first active frame of the move
		if animTimer > selectedCharacter.BackwardThrow.attackProperty.start[0] hsp = 0;
		
		if animTimer > 58 {
			state = eState.IDLE;
			frameAdvantage = true;
			sprite_index = CharacterSprites.idle_Sprite;
			x -= 22 * image_xscale;
		}
	}
	break;
	
	case eState.THROW_TECH : {
		grounded = true;
		inAttackState = false;
		
		sprite_index = CharacterSprites.grab_Sprite;
		image_index = 0;
		
		if animTimer > 10 {
			state = eState.IDLE;
			hsp = 0;
		}
	}
	break;
	
	case eState.HURT : {
		animTimer = 1;
		//sprite_index = sRussel_Hurt;
		cancelable = false;
		canTurnAround = false;
		
		
		if !global.game_paused hitstun--;
		
		if hitstun < 1 {
			ds_list_clear(hitByGroup);
			FAvictim = false;
			
			if grounded == true cancelCombo = true;
			
			if grounded == false state = eState.LAUNCHED;
			else if movedir == 0 state = eState.IDLE;
			else if movedir != image_xscale {
				state = eState.WALKING;
				canBlock = true;
			} else state = eState.WALKING;
		}
		
		if grounded {
			sprite_index = CharacterSprites.hurt_Sprite;
			if knockbackVel > 0 {
				hsp = knockbackVel * -image_xscale;
				knockbackVel--;
			} else {
				hsp = 0;
				knockbackVel = 0;
			}
		} else {
			sprite_index = CharacterSprites.launched_Sprite;
			if image_index > (image_number - 1) image_speed = 0;
			else image_speed = 1;
		}
		xHome = x;
		
		vsp += fallSpeed;

	}
	break;
	
	
	case eState.LAUNCHED : {
		animTimer = 1;
		sprite_index = CharacterSprites.launched_Sprite;
			if image_index > (image_number - 1) image_speed = 0;
			else image_speed = 1;
		cancelable = false;
		canTurnAround = false;
		grounded = false;
		
		FAvictim = false;
		
		vsp += fallSpeed;
		if !global.game_paused hitstun--;

	}
	break;
	
	
	case eState.KNOCKED_DOWN : {
		cancelable = false;
		grounded = true;
		invincible = true;
		canTurnAround = false;
		
		cancelCombo = true;
		
		if image_index > (image_number - 1) image_speed = 0;
			else image_speed = 1;
		
		if !global.game_paused hitstun--;
		
		if animTimer > 39 {
			state = eState.GETUP;
			animTimer = 0;
			sprite_index = CharacterSprites.getup_Sprite;
			image_index = 0;
		}
	}
	break;
	
	
	case eState.GETUP : {
		cancelable = false;
		grounded = true;
		invincible = true;
		canTurnAround = false;
		
		if image_index > (image_number - 1) image_speed = 0;
			else image_speed = 1;
		
		if animTimer > 30 {
			state = eState.IDLE;
			invincible = false;
			if (movedir == -image_xscale) canBlock = true;
			if toggleIdleBlock canBlock = true;
			if (verticalMoveDir == 1) state = eState.JUMPSQUAT;
		}
		
	}
	break;
	
	
	case eState.BLOCKING : {
		animTimer = 1;
		canBlock = true;
		cancelable = false;
		if isCrouchBlocking sprite_index = CharacterSprites.crouchBlock_Sprite;
		else sprite_index = CharacterSprites.standBlock_Sprite;
		grounded = true;
		
		if attack > 0 blockbuffer = true;
		
		// Buffer attack out of block
		switch attack {
			case 1 : {
				if verticalMoveDir == -1 prevState = eState.CROUCHING_LIGHT_ATTACK;
				else prevState = eState.STANDING_LIGHT_ATTACK; 
			}
			break;
			case 2 : {
				if verticalMoveDir == -1 prevState = eState.CROUCHING_MEDIUM_ATTACK;
				else prevState = eState.STANDING_MEDIUM_ATTACK;
			}
			break;
			case 3 : {
				if verticalMoveDir == -1 prevState = eState.CROUCHING_HEAVY_ATTACK;
				else prevState = eState.STANDING_HEAVY_ATTACK;
			}
			break;
		}
		
		if knockbackVel > 0 {
			hsp = knockbackVel * -image_xscale;
			knockbackVel--;
		} else {
			hsp = 0;
			knockbackVel = 0;
		}
		
		
		
		if !global.game_paused blockstun--;
		
		if blockstun < 1 {
			FAvictim = false;
			isCrouchBlocking = false;
			
			if blockbuffer {
				state = prevState;
				animTimer = 0;
			} else {
				if movedir != 0 {
					state = eState.WALKING;
					if verticalMoveDir == -1 state = eState.CROUCHING;
					if movedir != image_xscale canBlock = true;
				} else state = eState.IDLE;
				
			}	
			
			hsp = 0;
			knockbackVel = 0;
			blockbuffer = false;
		}
		
		
		
	}
	break;
	
	
}

// Code Outside State Machine



// If we are IN hitstop
if (global.hitstop > 0) {
	//state = eState.HITSTOP;
}
else {
	// If we are NOT in hitstop
	
	
	hitstopBuffer = false;
	if state != eState.BLOCKING prevState = state;
	xHome = x;
	if hitstun < 1 {
		hitstunShuffleTimer = 0;
	}
	if pushbackVel >= 0 {
		hsp = pushbackVel * -image_xscale;
		pushbackVel--;
	}
}



if hp < 0 hp = 0;
if superMeter > 100 superMeter = 100;
if superMeter < 0 superMeter = 0;

// Combo Counter
if opponent.cancelCombo {
	startCombo = false;
	opponent.cancelCombo = false;
	
	if combo > 1 && comboCounterID != noone{
		comboCounterID.endCombo = true;
	}
	
	combo = 0;
	comboScaling = 0;
	comboCounterID = noone;
}

if startCombo {
	if playerID == 1 {
		comboCounterID = instance_create_layer(-20, 48, "ComboCounter", oComboCounter);
	
		with comboCounterID {
			owner = other.id;
			screenSide = 1;
			ui_xOffset = -20;
			ui_yOffset = 48;
		}
	} else {
		comboCounterID = instance_create_layer(175, 48, "ComboCounter", oComboCounter);
		with comboCounterID {
			owner = other.id;
			screenSide = -1;
			ui_xOffset = 175;
			ui_yOffset = 48;
		}
	}
	startCombo = false;
}




// Collision
if state != eState.HITSTOP {
	// Collisions With Players
	if place_meeting(x, y, opponent) && state != eState.BEING_GRABBED && hitstun < 1 && grounded && opponent.grounded{
	// If the opponent is not moving, reduce our speed by half. If the opponent is, stop us from moving
	// If the opponent is next to a wall, also don't move us
		if sign(opponent.hsp) == -sign(hsp) && sign(hsp) != 0 && sign(opponent.hsp) != 0{
			// If the opponent is moving towards us, and we are both moving.
			environmentDisplacement = -(walkSpeed) * image_xscale;
			opponent.environmentDisplacement = -(walkSpeed) * -image_xscale;
			
		} else {
			
			with opponent {
				// Wall Detection
				if place_meeting(x+(walkSpeed*-image_xscale), y, oWall) {
					environmentDisplacement = -(walkSpeed) * image_xscale;
					other.environmentDisplacement = -(walkSpeed) * -image_xscale;
				} else {
					if x < other.x {
						environmentDisplacement = -(walkSpeed/2);
						other.environmentDisplacement = (walkSpeed/2);
					} else {
						environmentDisplacement = (walkSpeed/2);
						other.environmentDisplacement = -(walkSpeed/2);
					}
				}
			}
		}
	}
	
	
	// Collisions With Walls
	if place_meeting(x+hsp+environmentDisplacement, y, oWall) && state != eState.BEING_GRABBED {
		while !place_meeting(x+sign(hsp+environmentDisplacement), y, oWall) x += sign(hsp+environmentDisplacement);
		//floor(x);
		hsp = 0;
		environmentDisplacement = 0;
	}
	
	if place_meeting(x, y+vsp+fallSpeed, oWall) {
		while !place_meeting(x, y + sign(vsp+fallSpeed), oWall) y += sign(vsp);
		
		isJumpingForward = false;
		jumpHsp = 0;
		vsp = 0;
		if !grounded && state != eState.LAUNCHED && state != eState.HURT && state != eState.NEUTRAL_SPECIAL{
			state = eState.IDLE;
			hsp = 0;
			grounded = true;
			frameAdvantage = true;
			inAttackState = false;
		}
		if state == eState.NEUTRAL_SPECIAL {
			grounded = true;
			hsp = 0;
		}
		if state == eState.LAUNCHED {
			state = eState.KNOCKED_DOWN;
			sprite_index = CharacterSprites.knockdown_Sprite;
			image_index = 0;
			hsp = 0;
			image_speed = 1;
		}
	}

x += hsp + environmentDisplacement;
x = clamp(x, global.camObj.x-80, global.camObj.x+80);
y += vsp;

floor(y);
// Change the player's direction
if !inAttackState && canTurnAround{
	if x < opponent.x image_xscale = 1;
	else if x != opponent.x image_xscale = -1;
	}
}
}
else {
	image_speed = 0;
	if hitstun > 0 sprite_index = CharacterSprites.hurt_Sprite; 
}