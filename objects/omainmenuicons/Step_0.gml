var up, down, accept;

up = keyboard_check_pressed(ord("W")) or gamepad_button_check_pressed(0, gp_padu);
down = keyboard_check_pressed(ord("S")) or gamepad_button_check_pressed(0, gp_padd);
accept = keyboard_check_pressed(ord("J"))or gamepad_button_check_pressed(0, gp_face1);

if (up)
{
	image_index--;
}

if (down)
{
	image_index++;
}

if (image_index == 0 and accept)
{
	room_goto(rRusselMap);
}

if (image_index == 1 and accept)
{
	room_goto(rCharacterSelectScreen);
}