/// @description Insert description here
// You can write your code in this editor

if owner == 1 {
	if global.p1Rounds < 3 image_index = global.p1Rounds;
	else image_index = 2;
} else {
	if global.p2Rounds < 3 image_index = global.p2Rounds;
	else image_index = 2;
}