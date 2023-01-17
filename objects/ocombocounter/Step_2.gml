/// @description Insert description here
// You can write your code in this editor


animTimer++;

if endCombo = true {
	animTimer = 0;
	state = 1;
	endCombo = false;
}

if state = 0 {
	if animTimer < 8 ui_xOffset += 6 * screenSide;
	number = owner.combo;
} else {
	if animTimer < 3 numberScale += 0.05;
	else if animTimer < 6 numberScale -= 0.05;
	
	
	if animTimer < 6 {
		image_index = 1;
	}
	else {
		image_index = 0;
	}
	
	if animTimer >= 20 ui_xOffset -= 6 * screenSide;
	if animTimer >= 28 instance_destroy();
}


numLength = string_length(number);


if global.gameHalt instance_destroy();