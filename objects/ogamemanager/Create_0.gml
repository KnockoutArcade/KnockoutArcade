/// @description Insert description here
// You can write your code in this editor

state = eGameManagerState.DURING_MATCH;

enum eGameManagerState
{
	DURING_MATCH,
	ROUND_WIN,
	POST_MATCH
}

global.frameskip = 0;
global.game_paused = 0;
global.freezeTimer = false; // For SCREEN_FREEZE

global.hitstop = 0;

//global.toggleHitboxVisibility = false;
global.togglePresentationMode = false;

global.currentRound = 0;
global.roundOver = false; // Whether the round is currently over

global.hasCompletedIntros = false;
levelCompleteTimer = 0; // Timer for the level end sequence
levelCompleteParticle = noone; // Pointer to the particle effect responsible for putting the results on the screen
levelCompleteTimeScore = noone; // Pointer to the text object that renders the time achieved on the level
levelCompleteMoneyScore = noone; // Pointer to text object for the amount of money achieved on this level
levelCompleteDamageScore = noone; // Pointer to the text object for the amount of damage recieved
levelCompleteKOScore = noone; // Pointer to thet ext object for the number of enemies defeated

p1 = noone;
p2 = noone;
global.camObj = noone;

healthbar1 = noone;
healthbar2 = noone;
spiritbar1 = noone;
spiritbar2 = noone;
TimerObject = noone;
hudObject = noone;
specialChargeIcon1 = noone;
specialChargeIcon2 = noone;

calculateFrameData = false;
frameAdvantage = 0;
victim = 0;
nonVictim = 0;

SetupGame();

global.p1Rounds = 0;
global.p2Rounds = 0;

audio_play_sound(global.currentBGM, 0, true);

momentWhenBothPlayersWereStable = 0; // During round win, the frame when both players entered a stable state
victoryAnimationDelay = 30; // The delay between when players are stable and when the victory animation should play (frames)
victoryAnimationTime = 0; // The moment when a player entered their victory animation
victoryAnimationDuration = 100; // The amount of time the victory animation plays for (in frames)

// Pausing
pauseMenuObject = noone; // The object that is responsible for the pause menu
shouldBringUpPauseMenu = false; // Whether the pause menu should be brought up or not
pauseMenuButtonHeldTimer_P1 = 0; // Keeps track of how many frames P1 has held down the pause button
pauseMenuButtonHeldTimer_P2 = 0; // Keeps track of how many frames P2 has held down the pause button
pauseMenuHoldRequirement = 30; // How long the player must hold the pause button in order to pause

// Controllers
p1ControllerInstance = FindController(global.player1ControllerSlot);
p2ControllerInstance = FindController(global.player2ControllerSlot);

// Singleplayer Pause Script
function GameManagerPauseSingleplayer()
{
	// Handle Pausing
	if (!global.game_paused && !p1.isInCutscene) // Check to see if we are not in a cutscene right now
	{
		var p1PauseButton = false;
		if (p1ControllerInstance != -1)
		{
			p1PauseButton = p1ControllerInstance.buttonMenuPause;
		}
			
		// If p1 pressed pause and the pause menu isn't up already
		if (p1PauseButton && pauseMenuObject == noone)
		{
			pauseMenuButtonHeldTimer_P1++; // increment P1's timer by 1
		}
		else
		{
			pauseMenuButtonHeldTimer_P1 = 0; // reset P1's timer
		}
			
		// If a player has reached the hold requirement (in singleplayer, pressing the button is enough)
		if (pauseMenuButtonHeldTimer_P1 == 1)
		{
			// Create the Pause menu
			pauseMenuObject = instance_create_depth(global.camObj.x-80, global.camObj.y, -10000, oPauseMenu);
				
			// Set the pause menu's owner
			pauseMenuObject.owner = id;
				
			// set Player number to 0 (animation already set by default)
			pauseMenuObject.playerNumber = 0;
				
			// Establish controller ports with pause menu
			pauseMenuObject.controllerSlot = global.player1ControllerSlot;
			pauseMenuObject.p2ControllerSlot = -1;
				
			// Pause the game
			global.game_paused = true;
				
			// reset the pause button timers
			pauseMenuButtonHeldTimer_P1 = 0;
		}
	}
}