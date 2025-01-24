/// @description Insert description here
// You can write your code in this editor

// Draw the first file
draw_sprite_ext(sFileSelect_Base, !isSelectingFile1, file1PositionX, file1PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_Font, 0, file1PositionX + 23, file1PositionY + 2, 1, 1, 0, file1DrawColor, 1);

// 2nd File
draw_sprite_ext(sFileSelect_Base, !isSelectingFile2, file2PositionX, file2PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_Font, 1, file2PositionX + 23, file2PositionY + 2, 1, 1, 0, file2DrawColor, 1);

// 3rd File
draw_sprite_ext(sFileSelect_Base, !isSelectingFile3, file3PositionX, file3PositionY, 1, 1, 0, c_white, 1);
draw_sprite_ext(sFileSelect_Font, 2, file3PositionX + 23, file3PositionY + 2, 1, 1, 0, file3DrawColor, 1);

draw_sprite_ext(sFileSelect_FileSelectText, 0, titlePositionX, titlePositionY, 1, 1, 0, c_white, 1);


