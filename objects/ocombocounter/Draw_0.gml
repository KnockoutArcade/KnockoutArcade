/// @description Insert description here
// You can write your code in this editor
x = (global.camObj.x-80) + ui_xOffset;

draw_self();

var _stringNumber = string(number);

var _stringOrd = string_char_at(_stringNumber, 0);
var _stringOrd2 = string_char_at(_stringNumber, 2);

draw_sprite_ext(sComboCounter_Numbers, _stringOrd, x - 10, y - 10, numberScale, numberScale, 0, c_white, 1);

if (numLength > 1)
{
    draw_sprite_ext(sComboCounter_Numbers, _stringOrd2, (x - 10) + 15, y - 10, numberScale, numberScale, 0, c_white, 1);
}

//draw_text(x, y - 50, _stringOrd);