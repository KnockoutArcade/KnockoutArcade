draw_set_font(fntControls);
draw_set_color(c_black);

draw_set_halign(fa_center);

draw_text(80, 1, "<  " + playerControlsType + "  >");

draw_set_halign(fa_left);

draw_set_color(c_dkgray);

draw_text(1, 16, "Up");
draw_text(1, 28, "Down");
draw_text(1, 43, "Left");
draw_text(1, 58, "Right");

draw_text(75, 16, "Light");
draw_text(75, 28, "Medium");
draw_text(75, 43, "Heavy");
draw_text(75, 58, "Grab");
draw_text(75, 73, "Special");
draw_text(75, 88, "Super");
draw_text(75, 103, "Run");

draw_set_color(c_white);

switch (selectedOption)
{
	case -1:
		draw_set_halign(fa_center);
		draw_text(80, 1, playerSelectedText);
		draw_set_halign(fa_left);
		break;
	case 0:
		draw_text(1, 16, "Up");
		break;
	case 1:
		draw_text(1, 28, "Down");
		break;
	case 2:
		draw_text(1, 43, "Left");
		break;
	case 3:
		draw_text(1, 58, "Right");
		break;
	case 8:
		draw_text(75, 16, "Light");
		break;
	case 9:
		draw_text(75, 28, "Medium");
		break;
	case 10:
		draw_text(75, 43, "Heavy");
		break;
	case 11:
		draw_text(75, 58, "Grab");
		break;
	case 12:
		draw_text(75, 73, "Special");
		break;
	case 13:
		draw_text(75, 88, "Super");
		break;
	case 14:
		draw_text(75, 103, "Run");
		break;
}

draw_set_color(c_navy);

if (playerControlsType == "KEYBOARD")
{
	// column 1
	draw_text(26, 16, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonUp));
	draw_text(26, 28, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonDown));
	draw_text(26, 43, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonLeft));
	draw_text(26, 58, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonRight));

	// column 2
	draw_text(110, 16, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonLight));
	draw_text(110, 28, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonMedium));
	draw_text(110, 43, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonHeavy));
	draw_text(110, 58, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonGrab));
	draw_text(110, 73, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonSpecial));
	draw_text(110, 88, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonSuper));
	draw_text(110, 103, GetPrintableKeyName(playerControlsToChange.Keyboard.buttonRun));
}
else
{
	// column 1
	draw_text(26, 16, GetPrintableKeyName(playerControlsToChange.Controller.buttonUp));
	draw_text(26, 28, GetPrintableKeyName(playerControlsToChange.Controller.buttonDown));
	draw_text(26, 43, GetPrintableKeyName(playerControlsToChange.Controller.buttonLeft));
	draw_text(26, 58, GetPrintableKeyName(playerControlsToChange.Controller.buttonRight));

	// column 2
	draw_text(110, 16, GetPrintableKeyName(playerControlsToChange.Controller.buttonLight));
	draw_text(110, 28, GetPrintableKeyName(playerControlsToChange.Controller.buttonMedium));
	draw_text(110, 43, GetPrintableKeyName(playerControlsToChange.Controller.buttonHeavy));
	draw_text(110, 58, GetPrintableKeyName(playerControlsToChange.Controller.buttonGrab));
	draw_text(110, 73, GetPrintableKeyName(playerControlsToChange.Controller.buttonSpecial));
	draw_text(110, 88, GetPrintableKeyName(playerControlsToChange.Controller.buttonSuper));
	draw_text(110, 103, GetPrintableKeyName(playerControlsToChange.Controller.buttonRun));
}

if (showMessage)
{
	draw_set_color(c_black);
	draw_rectangle(0, 40, 160, 80, false);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text(80, 60, "Please Press New Button");
	draw_set_valign(fa_top);
}