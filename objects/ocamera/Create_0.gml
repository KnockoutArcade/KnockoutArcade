/// @description Insert description here
// You can write your code in this editor

cameraWidth = 160;
cameraHeight = 120;

cameraSpeed = .75; // How fast the camera lerps between it's target position and its current position. Must be a decimal between 0 and 1
cameraPanDelay = 3; // How many frames to wait until the camera starts panning again.
cameraPanDelayTimer = 0; // The timer used to handle the camera's delay before panning.
cameraRightSidePanAmount = 45; // How far to pan the camera to the right in singlplayer.
cameraLeftSidePanAmount = -5; // How far to pan the camera to the left in singleplayer.
cameraPanDirection = 1; // Which way to pan the camera ( 1 = right, -1 = left )

p1 = noone;
p2 = noone;

xCameraDestination = x; // Where the camera is targeted to move towards
yCameraDestination = y;

isLocked = false; // Whether the camera is locked or not

isScreenShaking = false; // Whether the camera is currently shaking
screenShakeLevel = 0; // How much the screen should be shaking
screenShakeDuration = 0; // How long to shake the screen for

xHome = x; // The camera's position without screen shake
yHome = y; // The camera's position without screen shake

isTargetingWinner = false; // Whether the camera should focus on the winner of a round
roundWinTarget = noone; // The target of the camera during a round win