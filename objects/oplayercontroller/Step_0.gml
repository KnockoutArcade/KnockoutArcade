/// @description Insert description here
// You can write your code in this editor

// Handle Player Intros
if (!hasPerformedIntro) 
{
	sprite_index = sRussel_Intro;
	state = eState.INTRO;
	if (image_index > (image_number - 1)) 
	{
		sprite_index = CharacterSprites.idle_Sprite;
		state = eState.IDLE;
		hasPerformedIntro = true;
	}
}

//Pause function, cancel event
if (global.game_paused)
{
	exit;
} 

if (!global.gameHalt)
{ 

// Handle Inputs
if (playerID == 1)
{
	//Movement Buttons
	var moveleft = global.p1ButtonLeft;
	var moveright = global.p1ButtonRight;
	movedir = moveleft + moveright;
	var jumpButton = global.p1ButtonUp;
	var crouchButton = global.p1ButtonDown;
	verticalMoveDir = jumpButton + crouchButton;
	
	var runButton = global.p1ButtonRun;

	// Attack Buttons
	var lightattack = global.p1ButtonLight;
	var mediumattack = 2 * global.p1ButtonMedium;
	var heavyattack = 3 * global.p1ButtonHeavy;
	var grab = 4 * global.p1ButtonGrab;
	var special = 5 * global.p1ButtonSpecial;
	var attack = max(lightattack, mediumattack, heavyattack, grab, special);

} 
else 
{
	var moveleft = global.p2ButtonLeft;
	var moveright = global.p2ButtonRight;
	movedir = moveleft + moveright;
	var jumpButton = global.p2ButtonUp;
	var crouchButton = global.p2ButtonDown;
	verticalMoveDir = jumpButton + crouchButton;

	var runButton = global.p2ButtonRun;

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
projectileInvincible = false;

// Initialize Hurtbox Values
hurtbox.image_xscale = 15;
hurtbox.image_yscale = 32;
hurtboxOffset = -8;

if (special)
{
	pressSpecialButtonTimer = 0;
}
else
{
	pressSpecialButtonTimer++;
}


// Handles running
if (runButton)
{
	if (!runButtonPressed)
	{
		holdRunButtonTimer = 0;
		runButtonPressed = true;
	}
	if (movedir == image_xscale || movedir == 0)
	{
		runningForward = true;
	}
	else if (movedir == -image_xscale)
	{
		runningBackward = true;
	}
	holdRunButtonTimer++;
}
else if (movedir == image_xscale) // If moving forward
{
	if (holdForwardTimer == 0)
	{
		startedMovingForward = true;
		
		// Player must press the button again wihin 15 frames to dash
		if (runForwardTimer < 15)
		{
			runningForward = true;
		}
	}
	holdForwardTimer++;
	holdBackwardTimer = 0;
}
else if (movedir == -image_xscale) // If moving backward
{
	if (holdBackwardTimer == 0)
	{
		startedMovingBackward = true;
		
		// Player must press the button again wihin 15 frames to dash
		if (runBackwardTimer < 15)
		{
			runningBackward = true;
		}
	}
	holdBackwardTimer++;
	holdForwardTimer = 0;
}
else if ((!runButton && movedir == 0))
{
	runningForward = false;
	runningBackward = false;
	holdForwardTimer = 0;
	holdBackwardTimer = 0;
	holdRunButtonTimer = 8; // Keep this variable outside of the Rush Cancel leniency window
	runButtonPressed = false;
}

// Handles timer for running forward
if (startedMovingForward)
{
	runForwardTimer = 0;
	startedMovingForward = false;
}
else
{
	runForwardTimer++;
}

// Handles timer for running backward
if (startedMovingBackward)
{
	runBackwardTimer = 0;
	startedMovingBackward = false;
}
else
{
	runBackwardTimer++;
}

// If the run button and special button are pressed within 4 frames of each other, activate rush cancel
// Also works with double tap forward, in which case the leniency is 7 frames
if ((((runButton || special) && pressSpecialButtonTimer <= 4 && holdRunButtonTimer <= 4) 
	|| (pressSpecialButtonTimer <= 7 && holdForwardTimer <= 7 && runningForward && !runButton))
	&& state != eState.BEING_GRABBED // Prevent Rush Cancels during any of these states...
	&& state != eState.THROW_TECH
	&& state != eState.HURT
	&& state != eState.LAUNCHED
	&& state != eState.KNOCKED_DOWN
	&& state != eState.GETUP
	&& state != eState.BLOCKING
	&& hitstun <= 0 && blockstun <= 0 && !FAvictim // and when the player gets hit...
	&& superMeter >= 50 // and if the player doesn't have enough meter...
	&& !rcActivated // and if the player already activated Rush Cancel and it hasn't completed yet.
	&& !rcBuffer)
{
	pressSpecialButtonTimer = 8;
	holdRunButtonTimer = 8;
	if (opponent != noone && opponent.activateFreeze)
	{
		// 1 frame buffer to determine if both players activated RC at the same time
		if (opponent.rcActivated && opponent.rcFreezeTimer > 1)
		{
			ActivateRushCancel();
		}
		else
		{
			rcBuffer = true;
			rcBufferTimer = 0;
			rcBufferInterval = 30;
		}
	}
	else if (heldOpponent != noone) // Activates buffer when grabbing
	{
		rcBuffer = true;
		rcBufferTimer = 0;
		rcBufferInterval = 999;
	}
	else
	{
		ActivateRushCancel();
	}
}
if (rcBufferTimer > rcBufferInterval)
{
	rcBuffer = false;
	rcBufferTimer = 0;
}
// Checks for either if the opponent activated screen freeze or if they are being grabbed
if (rcBuffer && rcBufferTimer <= rcBufferInterval && ((opponent != noone && !opponent.activateFreeze && rcBufferInterval == 30)
	|| (heldOpponent == noone && rcBufferInterval == 999)))
{
	rcBuffer = false;
	rcBufferTimer = 0;
	ActivateRushCancel();
}
if (rcBuffer)
{
	rcBufferTimer++;
}

// Handle storing input for Super Jump
if (superJumpTimer > 0) 
{
	superJumpTimer--;
} 
else
{
	storedSuperJump = false;
}

if (verticalMoveDir == -1)
{
	storedSuperJump = true;
	superJumpTimer = 6;
}
if (target != noone)
{
	framesSinceHitstun++;
}

// Handle detecting press vs hold up for double jump
if (verticalMoveDir == 1)
{
	heldUpFrames++; // If verticalMoveDir is 1 for multiple frames, then we know that we are holding the button
}
else
{
	heldUpFrames = 0;
}

// Calculate Traction
if (hitstun < 1 && blockstun < 1 && state != eState.HITSTOP && grounded && state != eState.JUMPSQUAT && state != eState.HOLD && state != eState.FORWARD_THROW && state != eState.BEING_GRABBED && state != eState.BACKWARD_THROW)
{
	if (abs(hsp) - traction >= 0)
	{
		hsp += traction * -sign(hsp);
	}
	else
	{
		hsp = 0;
	}
}

// Calculate Meter Gain
if (hasUsedMeter)
{
	meterScaling = 0.1;
}
else
{
	meterScaling = 1;
}

// Reset motion input values if the player isn't performing a special move
if (state != eState.NEUTRAL_SPECIAL && state != eState.SIDE_SPECIAL && state != eState.UP_SPECIAL && state != eState.DOWN_SPECIAL 
	&& state != eState.HITSTOP
	&& state != eState.ENHANCED_NEUTRAL_SPECIAL
	&& state != eState.ENHANCED_SIDE_SPECIAL
	&& state != eState.ENHANCED_UP_SPECIAL
	&& state != eState.ENHANCED_DOWN_SPECIAL
	&& state != eState.ENHANCED_NEUTRAL_SPECIAL_2
	&& state != eState.ENHANCED_SIDE_SPECIAL_2
	&& state != eState.ENHANCED_UP_SPECIAL_2
	&& state != eState.ENHANCED_DOWN_SPECIAL_2
	&& state != eState.REKKA_LAUNCHER
	&& state != eState.REKKA_FINISHER
	&& state != eState.REKKA_CONNECTER
	&& state != eState.REKKA_LOW
	&& state != eState.REKKA_HIGH) 
{
	inputSet = false;
	motionInput = [];
	ds_list_clear(listOfInputs);
	progressInInputs = [];
	enhanced = [];
	inputWindowStart = 0;
	inputWindowEnd = 0;
	changeFrame = 999;
	changeImmediately = false;
	requireSpecialButton = false;
}
else if (animTimer > inputWindowEnd)
{
	motionInput = [];
	ds_list_clear(listOfInputs);
	progressInInputs = [];
	inputWindowStart = 0;
	inputWindowEnd = 0;
	requireSpecialButton = false;
	
	var changeSet = false;
	for (i = 0; i < array_length(enhanced); i++)
	{
		if (enhanced[i])
		{
			changeSet = true;
		}
	}
	if (!changeSet)
	{
		changeFrame = 999;
		changeImmediately = false;
	}
}
else
{
	PerformMotionInputs(attack);
}

// IDLE and CROUCH are being handled outside of the state machine, as doing them inside would cause 1 frame delays between switching states.
if (state == eState.IDLE)
{
	animTimer = 0;
	cancelable = false;
	isShortHopping = false;
	isSuperJumping = false;
	hasSpentDoubleJump = false;
	canBlock = true;
	
	sprite_index = CharacterSprites.idle_Sprite;
	image_speed = 1;
	
	// Handle running and walking
	if (movedir == image_xscale && !runningForward) 
	{
		state = eState.WALKING;
	} 
	else if (movedir == -image_xscale)
	{
		state = eState.WALKING;
		canBlock = true;
	}
	
	if ((movedir == image_xscale || movedir == 0) && runningForward)
	{
		state = eState.RUN_FORWARD;
	}
	else if (movedir == -image_xscale && runningBackward && opponent != noone)
	{
		state = eState.RUN_BACKWARD;
		sprite_index = CharacterSprites.runBackward_Sprite;
		image_index = 0;
	}
	
	// Handle Jumping
	if (verticalMoveDir == 1)
	{
		state = eState.JUMPSQUAT;
		hsp = walkSpeed * movedir;
		jumpHsp = hsp;
		// Is the player jumping forward?
		if (movedir == image_xscale)
		{
			isJumpingForward = true;
		}
		else 
		{
			isJumpingForward = false;
		}
			
		// handle Super Jumping
		if (storedSuperJump)
		{
			isSuperJumping = true;
			storedSuperJump = false;
		}
	}
	else if (verticalMoveDir == -1)
	{
		state = eState.CROUCHING;
	}
	
	vsp += fallSpeed;
	
	frameAdvantage = false;
	
	isEXFlash = false;
	
	PressAttackButton(attack);
	
	HandleWalkingOffPlatforms(false);
}


if (state == eState.CROUCHING)
{
	animTimer = 0;
	cancelable = false;
	sprite_index = CharacterSprites.crouch_Sprite;
	image_speed = 1;
	frameAdvantage = false;
	isShortHopping = false;
	hasSpentDoubleJump = false;
	canBlock = true;
	
	hurtbox.image_xscale = 15;
	hurtbox.image_yscale = 27;
	
	if (movedir == 0 && verticalMoveDir != -1) 
	{
		state = eState.IDLE;
	}
	
	// Handle running and walking
	if (movedir != 0 && !runningForward && verticalMoveDir != -1) 
	{
		state = eState.WALKING;
	}
	
	if ((movedir == image_xscale || movedir == 0) && runningForward && verticalMoveDir != -1)
	{
		state = eState.RUN_FORWARD;
	}
	else if (movedir == -image_xscale && runningBackward && verticalMoveDir != -1 && opponent != noone)
	{
		state = eState.RUN_BACKWARD;
		sprite_index = CharacterSprites.runBackward_Sprite;
		image_index = 0;
	}
	
	vsp += fallSpeed;
	
	if (verticalMoveDir == 1) 
	{
		state = eState.JUMPSQUAT;
		hsp = walkSpeed * movedir;
		jumpHsp = hsp;
		// Is the player jumping forward?
		if (movedir == image_xscale)
		{
			isJumpingForward = true;
		}
		else 
		{
			isJumpingForward = false;
		}
			
		// handle Super Jumping
		if (storedSuperJump)
		{
			isSuperJumping = true;
			storedSuperJump = false;
		}
	}
	
	isEXFlash = false;
	
	PressAttackButton(attack);
	
	HandleWalkingOffPlatforms(false);
}

// Animation pauses during hitstop and when the screen freezes
if (hitstop == 0 && state != eState.SCREEN_FREEZE) 
{
	animTimer++;
}
else if (hitstop != 0)
{
	state = eState.HITSTOP;
}


if (state == eState.HITSTOP)
{
	hitstunShuffleTimer++;
	
	if (hitstun > 0)
	{
		if (!isGrabbed)
		{
			sprite_index = CharacterSprites.hurt_Sprite;
		}
		
		FAvictim = true;
		blockstun = 0;
		isEXFlash = false;
		
		if (hitstunShuffleTimer % 2 == 1)
		{
			shuffle++;
		}

		if (shuffle % 2 == 1)
		{
			x = xHome + min(hitstop, 3);
		}
		else 
		{
			x = xHome - min(hitstop, 3);
		}
	}
	else 
	{
		if (blockstun <= 0)
		{
			inAttackState = true;
		}
		
		// Canceling Moves from Hitstop
		if (!hitstopBuffer && blockstun <= 0 && attack != 0) 
		{
			// We need to know what attack state the player is in so we know which move's cancel data
			// we should to use.
			
			// We use the player's Previous State since the player's current state at this moment
			// in the code is HITSTOP. Previous State stores what state we were in before entering
			// hitstop.
      
			var attackState = FindAttackState(prevState);
			// Exception for invalid states
			if (attackState != -1)
			{
				CancelData(attackState, attack, false);
			}
		}
	}
	if (blockstun > 0)
	{
		if (isCrouchBlocking)
		{
			sprite_index = CharacterSprites.crouchBlock_Sprite;
		}
		else
		{
			sprite_index = CharacterSprites.standBlock_Sprite; // Set Crouching Anim
		}

		FAvictim = true;
		
		if (hitstunShuffleTimer % 2 == 1)
		{
			shuffle++
		}

		if (shuffle % 2 == 1)
		{
			x = xHome + min(hitstop, 1);
		}
		else
		{
			x = xHome - min(hitstop, 1);
		}
	}
	
	hitstop--;
	
	// When Hitstop Ends
	if (hitstop < 1) 
	{
		state = prevState;
		animTimer++;
		if (hitstopBuffer)
		{
			image_index = 0;
			cancelable = false;
			animOffset = 0;
			animTimer = animOffset;
			hitstopBuffer = false;
		}
		
		
		prevSprite = 0;
		shuffle = 0;
		framesSinceHitstun = 0;
		
		isGrabbed = false;
		image_angle = 0;
		
		if (hitstun > 0)
		{
			image_index = 0;
			x = xHome;
			hitstun++;
		}
		
		if (blockstun > 0)
		{
			blockstun++;
			x = xHome;
		}
	}
	image_speed = 0;
	
	
}

// Handle Being Grabbed
if (!isGrabbed)
{
	image_angle = 0;
}


// Handle freezing screen
if (state == eState.SCREEN_FREEZE)
{
	image_speed = 0;
	hsp = 0;
	environmentDisplacement = 0;
	vsp = 0;
	
	// If player is performing Rush Cancel
	if (rcActivated)
	{
		isEXFlash = true;
		// Screen freeze for Rush Cancel lasts for 30 frames
		if (rcFreezeTimer >= 30)
		{
			rcActivated = false;
			rcFreezeTimer = 0;
			activateFreeze = false;
			stateBeforeFreeze = 0;
			global.freezeTimer = false;
			animTimer = 0; // Reset the animation timer when entering Rush Cancel state
			speedTrailTimer = 0;
			comboScaling += 3.0;
			if (!grounded)
			{
				state = eState.RUSH_CANCEL_AIR;
			}
			else if (verticalMoveDir == 1)
			{
				vsp = -global.rcUpSpeed;
				jumpHsp = walkSpeed * 1.5 * image_xscale;
				state = eState.RUSH_CANCEL_UP;
				grounded = false;
			}
			else
			{
				rcForwardTimer = 0;
				state = eState.RUSH_CANCEL_FORWARD;
			}
		}
		else
		{
			rcFreezeTimer++;
		}
	}
	// If opponent froze the screen
	else if (opponent != noone && !opponent.activateFreeze && !activateFreeze)
	{
		hsp = freezeHSP;
		environmentDisplacement = freezeEnvironmentDisplacement;
		vsp = freezeVSP;
		state = stateBeforeFreeze;
		stateBeforeFreeze = 0;
	}
}

// Freezes the player if the opponent freezes the screen
if (opponent != noone && opponent.activateFreeze && state != eState.SCREEN_FREEZE)
{
	// Change some states when opponent activates screen freeze
	if (state == eState.BEING_GRABBED)
	{
		state = eState.LAUNCHED;
		vsp = -3; // Pops the player up a little
	}
	// Store all important variables before freezing
	stateBeforeFreeze = state;
	freezeHSP = hsp;
	freezeEnvironmentDisplacement = environmentDisplacement;
	freezeVSP = vsp;
	state = eState.SCREEN_FREEZE;
}

// State Machine
switch state 
{
	case eState.WALKING: 
	{
		animTimer = 0;
		cancelable = false;
		grounded = true;
		isShortHopping = false;
		isSuperJumping = false;
		hasSpentDoubleJump = false;
		canBlock = true;
		
		if (movedir == image_xscale) 
		{
			sprite_index = CharacterSprites.walkForward_Sprite;
			superMeter += meterBuildRate; // Walking forwards builds meter
		}
		else if (movedir == -image_xscale)
		{
			sprite_index = CharacterSprites.walkBackward_Sprite;
		}
		
		// Handle Transition to Run
		if ((movedir == image_xscale || movedir == 0) && runningForward)
		{
			state = eState.RUN_FORWARD;
		}
		else if (movedir == -image_xscale && runningBackward && opponent != noone) // Disable dashback if we aren't in a 1v1
		{
			state = eState.RUN_BACKWARD;
			sprite_index = CharacterSprites.runBackward_Sprite;
			image_index = 0;
		}
		
		image_speed = 1;
		
		hsp = walkSpeed * movedir;
		
		vsp += fallSpeed;

		if (movedir == 0) 
		{
			state = eState.IDLE;
		}
		
		// Handle Jumping And Crouching
		if (verticalMoveDir == 1)
		{
			state = eState.JUMPSQUAT;
			hsp = walkSpeed * movedir;
			jumpHsp = hsp;
			// Is the player jumping forward?
			isJumpingForward = (movedir == image_xscale);
			
			// handle Super Jumping
			if (storedSuperJump)
			{
				isSuperJumping = true;
				storedSuperJump = false;
			}
		} 
		else if (verticalMoveDir == -1)
		{
			state = eState.CROUCHING;
			hsp = 0;
		}
		
		// Hitstun
		if (hitstun > 0)
		{
			state = eState.HURT;
		}
		
		PressAttackButton(attack);
		
		HandleWalkingOffPlatforms(false);
	}
	break;
	
	
	case eState.RUN_FORWARD: 
	{
		animTimer = 0;
		cancelable = false;
		grounded = true;
		canTurnAround = false;
		isShortHopping = false;
		isSuperJumping = false;
		hasSpentDoubleJump = false;
		
		sprite_index = CharacterSprites.runForward_Sprite;
		superMeter += meterBuildRate * 1.5; // Running forwards builds more meter
		
		if (movedir == -image_xscale) // if we press back, then go back to walking state
		{
			state = eState.WALKING;
			sprite_index = CharacterSprites.walkBackward_Sprite;
			canBlock = true;
		}

		image_speed = 1;
		
		hsp = runSpeed * image_xscale;
		vsp += fallSpeed;

		if (!runningForward) 
		{
			state = eState.IDLE;
		}
		
		// Handle Jumping And Crouching
		if verticalMoveDir == 1 
		{
			state = eState.JUMPSQUAT;
			jumpHsp = hsp;
			// Is the player jumping forward?
			if (movedir != -image_xscale) 
			{
				isJumpingForward = true;
			}
			else 
			{
				isJumpingForward = false;
				hsp = walkSpeed * movedir;
				jumpHsp = hsp;
			}
			
			// handle Super Jumping
			if (storedSuperJump)
			{
				isSuperJumping = true;
				storedSuperJump = false;
			}
		} 
		else if (verticalMoveDir == -1)
		{
			state = eState.CROUCHING;
		}
		
		// Hitstun
		if (hitstun > 0)
		{
			state = eState.HURT;
		}
		
		PressAttackButton(attack);
		
		HandleWalkingOffPlatforms(false);
	}
	break;
	
	
	case eState.RUN_BACKWARD:
	{
		cancelable = false;
		grounded = true;
		canTurnAround = false;
		isShortHopping = false;
		isSuperJumping = false;
		hasSpentDoubleJump = false;
		
		vsp += fallSpeed;
		
		sprite_index = CharacterSprites.runBackward_Sprite;

		image_speed = 1;
		
		// Handle I-Frames
		invincible = (animTimer <= backdashInvincibility);
		
		// Handle Startup
		if (animTimer == backdashStartup)
		{
			hsp = backdashSpeed * -image_xscale;
		}
		
		// Handle Ending
		if (animTimer >= backdashDuration)
		{
			state = eState.IDLE;
			hsp = 0;
			invincible = false;
		}
		

		HandleWalkingOffPlatforms(false);
	}
	break;
	
	case eState.JUMPSQUAT: 
	{
		cancelable = false;
		sprite_index = CharacterSprites.jumpsquat_Sprite;
		image_speed = 1;
		grounded = true;
		isShortHopping = false;

		hsp = jumpHsp;
		
		PressAttackButton(attack);
		
		if (animTimer > 4)
		 {
			if (jumpAttackBuffer != 0)
			{
				state = jumpAttackBuffer;
			}
			else
			{
				state = eState.JUMPING;
			}
			grounded = false;
			jumpAttackBuffer = 0;
			animTimer = 0;
			
			if (canShortHop)
			{
				if (verticalMoveDir == 1) 
				{
					vsp = -jumpSpeed;
					isShortHopping = false;
					jumpHsp = hsp;
				}
				else 
				{
					vsp = -(jumpSpeed * 0.75);
					isShortHopping = true;
					jumpHsp = hsp;
				}
			}
			
			if (canSuperJump)
			{
				if (isSuperJumping)
				{
					vsp = -(jumpSpeed * 1.25);
					jumpHsp = hsp * 1.35;
				}
				else
				{
					vsp = -jumpSpeed;
					jumpHsp = hsp;
				}
			}
			
			if (!canSuperJump && !canShortHop)
			{
				vsp = -jumpSpeed;
				isShortHopping = false;
				isSuperJumping = false;
				jumpHsp = hsp;
			}
		}
	}
	break;
	
	
	case eState.JUMPING: 
	{
		animTimer = 0;
		cancelable = false;
		sprite_index = CharacterSprites.jump_Sprite;
		image_speed = 1;
		grounded = false;
		canTurnAround = false;
		
		if image_index > (image_number - 1) image_speed = 0;
		else image_speed = 1;
		
		if (isJumpingForward)
		{
			superMeter += meterBuildRate;
		}
		
		hsp = jumpHsp;
		if (!isShortHopping)
		{
			vsp += fallSpeed;
		}
		else 
		{
			vsp += fastFallSpeed;
		}
		
		if (canDoubleJump && !hasSpentDoubleJump)
		{
			if (verticalMoveDir == 1 && heldUpFrames <= 1)
			{
				vsp = -jumpSpeed;
				isShortHopping = false;
				isSuperJumping = false;
				
				hsp = walkSpeed * movedir;
				// Is the player jumping forward?
				isJumpingForward = (movedir == image_xscale);
				
				jumpHsp = hsp;
				hasSpentDoubleJump = true;
				image_index = 0;
			}
		}
		
		PressAttackButton(attack);
	}
	break;
	
	
	case eState.STANDING_LIGHT_ATTACK: 
	{
		GroundedAttackScript(selectedCharacter.StandLight, true, 1, 1, false, false);
		
		if (cancelable)
		{
			CancelData(selectedCharacter.StandLight, attack, true);
		}
	}
	break;
	
	case eState.STANDING_LIGHT_ATTACK_2: 
	{
		GroundedAttackScript(selectedCharacter.StandLight2, true, 1, 1, false, false);
		
		if (cancelable)
		{
			CancelData(selectedCharacter.StandLight2, attack, true);
		}
	}
	break;
	
	case eState.STANDING_LIGHT_ATTACK_3:
	{
		GroundedAttackScript(selectedCharacter.StandLight3, true, 1, 1, false, false);
		
		if (cancelable)
		{
			CancelData(selectedCharacter.StandLight3, attack, true);
		}
	}
	break;
	
	case eState.STANDING_MEDIUM_ATTACK:
	{
		GroundedAttackScript(selectedCharacter.StandMedium, true, 1, 1, false, false);
		
		// Cancelable into heavy
		if (cancelable)
		{
			CancelData(selectedCharacter.StandMedium, attack, true);
		}
	}
	break;
	
	case eState.STANDING_HEAVY_ATTACK:
	{
		GroundedAttackScript(selectedCharacter.StandHeavy, true, 1, 1, false, false);
		
		if (cancelable && hitstop < 1)
		{
			CancelData(selectedCharacter.StandHeavy, attack, true);
		}
	}
	break;
	
	
	case eState.CROUCHING_LIGHT_ATTACK: 
	{	
		CrouchingAttackScript(selectedCharacter.CrouchingLight, true, false);
		
		if (cancelable && hitstop < 1) 
		{
			CancelData(selectedCharacter.CrouchingLight, attack, true);
		}
	}
	break;
	
	case eState.CROUCHING_MEDIUM_ATTACK: 
	{
		CrouchingAttackScript(selectedCharacter.CrouchingMedium, true, false);
		
		if (cancelable && hitstop < 1)
		{
			CancelData(selectedCharacter.CrouchingMedium, attack, true);
		}
	}
	break;
	
	
	case eState.CROUCHING_HEAVY_ATTACK: 
	{
		CrouchingAttackScript(selectedCharacter.CrouchingHeavy, true, false);
		
		hurtboxOffset = -7;
		hurtbox.image_xscale = 18;
		hurtbox.image_yscale = 27;
		
		if (animTimer > 8)
		{
			hurtbox.image_yscale = 20;
		}
	
		if (cancelable && hitstop < 1)
		{
			CancelData(selectedCharacter.CrouchingHeavy, attack, true);
		}
	}
	break;
	
	
	case eState.JUMPING_LIGHT_ATTACK: 
	{
		JumpingAttackScript(selectedCharacter.JumpingLight, false, 1, 1);
		
		if (cancelable && hitstop < 1)
		{
			CancelData(selectedCharacter.JumpingLight, attack, true);
		} 
		
	}
	break;
	
	
	case eState.JUMPING_MEDIUM_ATTACK: 
	{
		JumpingAttackScript(selectedCharacter.JumpingMedium, false, 1, 1);
	
		if (cancelable && hitstop < 1)
		{
			CancelData(selectedCharacter.JumpingMedium, attack, true);
		}
	}
	break;
	
	
	case eState.JUMPING_HEAVY_ATTACK: 
	{
		JumpingAttackScript(selectedCharacter.JumpingHeavy, false, 1, 1);
		
		if (cancelable && hitstop < 1)
		{
			CancelData(selectedCharacter.JumpingHeavy, attack, true);
		}
	}
	break;

	
	case eState.COMMAND_NORMAL_1:
	{
		if (grounded)
		{	
			GroundedAttackScript(selectedCharacter.CommandNormal1, true, selectedCharacter.CommandNormal1.AirMovementData.GravityScale, selectedCharacter.CommandNormal1.AirMovementData.FallScale, true, true);
		} 
		else 
		{
			JumpingAttackScript(selectedCharacter.CommandNormal1, false, selectedCharacter.CommandNormal1.AirMovementData.GravityScale, selectedCharacter.CommandNormal1.AirMovementData.FallScale);
		}
		
		if (cancelable && hitstop < 1)
		{
			CancelData(selectedCharacter.CommandNormal1, attack, true);
		}
	}
	break;



	case eState.NEUTRAL_SPECIAL: 
	{
		if (grounded)
		{	
			GroundedAttackScript(selectedCharacter.NeutralSpecial, true, selectedCharacter.NeutralSpecial.AirMovementData.GravityScale, selectedCharacter.NeutralSpecial.AirMovementData.FallScale, true, true);
		} 
		else 
		{
			JumpingAttackScript(selectedCharacter.NeutralSpecial, false, selectedCharacter.NeutralSpecial.AirMovementData.GravityScale, selectedCharacter.NeutralSpecial.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.NeutralSpecial);
	}
	break;
	

	case eState.SIDE_SPECIAL: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.SideSpecial, true, selectedCharacter.SideSpecial.AirMovementData.GravityScale, selectedCharacter.SideSpecial.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.SideSpecial, false, selectedCharacter.SideSpecial.AirMovementData.GravityScale, selectedCharacter.SideSpecial.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.SideSpecial);
	}
	break;
	
	
	case eState.UP_SPECIAL: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.UpSpecial, true, selectedCharacter.UpSpecial.AirMovementData.GravityScale, selectedCharacter.UpSpecial.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.UpSpecial, false, selectedCharacter.UpSpecial.AirMovementData.GravityScale, selectedCharacter.UpSpecial.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.UpSpecial);
		
		if (animTimer < 28)
		{
			isThrowable = false;
		}
		else
		{
			isThrowable = true;
		}
	}
	break;
	
	
	case eState.DOWN_SPECIAL: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.DownSpecial, true, selectedCharacter.DownSpecial.AirMovementData.GravityScale, selectedCharacter.DownSpecial.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.DownSpecial, false, selectedCharacter.DownSpecial.AirMovementData.GravityScale, selectedCharacter.DownSpecial.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.DownSpecial);
	}
	break;
	
	
	case eState.ENHANCED_NEUTRAL_SPECIAL: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.EnhancedNeutralSpecial, true, selectedCharacter.EnhancedNeutralSpecial.AirMovementData.GravityScale, selectedCharacter.EnhancedNeutralSpecial.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.EnhancedNeutralSpecial, false, selectedCharacter.EnhancedNeutralSpecial.AirMovementData.GravityScale, selectedCharacter.EnhancedNeutralSpecial.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.EnhancedNeutralSpecial);
	}
	break;
	
	case eState.ENHANCED_SIDE_SPECIAL: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.EnhancedSideSpecial, true, selectedCharacter.EnhancedSideSpecial.AirMovementData.GravityScale, selectedCharacter.EnhancedSideSpecial.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.EnhancedSideSpecial, false, selectedCharacter.EnhancedSideSpecial.AirMovementData.GravityScale, selectedCharacter.EnhancedSideSpecial.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.EnhancedSideSpecial);
	}
	break;
	
	case eState.ENHANCED_UP_SPECIAL: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.EnhancedUpSpecial, true, selectedCharacter.EnhancedUpSpecial.AirMovementData.GravityScale, selectedCharacter.EnhancedUpSpecial.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.EnhancedUpSpecial, false, selectedCharacter.EnhancedUpSpecial.AirMovementData.GravityScale, selectedCharacter.EnhancedUpSpecial.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.EnhancedUpSpecial);
	}
	break;
	
	case eState.ENHANCED_DOWN_SPECIAL: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.EnhancedDownSpecial, true, selectedCharacter.EnhancedDownSpecial.AirMovementData.GravityScale, selectedCharacter.EnhancedDownSpecial.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.EnhancedDownSpecial, false, selectedCharacter.EnhancedDownSpecial.AirMovementData.GravityScale, selectedCharacter.EnhancedDownSpecial.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.EnhancedDownSpecial);
	}
	break;


	case eState.REKKA_LAUNCHER: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.RekkaLauncher, true, selectedCharacter.RekkaLauncher.AirMovementData.GravityScale, selectedCharacter.RekkaLauncher.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.RekkaLauncher, false, selectedCharacter.RekkaLauncher.AirMovementData.GravityScale, selectedCharacter.RekkaLauncher.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.RekkaLauncher);
	}
	break;
	
	case eState.REKKA_FINISHER: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.RekkaFinisher, true, selectedCharacter.RekkaFinisher.AirMovementData.GravityScale, selectedCharacter.RekkaFinisher.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.RekkaFinisher, false, selectedCharacter.RekkaFinisher.AirMovementData.GravityScale, selectedCharacter.RekkaFinisher.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.RekkaFinisher);
	}
	break;
	
	case eState.REKKA_CONNECTER: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.RekkaConnecter, true, selectedCharacter.RekkaConnecter.AirMovementData.GravityScale, selectedCharacter.RekkaConnecter.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.RekkaConnecter, false, selectedCharacter.RekkaConnecter.AirMovementData.GravityScale, selectedCharacter.RekkaConnecter.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.RekkaConnecter);
	}
	break;
	
	case eState.REKKA_LOW: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.RekkaLow, true, selectedCharacter.RekkaLow.AirMovementData.GravityScale, selectedCharacter.RekkaLow.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.RekkaLow, false, selectedCharacter.RekkaLow.AirMovementData.GravityScale, selectedCharacter.RekkaLow.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.RekkaLow);
	}
	break;
	
	case eState.REKKA_HIGH: 
	{
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.RekkaHigh, true, selectedCharacter.RekkaHigh.AirMovementData.GravityScale, selectedCharacter.RekkaHigh.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.RekkaHigh, false, selectedCharacter.RekkaHigh.AirMovementData.GravityScale, selectedCharacter.RekkaHigh.AirMovementData.FallScale);
		}
		
		ProcessEnhancers(selectedCharacter.RekkaHigh);
	}
	break;


	case eState.GRAB : 
	{
		grounded = true;
		inAttackState = true;
		
		sprite_index = CharacterSprites.grab_Sprite;
		
		hurtbox.image_xscale = 15;
		hurtbox.image_yscale = 25;
		hurtboxOffset = -7;
		
		PerformAttack(selectedCharacter.Grab);
		
		if (animTimer > 24)
		{
			state = eState.IDLE;
		}
	}
	break;
	
	case eState.HOLD : 
	{
		hsp = 0;
		grounded = true;
		inAttackState = true;
		
		
		sprite_index = CharacterSprites.hold_Sprite;
		
		// Transition to a throw
		if (animTimer > 4)
		{
			if (movedir != -image_xscale)
			{
				state = eState.FORWARD_THROW;
				animTimer = 0;
				
				if (target != noone)
				{
					ds_list_clear(target.hitByGroup);
				}
			
				// Handle moving the player away from the wall
				var ThrowDistance = instance_create_layer(x, y-15, "hitboxes", oThrowEnvDetection);
				with (ThrowDistance)
				{
					owner = other.id;
					image_xscale = other.selectedCharacter.ForwardThrow.OpponentPositionData.DistanceFromWall * other.image_xscale;
					throwToCheck = other.selectedCharacter.ForwardThrow;
				}
			} 
			else 
			{
				state = eState.BACKWARD_THROW;
				animTimer = 0;
				if (target != noone)
				{
					ds_list_clear(target.hitByGroup);
				}
			
				// Handle moving the player away from the wall
				var ThrowDistance = instance_create_layer(x, y-15, "hitboxes", oThrowEnvDetection);
				with (ThrowDistance) 
				{
					owner = other.id;
					image_xscale = other.selectedCharacter.BackwardThrow.OpponentPositionData.DistanceFromWall * other.image_xscale;
					throwToCheck = other.selectedCharacter.BackwardThrow;
				}
			}
		}
	}
	break;
	
	case eState.COMMAND_GRAB : 
	{
		inAttackState = true;
		
		sprite_index = CharacterSprites.grab_Sprite;
		
		hurtbox.image_xscale = 15;
		hurtbox.image_yscale = 25;
		hurtboxOffset = -7;
		
		if (grounded)
		{
			GroundedAttackScript(selectedCharacter.CommandGrab, true, selectedCharacter.CommandGrab.AirMovementData.GravityScale, selectedCharacter.CommandGrab.AirMovementData.FallScale, false, true);
		}
		else 
		{
			JumpingAttackScript(selectedCharacter.CommandGrab, false, selectedCharacter.CommandGrab.AirMovementData.GravityScale, selectedCharacter.CommandGrab.AirMovementData.FallScale);
		}
		
		ProccessCommandGrab();
	}
	break;
	
	case eState.BEING_GRABBED : 
	{
		animTimer = 0;
		hsp = 0;
		grounded = true;
		inAttackState = false;
		canTurnAround = false;
		
		isGrabbed = true;
	}
	break;
	
	case eState.FORWARD_THROW : 
	{
		grounded = true;
		inAttackState = true;
		
		sprite_index = selectedCharacter.ForwardThrow.SpriteId;
		image_index = 0;
		
		PerformAttack(selectedCharacter.ForwardThrow);
		
		// Set our hsp to 0 if we are on the first active frame of the move
		if (animTimer > selectedCharacter.ForwardThrow.AttackProperty[0].Start)
		{
			hsp = 0;
		}

		if (animTimer > 42)
		{
			state = eState.IDLE;
			frameAdvantage = true;
			sprite_index = CharacterSprites.idle_Sprite;
			x += selectedCharacter.ForwardThrow.OpponentPositionData.ThrowOffset * image_xscale;
		}
	}
	break;
	
	case eState.BACKWARD_THROW : 
	{
		grounded = true;
		inAttackState = true;
		
		sprite_index = selectedCharacter.BackwardThrow.SpriteId;
		image_index = 0;
		
		PerformAttack(selectedCharacter.BackwardThrow);
		
		// Set our hsp to 0 if we are on the first active frame of the move
		if (animTimer > selectedCharacter.BackwardThrow.AttackProperty[0].Start)
		{
			hsp = 0;
		}
		
		if (animTimer > 58)
		{
			state = eState.IDLE;
			frameAdvantage = true;
			canTurnAround = true;
			inAttackState = false;
			sprite_index = CharacterSprites.idle_Sprite;
			x += selectedCharacter.BackwardThrow.OpponentPositionData.ThrowOffset * image_xscale;
		}
	}
	break;
	
	case eState.THROW_TECH : 
	{
		grounded = true;
		inAttackState = false;
		
		sprite_index = CharacterSprites.grab_Sprite;
		image_index = 0;
		
		if (animTimer > 10)
		{
			state = eState.IDLE;
			hsp = 0;
		}
	}
	break;
	
	case eState.HURT : 
	{
		animTimer = 1;
		cancelable = false;
		canTurnAround = false;
		isEXFlash = false;
		
		if (!global.game_paused)
		{
			hitstun--;
		}
		
		if (hitstun < 1)
		{
			ds_list_clear(hitByGroup);
			FAvictim = false;
			
			if (grounded)
			{
				cancelCombo = true;
			}
			
			if (!grounded) 
			{
				state = eState.LAUNCHED;
			}
			else if (movedir == 0)
			{
				state = eState.IDLE;
			}
			else if (movedir != image_xscale)
			{
				state = eState.WALKING;
				canBlock = true;
			} 
			else 
			{
				state = eState.WALKING;
			}
		}
		
		if (grounded)
		{
			sprite_index = CharacterSprites.hurt_Sprite;
			
			// This code handles getting knocked back on the ground.
			if (knockbackVel > 0)
			{
				hsp = knockbackVel * -image_xscale;
				knockbackVel--;
			} 
			else if (knockbackVel < 0) 
			{
				hsp = knockbackVel * -image_xscale;
				knockbackVel++;
			}
			// Prevent player from ocillating if knockbackVel is a decimal.
			if (knockbackVel > -1 && knockbackVel < 1)
			{
				hsp = 0;
				knockbackVel = 0;
			}
		} 
		else 
		{
			sprite_index = CharacterSprites.launched_Sprite;
			if (image_index > (image_number - 1))
			{
				image_speed = 0;
			}
			else 
			{
				image_speed = 1;
			}
		}
		xHome = x;
		
		vsp += fallSpeed;

	}
	break;
	
	
	case eState.LAUNCHED : 
	{
		animTimer = 1;
		sprite_index = CharacterSprites.launched_Sprite;
			if (image_index > (image_number - 1))
			{
				image_speed = 0;
			}
			else 
			{
				image_speed = 1;
			}
		cancelable = false;
		canTurnAround = false;
		grounded = false;
		
		FAvictim = false;
		
		vsp += fallSpeed;
		if (!global.game_paused)
		{
			hitstun--;
		}

	}
	break;
	
	
	case eState.KNOCKED_DOWN : 
	{
		cancelable = false;
		grounded = true;
		invincible = true;
		canTurnAround = false;
		
		cancelCombo = true;
		
		if (image_index > (image_number - 1))
		{
			image_speed = 0;
		}
		else 
		{
			image_speed = 1;
		}
		
		if (!global.game_paused)
		{ 
			hitstun--;
		}
		
		if (animTimer > 39)
		{
			state = eState.GETUP;
			animTimer = 0;
			sprite_index = CharacterSprites.getup_Sprite;
			image_index = 0;
		}
	}
	break;
	
	
	case eState.GETUP : 
	{
		cancelable = false;
		grounded = true;
		invincible = true;
		canTurnAround = false;

		image_speed = (image_index > image_number - 1) ? 0 : 1;
		
		if (animTimer > 30)
		{
			// Turn the player arround immediately
			if (opponent != noone)
			{
				if (x < opponent.x)
				{
					image_xscale = 1;
				}
				else if (x != opponent.x)
				{
					image_xscale = -1;
				}
			}	
			
			state = eState.IDLE;
			invincible = false;
			
			if (movedir == -image_xscale || toggleIdleBlock) 
			{
				canBlock = true;
			}

			if (verticalMoveDir == 1) 
			{
				state = eState.JUMPSQUAT;
			}
			
			if (movedir == -image_xscale && runButton)
			{
				canBlock = false;
				state = eState.RUN_BACKWARD;
				sprite_index = CharacterSprites.runBackward_Sprite;
				image_index = 0;
				
				invincible = true;
				animTimer = 0;
			}
		}
		
	}
	break;
	
	
	case eState.BLOCKING : 
	{
		animTimer = 1;
		canBlock = true;
		cancelable = false;
		if (isCrouchBlocking)
		{
			sprite_index = CharacterSprites.crouchBlock_Sprite;
		}
		else 
		{
			sprite_index = CharacterSprites.standBlock_Sprite;
		}
		grounded = true;
		
		if (attack > 0)
		{
			blockbuffer = true;
		}
		/*
		if (playerID == 2)
		{
			prevState = eState.STANDING_LIGHT_ATTACK;
			blockbuffer = true;
		}
		*/
		// Buffer attack out of block
		switch attack 
		{
			case 1 : 
			{
				if (verticalMoveDir == -1)
				{
					prevState = eState.CROUCHING_LIGHT_ATTACK;
				}
				else 
				{
					prevState = eState.STANDING_LIGHT_ATTACK; 
				}
			}
			break;
			
			case 2 : 
			{
				if (verticalMoveDir == -1)
				{
					prevState = eState.CROUCHING_MEDIUM_ATTACK;
				}
				else 
				{
					prevState = eState.STANDING_MEDIUM_ATTACK;
				}
			}
			break;
			
			case 3 : 
			{
				if (verticalMoveDir == -1)
				{
					prevState = eState.CROUCHING_HEAVY_ATTACK;
				}
				else
				{
					prevState = eState.STANDING_HEAVY_ATTACK;
				}
			}
			break;
			
			case 5 : 
			{
				if (verticalMoveDir == 0 && movedir == 0)
				{
					prevState = eState.NEUTRAL_SPECIAL;
				}
				else if (movedir != 0 )
				{
					prevState = eState.SIDE_SPECIAL;
				}
				else if (verticalMoveDir == 1)
				{
					prevState = eState.UP_SPECIAL;
				}
				else if (verticalMoveDir == -1)
				{
					prevState = eState.DOWN_SPECIAL;
				}
			}
			break;
		}
		
		if (knockbackVel > 0)
		{
			hsp = knockbackVel * -image_xscale;
			knockbackVel--;
		} 
		else 
		{
			hsp = 0;
			knockbackVel = 0;
		}
		
		
		
		if (!global.game_paused)
		{
			blockstun--;
		}
		
		if (blockstun < 1) 
		{
			FAvictim = false;
			isCrouchBlocking = false;
			
			if (blockbuffer)
			{
				state = prevState;
				animTimer = 0;
			} 
			else 
			{
				if (movedir != 0)
				{
					state = eState.WALKING;
					if (verticalMoveDir == -1)
					{
						state = eState.CROUCHING;
					}
					if (movedir != image_xscale)
					{
						canBlock = true;
					}
				}
				else 
				{
					state = eState.IDLE;
				}
			}	
			
			hsp = 0;
			knockbackVel = 0;
			blockbuffer = false;
		}
		
		
		
	}
	break;
	
	case eState.RUSH_CANCEL_FORWARD:
	{
		animTimer = 0;
		cancelable = false;
		grounded = true;
		canTurnAround = false;
		isShortHopping = false;
		isSuperJumping = false;
		hasSpentDoubleJump = false;
		projectileInvincible = true;
		hasUsedMeter = true;
		
		sprite_index = CharacterSprites.runForward_Sprite;
		image_speed = 2;
		
		hsp = global.rcForwardSpeed * image_xscale;
		vsp += fallSpeed;
		
		// Handle Ending
		if (rcForwardTimer >= global.rcForwardDuration)
		{
			state = eState.IDLE;
		}
		rcForwardTimer++;
		
		// Hitstun
		if (hitstun > 0)
		{
			state = eState.HURT;
		}
		
		PressAttackButton(attack);

		HandleWalkingOffPlatforms(false);
		
		// Create speed trail
		SpeedTrail(0.3, 0.02, 3);
	}
	break;
	
	case eState.RUSH_CANCEL_UP:
	{
		animTimer = 0;
		cancelable = false;
		sprite_index = CharacterSprites.jump_Sprite;
		image_speed = 1;
		grounded = false;
		canTurnAround = false;
		projectileInvincible = true;
		hasUsedMeter = true;
		
		vsp += global.rcUpFallSpeed;
		hsp = walkSpeed * 1.5 * image_xscale;
		
		PressAttackButton(attack);
		
		// Create speed trail
		SpeedTrail(0.3, 0.02, 3);
	}
	break;
	
	case eState.RUSH_CANCEL_AIR:
	{
		animTimer = 0;
		cancelable = false;
		sprite_index = CharacterSprites.jump_Sprite;
		image_speed = 2;
		grounded = false;
		canTurnAround = false;
		projectileInvincible = true;
		hasUsedMeter = true;
		
		vsp = global.rcAirSpeed;
		hsp = global.rcAirHorizontalSpeed * image_xscale;
		
		PressAttackButton(attack);
		
		// Create speed trail
		SpeedTrail(0.3, 0.02, 1);
	}
	break;
}

// Code Outside State Machine



// If we are IN hitstop
if (hitstop > 0) 
{
	//state = eState.HITSTOP;
}
else 
{
	// If we are NOT in hitstop
	
	
	hitstopBuffer = false;
	if (state != eState.BLOCKING)
	{
		prevState = state;
	}
	xHome = x;
	if (hitstun < 1)
	{
		hitstunShuffleTimer = 0;
	}
	
	if (pushbackVel > 0)
	{
		hsp = pushbackVel * -image_xscale;
		pushbackVel--;
	}
}



if (hp < 0)
{
	hp = 0;
}
if (superMeter > 100)
{
	superMeter = 100;
}
if (superMeter < 0)
{
	superMeter = 0;
}


if (target != noone)
{
	// Combo Counter
	if (target.cancelCombo) 
	{
		startCombo = false;
		target.cancelCombo = false;
	
		if (combo > 1 && comboCounterID != noone)
		{
			comboCounterID.endCombo = true;
		}
	
		combo = 0;
		comboScaling = 0;
		meterScaling = 0;
		comboCounterID = noone;
		comboDamage = 0;
		hasUsedMeter = false;
	}

	if (startCombo)
	{
		if (playerID == 1)
		{
			comboCounterID = instance_create_layer(-20, 48, "ComboCounter", oComboCounter);
	
			with (comboCounterID) 
			{
				owner = other.id;
				screenSide = 1;
				ui_xOffset = -20;
				ui_yOffset = 48;
			}
		} 
		else 
		{
			comboCounterID = instance_create_layer(175, 48, "ComboCounter", oComboCounter);
			with (comboCounterID) 
			{
				owner = other.id;
				screenSide = -1;
				ui_xOffset = 175;
				ui_yOffset = 48;
			}
		}
		startCombo = false;
	}
}



// Collision
// When a player gets hit, they ossilate back and forth, which will move the player's collision box around.
// We're storing the actual x Position so we can restore it later.
// We need a consistent X position to do accurate collision calculations, so we'll use xHome, which is the
// player's position without ossilating.
var actualXPos = x;
x = xHome;

// Collisions With Players
if (opponent != noone)
{
	// Check to see if players are about to be touching
	if (place_meeting(x+hsp+environmentDisplacement, y, opponent) && state != eState.BEING_GRABBED && opponent.state != eState.BEING_GRABBED && ((grounded && opponent.grounded) || ((((opponent.state = eState.HURT || opponent.state = eState.BLOCKING) && !opponent.grounded) || opponent.state = eState.LAUNCHED) || (((state = eState.HURT || opponent.state = eState.BLOCKING) && !grounded) || state = eState.LAUNCHED))))
	{
		hsp *= .75; // Reduce player speed
		var origanalX = opponent.x; // Keep track of the opponent's x position before calculations
		// Simulate the opponent moving forwards
		opponent.x += (opponent.hsp*.75) + opponent.environmentDisplacement;
		// While the players are still touching
		while(place_meeting(x+hsp+environmentDisplacement, y , opponent))
		{
			// Move the players away from each other
			if x > opponent.x {
				environmentDisplacement += .5;
				opponent.x -= .5;
			}
			else 
			{
				environmentDisplacement -= .5;
				opponent.x += .5;
			}
		}
		opponent.environmentDisplacement = -environmentDisplacement; // give opponent their environment displacement
		opponent.x = origanalX; // Return oponent to original position
	}
}


// Collisions With Walls
if (place_meeting(x+hsp+environmentDisplacement, y, oWall) && state != eState.BEING_GRABBED)
{
	while (!place_meeting(x+sign(hsp+environmentDisplacement), y, oWall)) 
	{
		x += sign(hsp+environmentDisplacement);
	}
	hsp = 0;
	environmentDisplacement = 0;
}

if (place_meeting(x, y+vsp+fallSpeed, oWall) && state != eState.BEING_GRABBED)
{
	//Determine wether we are rising into a cieling or falling onto a floor.
	var fallDirection = sign(vsp);
	
	while (!place_meeting(x, y + sign(vsp+fallSpeed), oWall))
	{
		y += sign(vsp);
	}
	
	isJumpingForward = false;
	vsp = 0;
	if (hitstop < 1)
	{
		if (!grounded && state != eState.LAUNCHED && state != eState.HURT && state != eState.NEUTRAL_SPECIAL && state != eState.SIDE_SPECIAL && state != eState.DOWN_SPECIAL && state != eState.ENHANCED_NEUTRAL_SPECIAL && state != eState.ENHANCED_SIDE_SPECIAL && state != eState.ENHANCED_UP_SPECIAL && state != eState.ENHANCED_DOWN_SPECIAL && state != eState.COMMAND_GRAB && fallDirection == 1) 
		{
			state = eState.IDLE;
			grounded = true;
			frameAdvantage = true;
			inAttackState = false;
			canTurnAround = true;
			isThrowable = true;
		}
		if (state == eState.NEUTRAL_SPECIAL || state == eState.SIDE_SPECIAL || state == eState.DOWN_SPECIAL || state == eState.COMMAND_GRAB || state == eState.ENHANCED_NEUTRAL_SPECIAL || state == eState.ENHANCED_SIDE_SPECIAL || state == eState.ENHANCED_UP_SPECIAL || state == eState.ENHANCED_DOWN_SPECIAL) 
		{
			grounded = true;
			isThrowable = true;
		}
		if (state == eState.LAUNCHED)
		{
			state = eState.KNOCKED_DOWN;
			sprite_index = CharacterSprites.knockdown_Sprite;
			image_index = 0;
			hsp = 0;
			image_speed = 1;
		}
	}
}
x = actualXPos; // Restore the player's actual x position

if (state != eState.HITSTOP && state != eState.SCREEN_FREEZE)
{
	x += hsp + environmentDisplacement;
	x = clamp(x, global.camObj.x-80, global.camObj.x+80);
	y += vsp;
}

// Handle Enviornmental Displacement
environmentDisplacement = 0;

floor(y);



// Change the player's direction
if (!inAttackState && canTurnAround && !rcActivated)
{
	if (opponent != noone)
	{
		if (x < opponent.x)
		{
			image_xscale = 1;
		}
		else if (x != opponent.x)
		{
			image_xscale = -1;
		}
	}
	else if (hsp != 0)
	{
		image_xscale = sign(hsp);
	}
}
}
else 
{
	image_speed = 0;
	if hitstun > 0 sprite_index = CharacterSprites.hurt_Sprite; 
}