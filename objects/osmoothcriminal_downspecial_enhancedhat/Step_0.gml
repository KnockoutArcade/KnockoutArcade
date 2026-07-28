/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

hsp = (max((abs(hsp) - dragSpeed), minSpeed)) * sign(hsp);

event_inherited();
