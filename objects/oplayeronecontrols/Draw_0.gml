draw_self();

if (showMessage)
{
	draw_text( 1, 100, "Please Press New Button");
}

draw_set_font(fntControls)
draw_text( 20, 1, string(chr((global.player1Controls.buttonUp))));

draw_set_font(fntControls)
draw_text( 20, 13, string(chr((global.player1Controls.buttonDown))));

draw_set_font(fntControls)
draw_text( 20, 28, string(chr((global.player1Controls.buttonLeft))));

draw_set_font(fntControls)
draw_text( 20, 43, string(chr((global.player1Controls.buttonRight))));


draw_set_font(fntControls)
draw_text( 60, 1, string(chr((global.player1Controls.buttonLight))));

draw_set_font(fntControls)
draw_text( 60, 13, string(chr((global.player1Controls.buttonMedium))));

draw_set_font(fntControls)
draw_text( 60, 28, string(chr((global.player1Controls.buttonHeavy))));

draw_set_font(fntControls)
draw_text( 60, 40, string((chr(global.player1Controls.buttonGrab))));

draw_set_font(fntControls)
draw_text( 60, 55, string((chr(global.player1Controls.buttonSpecial))));

draw_set_font(fntControls)
draw_text( 60, 65, string(chr((global.player1Controls.buttonSuper))));

draw_set_font(fntControls)
draw_text( 60, 80, string(chr((global.player1Controls.buttonRun))));

	
	
