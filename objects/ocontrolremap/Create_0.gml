buttonUp = button_add(10, 10, "Up");
textUp = textbox_add(110, 10, global.p1ButtonUp, 32);

buttonUp = button_add(10, 10, "Down");
textUp = textbox_add(110, 10, global.p1ButtonDown, 32);

button_set_script(buttonUp, "remap_control('Up')");
button_set_script(buttonDown, "remap_control('Down')");