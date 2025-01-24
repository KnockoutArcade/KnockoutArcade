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


