/// @description Insert description here
// You can write your code in this editor

// A number of things will function similarly to a regular character, but 
// a lot will be cut out since this isn't its own character
if (host != noone && hostObject != noone)
{
	if (!hurtboxSet)
	{
		var hostID = hostObject.id;
		with(hurtbox)
		{
			owner = hostID;
			calledBySpirit = true;
			spirit = other.id;
		}
		hurtboxSet = true;
	}

	depth = hostObject.depth + 2;

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

		}

		canBlock = false;
		inAttackState = false;
		canTurnAround = true;
		projectileInvincible = false;

		// Initialize Hurtbox Values
		hurtbox.image_xscale = 15;
		hurtbox.image_yscale = 32;
		hurtboxOffset = -8;

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
		
		// If the spirit is close to its host, set nextToPlayer to true
		if (abs(x - hostObject.x) < 10)
		{
			nextToPlayer = true;
		}

		// IDLE and CROUCH are being handled outside of the state machine, as doing them inside would cause 1 frame delays between switching states.
		if (state == eState.IDLE)
		{
			// Immediately removes the spirit after the move is over in Spirit OFF
			if (!hostObject.spiritState)
			{
				hostObject.spiritObject = noone;
				hostObject.spiritSummoned = false;
				with(hostObject.hurtbox)
				{
					spiritOwner = noone;
				}
				instance_create_layer(x, y, "Instances", oSpiritFire);
				instance_destroy(hurtbox);
				instance_destroy();
			}

			// Stands next to and slightly in front of the player
			if (nextToPlayer)
			{
				x = lerp(x, hostObject.x + (10 * hostObject.image_xscale), 0.2);
			}

			animTimer = 0;
			cancelable = false;
			isShortHopping = false;
			isSuperJumping = false;
			hasSpentDoubleJump = false;
			canBlock = true;
			vulnerable = false;

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

			HandleWalkingOffPlatforms(false);
		}


		if (state == eState.CROUCHING)
		{
			// Immediately removes the spirit after the move is over in Spirit OFF
			if (!hostObject.spiritState)
			{
				hostObject.spiritObject = noone;
				hostObject.spiritSummoned = false;
				with(hostObject.hurtbox)
				{
					spiritOwner = noone;
				}
				instance_create_layer(x, y, "Instances", oSpiritFire);
				instance_destroy(hurtbox);
				instance_destroy();
			}

			// Stands next to and slightly in front of the player
			if (nextToPlayer)
			{
				x = lerp(x, hostObject.x + (10 * hostObject.image_xscale), 0.2);
			}

			animTimer = 0;
			cancelable = false;
			sprite_index = CharacterSprites.crouch_Sprite;
			image_speed = 1;
			frameAdvantage = false;
			isShortHopping = false;
			hasSpentDoubleJump = false;
			canBlock = true;
			vulnerable = false;

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
					hostObject.comboScaling += 3.0;
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
			else if (opponent != noone && !opponent.activateFreeze && !hostObject.activateFreeze && !activateFreeze)
			{
				hsp = freezeHSP;
				environmentDisplacement = freezeEnvironmentDisplacement;
				vsp = freezeVSP;
				state = stateBeforeFreeze;
				stateBeforeFreeze = 0;
			}
		}

		// Freezes the player if the opponent freezes the screen
		if (((opponent != noone && opponent.activateFreeze) || hostObject.activateFreeze) && state != eState.SCREEN_FREEZE)
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
			// Immediately removes the spirit after the move is over in Spirit OFF
			if (!hostObject.spiritState)
			{
				hostObject.spiritObject = noone;
				hostObject.spiritSummoned = false;
				with(hostObject.hurtbox)
				{
					spiritOwner = noone;
				}
				instance_create_layer(x, y, "Instances", oSpiritFire);
				instance_destroy(hurtbox);
				instance_destroy();
			}

			// Stands next to and slightly in front of the player
			if (nextToPlayer)
			{
				x = lerp(x, hostObject.x + (10 * hostObject.image_xscale), 0.2);
			}

			animTimer = 0;
			cancelable = false;
			grounded = true;
			isShortHopping = false;
			isSuperJumping = false;
			hasSpentDoubleJump = false;
			canBlock = true;
			vulnerable = false;

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

			HandleWalkingOffPlatforms(false);
		}
		break;


		case eState.RUN_FORWARD:
		{
			// Immediately removes the spirit after the move is over in Spirit OFF
			if (!hostObject.spiritState)
			{
				hostObject.spiritObject = noone;
				hostObject.spiritSummoned = false;
				with(hostObject.hurtbox)
				{
					spiritOwner = noone;
				}
				instance_create_layer(x, y, "Instances", oSpiritFire);
				instance_destroy(hurtbox);
				instance_destroy();
			}

			// Stands next to and slightly in front of the player
			if (nextToPlayer)
			{
				x = lerp(x, hostObject.x + (10 * hostObject.image_xscale), 0.2);
			}

			animTimer = 0;
			cancelable = false;
			grounded = true;
			canTurnAround = false;
			isShortHopping = false;
			isSuperJumping = false;
			hasSpentDoubleJump = false;
			vulnerable = false;

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

			HandleWalkingOffPlatforms(false);
		}
		break;


		case eState.RUN_BACKWARD:
		{
			// Immediately removes the spirit after the move is over in Spirit OFF
			if (!hostObject.spiritState)
			{
				hostObject.spiritObject = noone;
				hostObject.spiritSummoned = false;
				with(hostObject.hurtbox)
				{
					spiritOwner = noone;
				}
				instance_create_layer(x, y, "Instances", oSpiritFire);
				instance_destroy(hurtbox);
				instance_destroy();
			}

			// Stands next to and slightly in front of the player
			if (nextToPlayer)
			{
				x = lerp(x, hostObject.x + (10 * hostObject.image_xscale), 0.2);
			}

			cancelable = false;
			grounded = true;
			canTurnAround = false;
			isShortHopping = false;
			isSuperJumping = false;
			hasSpentDoubleJump = false;
			vulnerable = false;

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
			// Immediately removes the spirit after the move is over in Spirit OFF
			if (!hostObject.spiritState)
			{
				hostObject.spiritObject = noone;
				hostObject.spiritSummoned = false;
				with(hostObject.hurtbox)
				{
					spiritOwner = noone;
				}
				instance_create_layer(x, y, "Instances", oSpiritFire);
				instance_destroy(hurtbox);
				instance_destroy();
			}

			// Stands next to and slightly in front of the player
			if (nextToPlayer)
			{
				x = lerp(x, hostObject.x + (10 * hostObject.image_xscale), 0.2);
			}

			cancelable = false;
			sprite_index = CharacterSprites.jumpsquat_Sprite;
			image_speed = 1;
			grounded = true;
			isShortHopping = false;
			vulnerable = false;

			hsp = jumpHsp;

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
			// Immediately removes the spirit after the move is over in Spirit OFF
			if (!hostObject.spiritState)
			{
				hostObject.spiritObject = noone;
				hostObject.spiritSummoned = false;
				with(hostObject.hurtbox)
				{
					spiritOwner = noone;
				}
				instance_create_layer(x, y, "Instances", oSpiritFire);
				instance_destroy(hurtbox);
				instance_destroy();
			}

			// Stands next to and slightly in front of the player
			if (nextToPlayer)
			{
				x = lerp(x, hostObject.x + (10 * hostObject.image_xscale), 0.2);
			}

			animTimer = 0;
			cancelable = false;
			sprite_index = CharacterSprites.jump_Sprite;
			image_speed = 1;
			grounded = false;
			canTurnAround = false;
			vulnerable = false;

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
		}
		break;


		case eState.STANDING_LIGHT_ATTACK:
		{
			GroundedAttackScript(selectedCharacter.StandLight, true, 1, 1, false, false);

			if (selectedCharacter.StandLight.SpiritData.MaintainPosition && hostObject.spiritSummoned)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.STANDING_LIGHT_ATTACK_2:
		{
			GroundedAttackScript(selectedCharacter.StandLight2, true, 1, 1, false, false);

			if (selectedCharacter.StandLight2.SpiritData.MaintainPosition && hostObject.spiritSummoned)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.STANDING_LIGHT_ATTACK_3:
		{
			GroundedAttackScript(selectedCharacter.StandLight3, true, 1, 1, false, false);

			if (selectedCharacter.StandLight3.SpiritData.MaintainPosition && hostObject.spiritSummoned)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.STANDING_MEDIUM_ATTACK:
		{
			GroundedAttackScript(selectedCharacter.StandMedium, true, 1, 1, false, false);

			if (selectedCharacter.StandMedium.SpiritData.MaintainPosition && hostObject.spiritSummoned)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.STANDING_HEAVY_ATTACK:
		{
			GroundedAttackScript(selectedCharacter.StandHeavy, true, 1, 1, false, false);

			if (selectedCharacter.StandHeavy.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;


		case eState.CROUCHING_LIGHT_ATTACK:
		{
			CrouchingAttackScript(selectedCharacter.CrouchingLight, true, false);

			if (selectedCharacter.CrouchingLight.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.CROUCHING_MEDIUM_ATTACK:
		{
			CrouchingAttackScript(selectedCharacter.CrouchingMedium, true, false);

			if (selectedCharacter.CrouchingMedium.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
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

			if (selectedCharacter.CrouchingHeavy.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;


		case eState.JUMPING_LIGHT_ATTACK:
		{
			JumpingAttackScript(selectedCharacter.JumpingLight, false, 1, 1);

			if (selectedCharacter.JumpingLight.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;


		case eState.JUMPING_MEDIUM_ATTACK:
		{
			JumpingAttackScript(selectedCharacter.JumpingMedium, false, 1, 1);

			if (selectedCharacter.JumpingMedium.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;


		case eState.JUMPING_HEAVY_ATTACK:
		{
			JumpingAttackScript(selectedCharacter.JumpingHeavy, false, 1, 1);

			if (selectedCharacter.JumpingHeavy.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
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

			if (selectedCharacter.CommandNormal1.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
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

			if (selectedCharacter.NeutralSpecial.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
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

			if (selectedCharacter.SideSpecial.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
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

			if (selectedCharacter.UpSpecial.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

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

			if (selectedCharacter.DownSpecial.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
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

			if (selectedCharacter.EnhancedNeutralSpecial.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
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

			if (selectedCharacter.EnhancedSideSpecial.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
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

			if (selectedCharacter.EnhancedUpSpecial.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
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

			if (selectedCharacter.EnhancedDownSpecial.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;
		
		case eState.ENHANCED_NEUTRAL_SPECIAL_2:
		{
			if (grounded)
			{
				GroundedAttackScript(selectedCharacter.EnhancedNeutralSpecial2, true, selectedCharacter.EnhancedNeutralSpecial2.AirMovementData.GravityScale, selectedCharacter.EnhancedNeutralSpecial2.AirMovementData.FallScale, false, true);
			}
			else
			{
				JumpingAttackScript(selectedCharacter.EnhancedNeutralSpecial2, false, selectedCharacter.EnhancedNeutralSpecial2.AirMovementData.GravityScale, selectedCharacter.EnhancedNeutralSpecial2.AirMovementData.FallScale);
			}

			if (selectedCharacter.EnhancedNeutralSpecial2.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.ENHANCED_SIDE_SPECIAL_2:
		{
			if (grounded)
			{
				GroundedAttackScript(selectedCharacter.EnhancedSideSpecial2, true, selectedCharacter.EnhancedSideSpecial2.AirMovementData.GravityScale, selectedCharacter.EnhancedSideSpecial2.AirMovementData.FallScale, false, true);
			}
			else
			{
				JumpingAttackScript(selectedCharacter.EnhancedSideSpecial2, false, selectedCharacter.EnhancedSideSpecial2.AirMovementData.GravityScale, selectedCharacter.EnhancedSideSpecial2.AirMovementData.FallScale);
			}

			if (selectedCharacter.EnhancedSideSpecial2.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.ENHANCED_UP_SPECIAL_2:
		{
			if (grounded)
			{
				GroundedAttackScript(selectedCharacter.EnhancedUpSpecial2, true, selectedCharacter.EnhancedUpSpecial2.AirMovementData.GravityScale, selectedCharacter.EnhancedUpSpecial2.AirMovementData.FallScale, false, true);
			}
			else
			{
				JumpingAttackScript(selectedCharacter.EnhancedUpSpecial2, false, selectedCharacter.EnhancedUpSpecial2.AirMovementData.GravityScale, selectedCharacter.EnhancedUpSpecial2.AirMovementData.FallScale);
			}

			if (selectedCharacter.EnhancedUpSpecial2.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.ENHANCED_DOWN_SPECIAL_2:
		{
			if (grounded)
			{
				GroundedAttackScript(selectedCharacter.EnhancedDownSpecial2, true, selectedCharacter.EnhancedDownSpecial2.AirMovementData.GravityScale, selectedCharacter.EnhancedDownSpecial2.AirMovementData.FallScale, false, true);
			}
			else
			{
				JumpingAttackScript(selectedCharacter.EnhancedDownSpecial2, false, selectedCharacter.EnhancedDownSpecial2.AirMovementData.GravityScale, selectedCharacter.EnhancedDownSpecial2.AirMovementData.FallScale);
			}

			if (selectedCharacter.EnhancedDownSpecial2.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
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

			if (selectedCharacter.RekkaLauncher.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

			//ProcessEnhancers(selectedCharacter.RekkaLauncher);
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

			if (selectedCharacter.RekkaFinisher.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

			//ProcessEnhancers(selectedCharacter.RekkaFinisher);
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

			if (selectedCharacter.RekkaConnecter.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

			//ProcessEnhancers(selectedCharacter.RekkaConnecter);
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

			if (selectedCharacter.RekkaLow.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

			//ProcessEnhancers(selectedCharacter.RekkaLow);
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

			if (selectedCharacter.RekkaHigh.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

			//ProcessEnhancers(selectedCharacter.RekkaHigh);
		}
		break;


		case eState.GRAB:
		{
			grounded = true;
			inAttackState = true;

			sprite_index = CharacterSprites.grab_Sprite;

			hurtbox.image_xscale = 15;
			hurtbox.image_yscale = 25;
			hurtboxOffset = -7;

			PerformAttack(selectedCharacter.Grab, true);

			if (animTimer > 24)
			{
				state = eState.IDLE;
			}

			if (selectedCharacter.Grab.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}
		}
		break;

		case eState.HOLD:
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

					if (hostObject.target != noone)
					{
						ds_list_clear(hostObject.target.hitByGroup);
					}

					// Handle moving the player away from the wall
					var ThrowDistance = instance_create_layer(x, y - 15, "hitboxes", oThrowEnvDetection);
					with(ThrowDistance)
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
					if (hostObject.target != noone)
					{
						ds_list_clear(hostObject.target.hitByGroup);
					}

					// Handle moving the player away from the wall
					var ThrowDistance = instance_create_layer(x, y - 15, "hitboxes", oThrowEnvDetection);
					with(ThrowDistance)
					{
						owner = other.id;
						image_xscale = other.selectedCharacter.BackwardThrow.OpponentPositionData.DistanceFromWall * other.image_xscale;
						throwToCheck = other.selectedCharacter.BackwardThrow;
					}
				}
			}
		}
		break;

		case eState.COMMAND_GRAB:
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

			if (selectedCharacter.CommandGrab.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

			ProccessCommandGrab();
		}
		break;

		case eState.BEING_GRABBED:
		{
			animTimer = 0;
			hsp = 0;
			grounded = true;
			inAttackState = false;
			canTurnAround = false;

			isGrabbed = true;
		}
		break;

		case eState.FORWARD_THROW:
		{
			grounded = true;
			inAttackState = true;

			sprite_index = selectedCharacter.ForwardThrow.SpriteId;
			image_index = 0;

			PerformAttack(selectedCharacter.ForwardThrow, true);

			if (selectedCharacter.ForwardThrow.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

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

		case eState.BACKWARD_THROW:
		{
			grounded = true;
			inAttackState = true;

			sprite_index = selectedCharacter.BackwardThrow.SpriteId;
			image_index = 0;

			PerformAttack(selectedCharacter.BackwardThrow, true);

			if (selectedCharacter.BackwardThrow.SpiritData.MaintainPosition)
			{
				nextToPlayer = false;
			}

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

		case eState.THROW_TECH:
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

		case eState.HURT:
		{
			animTimer = 1;
			cancelable = false;
			canTurnAround = false;
			isEXFlash = false;
			hitstun = hostObject.hitstun;

			if (hitstun < 1)
			{
				ds_list_clear(hostObject.hitByGroup);
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

			if (hostObject.grounded)
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

			vsp = hostObject.vsp;

		}
		break;


		case eState.LAUNCHED:
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

			vsp = hostObject.vsp;
			hitstun = hostObject.hitstun;

		}
		break;


		case eState.KNOCKED_DOWN:
		{
			if (nextToPlayer)
			{
				cancelable = false;
				grounded = true;
				invincible = true;
				canTurnAround = false;

				cancelCombo = true;
				sprite_index = CharacterSprites.knockdown_Sprite;
				hsp = 0;

				if (image_index > (image_number - 1))
				{
					image_speed = 0;
				}
				else
				{
					image_speed = 1;
				}

				hitstun = hostObject.hitstun;

				if (animTimer > 39)
				{
					state = eState.GETUP;
					animTimer = 0;
					sprite_index = CharacterSprites.getup_Sprite;
					image_index = 0;
				}
			}
			else
			{
				hostObject.spiritObject = noone;
				hostObject.spiritSummoned = false;
				hostObject.spiritState = false;
				if ((host.JumpType & 1) != 1)
				{
					hostObject.canDoubleJump = false;
				}
				if (host.UniqueData.LinkMovesetsWithSpirits)
				{
					hostObject.currentMovesetID = host.UniqueData.SpiritOffMoveset;
					with(hostObject)
					{
						OverwriteMoveset();
					}
				}
				with(hostObject.hurtbox)
				{
					spiritOwner = noone;
				}
				instance_create_layer(x, y, "Instances", oSpiritFire);
				instance_destroy(hurtbox);
				instance_destroy();
			}
		}
		break;


		case eState.GETUP:
		{
			cancelable = false;
			grounded = true;
			invincible = true;
			canTurnAround = false;

			image_speed = (image_index > image_number - 1) ? 0 : 1;

			if (animTimer > 30)
			{
				// Turn the player around immediately
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


		case eState.BLOCKING:
		{
			if (isCrouchBlocking)
			{
				sprite_index = CharacterSprites.crouchBlock_Sprite;
			}
			else
			{
				sprite_index = CharacterSprites.standBlock_Sprite;
			}

			if (hostObject.knockbackVel > 0)
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

			HandleWalkingOffPlatforms(false);

			// Create speed trail
			//SpeedTrail(0.3, 0.02, 3);
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

			vsp += global.rcUpFallSpeed;
			hsp = walkSpeed * 1.5 * image_xscale;

			// Create speed trail
			//SpeedTrail(0.3, 0.02, 3);
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

			vsp = global.rcAirSpeed;
			hsp = global.rcAirHorizontalSpeed * image_xscale;

			// Create speed trail
			//SpeedTrail(0.3, 0.02, 1);
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
				hostObject.startCombo = false;
				target.cancelCombo = false;

				if (hostObject.combo > 1 && hostObject.comboCounterID != noone)
				{
					hostObject.comboCounterID.endCombo = true;
				}

				hostObject.combo = 0;
				hostObject.comboScaling = 0;
				hostObject.meterScaling = 0;
				hostObject.comboCounterID = noone;
				hostObject.comboDamage = 0;
			}

			if (hostObject.startCombo)
			{
				if (playerID == 1)
				{
					hostObject.comboCounterID = instance_create_layer(-20, 48, "ComboCounter", oComboCounter);

					with(hostObject.comboCounterID)
					{
						owner = other.id;
						screenSide = 1;
						ui_xOffset = -20;
						ui_yOffset = 48;
					}
				}
				else
				{
					hostObject.comboCounterID = instance_create_layer(175, 48, "ComboCounter", oComboCounter);
					with(hostObject.comboCounterID)
					{
						owner = other.id;
						screenSide = -1;
						ui_xOffset = 175;
						ui_yOffset = 48;
					}
				}
				hostObject.startCombo = false;
			}
		}



		// Collision
		if (state != eState.HITSTOP)
		{
			if (opponent != noone && !nextToPlayer)
			{
				// Check to see if players are about to be touching
				if (place_meeting(x + hsp + environmentDisplacement, y, opponent) && state != eState.BEING_GRABBED && opponent.state != eState.BEING_GRABBED && ((grounded && opponent.grounded) || ((((opponent.state = eState.HURT || opponent.state = eState.BLOCKING) && !opponent.grounded) || opponent.state = eState.LAUNCHED) || (((state = eState.HURT || opponent.state = eState.BLOCKING) && !grounded) || state = eState.LAUNCHED))))
				{
					hsp *= .75; // Reduce player speed
					var origanalX = opponent.x; // Keep track of the opponent's x position before calculations
					// Simulate the opponent moving forwards
					opponent.x += (opponent.hsp * .75) + opponent.environmentDisplacement;
					// While the players are still touching
					while (place_meeting(x + hsp + environmentDisplacement, y, opponent))
					{
						// Move the players away from each other
						if x > opponent.x{
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
			if (place_meeting(x + hsp + environmentDisplacement, y, oWall) && state != eState.BEING_GRABBED)
			{
				while (!place_meeting(x + sign(hsp + environmentDisplacement), y, oWall))
				{
					x += sign(hsp + environmentDisplacement);
				}
				hsp = 0;
				environmentDisplacement = 0;
			}

			if (place_meeting(x, y + vsp + fallSpeed, oWall))
			{
				//Determine wether we are rising into a cieling or falling onto a floor.
				var fallDirection = sign(vsp);

				while (!place_meeting(x, y + sign(vsp + fallSpeed), oWall))
				{
					y += sign(vsp);
				}

				isJumpingForward = false;
				vsp = 0;
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

			x += hsp + environmentDisplacement;
			x = clamp(x, global.camObj.x - 80, global.camObj.x + 80);
			y += vsp;

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
	}
	else
	{
		image_speed = 0;
		if hitstun > 0 sprite_index = CharacterSprites.hurt_Sprite;
	}
	
	
	// Instantly delete the spirit when spirit health is reduced to zero
	if (hostObject.spiritCurrentHealth <= 0)
	{
		hostObject.spiritObject = noone;
		hostObject.spiritSummoned = false;
		hostObject.spiritState = false;
		if ((host.JumpType & 1) != 1)
		{
			hostObject.canDoubleJump = false;
		}
		if (host.UniqueData.LinkMovesetsWithSpirits)
		{
			hostObject.currentMovesetID = host.UniqueData.SpiritOffMoveset;
			with(hostObject)
			{
				OverwriteMoveset();
			}
		}
		with(hostObject.hurtbox)
		{
			spiritOwner = noone;
		}
		hostObject.spiritBroken = true;
		hostObject.hitstop = 60;
		hostObject.state = eState.LAUNCHED;
		hostObject.grounded = false;
		hostObject.vsp = -4; // Launches the player up
		hostObject.hsp = 0;
		instance_create_layer(x, y, "Instances", oSpiritFire);
		instance_destroy(hurtbox);
		instance_destroy();
	}
}