/// @description Insert description here
// You can write your code in this editor

if (!global.togglePresentationMode)
{
	x = (global.camObj.x-80) + ui_xOffset;
	
	if (attatchedTo.spiritBroken)
	{
		shader_set(sh_SpiritBroken);
		//shader_set_uniform_f_array(uniColor, color);
		draw_self();
		shader_reset();
	}
	else
	{
		draw_self();
	}
}