/// @description Insert description here
// You can write your code in this editor

// Draw the first file
draw_sprite_ext(sFileSelect_Base, !isSelectingFile1, file1PositionX, file1PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_NewGameText, !isSelectingFile1, file1PositionX, file1PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_Font, 0, file1PositionX + 23, file1PositionY + 2, 1, 1, 0, file1DrawColor, 1);

draw_set_halign(fa_left);
draw_set_valign(fa_center);
draw_set_color(file1TextDrawColor);
draw_set_font(fileFont);

draw_text_ext(file1PositionX + 9, file1PositionY + 48, "---:--", 4, 130);
draw_set_halign(fa_center);
draw_text_ext(file1PositionX + 16, file1PositionY + 58, "0%", 4, 130);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(Font1);

// 2nd File
draw_sprite_ext(sFileSelect_Base, !isSelectingFile2, file2PositionX, file2PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_NewGameText, !isSelectingFile2, file2PositionX, file2PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_Font, 1, file2PositionX + 23, file2PositionY + 2, 1, 1, 0, file2DrawColor, 1);

draw_set_halign(fa_left);
draw_set_valign(fa_center);
draw_set_color(file2TextDrawColor);
draw_set_font(fileFont);

draw_text_ext(file2PositionX + 9, file2PositionY + 48, "0:30", 4, 130);
draw_set_halign(fa_center);
draw_text_ext(file2PositionX + 16, file2PositionY + 58, "50%", 4, 130);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(Font1);

// 3rd File
draw_sprite_ext(sFileSelect_Base, !isSelectingFile3, file3PositionX, file3PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_NewGameText, !isSelectingFile3, file3PositionX, file3PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_Font, 2, file3PositionX + 23, file3PositionY + 2, 1, 1, 0, file3DrawColor, 1);

draw_set_halign(fa_left);
draw_set_valign(fa_center);
draw_set_color(file3TextDrawColor);
draw_set_font(fileFont);

draw_text_ext(file3PositionX + 9, file3PositionY + 48, "20:00", 4, 130);
draw_set_halign(fa_center);
draw_text_ext(file3PositionX + 16, file3PositionY + 58, "100%", 4, 130);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(Font1);

// Draw the title
draw_sprite_ext(sFileSelect_FileSelectText, 0, titlePositionX, titlePositionY, 1, 1, 0, c_white, 1);

#region // Drawing buttons

// When drawing the buttons, only show up during the "Selecting File" state
if (state != eFILESELECTMENUSTATES.SELECTING_FILE)
{
	exit;
}

// Draw the "A" button at the bottom of the screen
draw_sprite(sFileSelect_ButtonText, 0, 20, 112);
if (global.player1ControllerType == "KEYBOARD")
{
	draw_sprite(sButtons_Keyboard, 16, 8, 110); // The "J" Key
}
else
{
	draw_sprite(sButtons_Controller, 0, 8, 110); // The "A" Button
}

// Draw the "B" button at the bottom of the screen
draw_sprite(sFileSelect_ButtonText, 1, 42, 112);
if (global.player1ControllerType == "KEYBOARD")
{
	draw_sprite(sButtons_Keyboard, 17, 30, 110); // The "K" Key
}
else
{
	draw_sprite(sButtons_Controller, 1, 30, 110); // The "B" Button
}

// Draw the "X" button at the bottom of the screen
draw_sprite(sFileSelect_ButtonText, 2, 74, 112);
if (global.player1ControllerType == "KEYBOARD")
{
	draw_sprite(sButtons_Keyboard, 18, 62, 110); // The "L" Key
}
else
{
	draw_sprite(sButtons_Controller, 2, 62, 110); // The "X" Button
}

// Draw the "Y" button at the bottom of the screen
draw_sprite(sFileSelect_ButtonText, 3, 111, 112);
if (global.player1ControllerType == "KEYBOARD")
{
	draw_sprite(sButtons_Keyboard, 42, 99, 110); // The ";" Key
}
else
{
	draw_sprite(sButtons_Controller, 3, 99, 110); // The "Y" Button
}
#endregion