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

global.toggleHitboxVisibility = false;
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

calculateFrameData = false;
frameAdvantage = 0;
victim = 0;
nonVictim = 0;

SetupGame();

global.p1Rounds = 0;
global.p2Rounds = 0;

audio_play_sound(testBGM, 0, true);

P1resultSelRow = 0;
P1resultSelCol = 0;
P1cursorCooldown = 5;

P1resultSelRowMax = 3;

P2resultSelRow = 0;
P2resultSelCol = 0;
P2cursorCooldown = 5;

P2resultSelRowMax = 3;

P1hasSelectedresult = false;
P2hasSelectedresult = false;

P1cursorY = 0;
P2cursorY = 0;

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