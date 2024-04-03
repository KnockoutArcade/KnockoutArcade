/// @description Insert description here
// You can write your code in this editor

cameraWidth = 160;
cameraHeight = 120;

cameraSpeed = .75; // How fast the camera lerps between it's target position and its current position. Must be a decimal between 0 and 1

p1 = noone;
p2 = noone;

xCameraDestination = x; // Where the camera is targeted to movet towards
yCameraDestination = y;

isLocked = false; // Whether the camera is locked or not

isScreenShaking = false; // Whether the camera is currently shaking
screenShakeLevel = 0; // How much the screen should be shaking
screenShakeDuration = 0; // How long to shake the screen for

xHome = x; // The camera's position without screen shake
yHome = y; // The camera's position without screen shake

isTargetingWinner = false; // Whether the camera should focus on the winner of a round
roundWinTarget = noone; // The target of the camera during a round win