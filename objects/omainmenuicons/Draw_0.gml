/// @description Insert description here
// You can write your code in this editor


draw_self();

if (drawInitialText)
{
	draw_sprite(sMainMenuPercyDialogue, 0, 0, 0)
}
else
{
	draw_sprite(sMainMenuPercyDialogue, image_index + 1, 0, 0)
}

draw_sprite(sMainMenuPercy, isPercyEyesClosed, 0, 0)

