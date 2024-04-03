/// @description Insert description here
// You can write your code in this editor

owner = noone;

ui_xOffset = 0;
ui_yOffset = 0;

// Timer Variables
levelTimerMilliseconds = 0; // Time in milliseconds that the player has been in the level
levelTimerSeconds = 0; // The Seconds component for the timer
levelTimerMinutes = 0; // The Minutes component for the timer

digitMargin = 4; // How far apart each digit is
millisecondsPositionOffset = 20; // Where the milliseconds display relative to this object's location
secondsPositionOffset = 10; // Where the milliseconds display relative to this object's location
minutesPositionOffset = 0; // Where the milliseconds display relative to this object's location
decimal1Position = 7; // Position of the first decimal
decimal2Position = 17; // Position of the second decimal

stringMilliseconds = "000"; // The string to display milliseconds, initialized as 000
stringSeconds = "00"; // The string to display seconds, initialized as 00
stringMinutes = "00"; // The string to display Minutes, initialized as 00