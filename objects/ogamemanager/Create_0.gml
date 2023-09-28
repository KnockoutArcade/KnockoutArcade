/// @description Insert description here
// You can write your code in this editor

state = 0;

global.frameskip = 0;
global.game_paused = 0;
global.freezeTimer = false; // For SCREEN_FREEZE

global.hitstop = 0;

global.toggleHitboxVisibility = false;
global.togglePresentationMode = false;

global.currentRound = 0;

global.hasCompletedIntros = false;

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
