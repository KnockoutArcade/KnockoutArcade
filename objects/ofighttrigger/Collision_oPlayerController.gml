/// @description Insert description here
// You can write your code in this editor

if (!isCurrentlyActive && other.playerID != 0)
{
	isTriggered = true;
	
	instanceThatTriggeredThis = instance_place(x,y,oPlayerController);
}

