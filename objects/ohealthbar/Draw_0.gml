/// @description Insert description here
// You can write your code in this editor

if (attatchedTo.hp <= 0)
{
	image_xscale = 0;
}

if (!global.togglePresentationMode)
{
	x = (global.camObj.x-80) + ui_xOffset;
	
	// The way damage showing works is that there is a second sprite behind the healthbar that only shows
	// while the player is taking damage. 
	if (attatchedTo.hitstun > 0 || attatchedTo.state == eState.LAUNCHED || isDecreasingSpriteGradually)
	{
		// The base sprite is animating between 2 identical frames, which allows the damage sprite
		// to animate as well.
		draw_sprite_ext(sHealthbar_Damage, image_index, x, y, initialHealthXscale, 1, 0, c_white, 1);
		
	}
	
	draw_self();
}