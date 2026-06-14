/// @description Insert description here
// You can write your code in this editor

// Debug stuff
/*
draw_set_alpha(.5);
draw_set_color(c_black);
draw_rectangle(10, 0, 50, 100, false);
draw_set_alpha(1);
draw_set_color(c_white);
	
draw_text(20, 10, p1SideController);
draw_text(20, 30, p1SideControllerSlot);
draw_text(20, 50, p2SideController);
draw_text(20, 70, p2SideControllerSlot);
draw_text(20, 90, ds_list_size(oControllerManager.controllerUpdateNotifyList));
*/

if (state != eCharacterSelectState.CHARACTER_SELECT)
{
	exit;
}


if (P2charSelCol == 2 && P2charSelRow == 0) || (P2charSelCol == 0 && P2charSelRow == 1) || (P2charSelCol == 1 && P2charSelRow == 1)
{
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(580, 135, 740, 335, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_text(585, 175, @"This character
	is unfinished
	and may show 
	incorrect sprites");
}

if (P1charSelCol == 2 && P1charSelRow == 0) || (P1charSelCol == 0 && P1charSelRow == 1) || (P1charSelCol == 1 && P1charSelRow == 1)
{
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(65, 135, 225, 335, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_text(70, 175, @"This character 
	is unfinished
	and may show 
	incorrect sprites");
}