draw_self();

if (showMessage)
{
	draw_text( 1, 100, "Please Press New Button")
}
draw_set_font(fntControls)
draw_text( 108, 1, string(chr((global.player2Controls.buttonUp))));

draw_set_font(fntControls)
draw_text( 108, 13, string(chr((global.player2Controls.buttonDown))));

draw_set_font(fntControls)
draw_text( 108, 28, string(chr((global.player2Controls.buttonLeft))));

draw_set_font(fntControls)
draw_text( 108, 43, string(chr((global.player2Controls.buttonRight))));


draw_set_font(fntControls)
draw_text( 148, 1, string(chr((global.player2Controls.buttonLight))));

draw_set_font(fntControls)
draw_text( 148, 13, string(chr((global.player2Controls.buttonMedium))));

draw_set_font(fntControls)
draw_text( 148, 28, string(chr((global.player2Controls.buttonHeavy))));

draw_set_font(fntControls)
draw_text( 148, 40, string((chr(global.player2Controls.buttonGrab))));

draw_set_font(fntControls)
draw_text( 148, 55, string((chr(global.player2Controls.buttonSpecial))));

draw_set_font(fntControls)
draw_text( 148, 65, string(chr((global.player2Controls.buttonSuper))));

draw_set_font(fntControls)
draw_text( 148, 80, string(chr((global.player2Controls.buttonRun))));




