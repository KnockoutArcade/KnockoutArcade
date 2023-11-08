/// @description Insert description here
// You can write your code in this editor


if (!global.togglePresentationMode)
{
	x = (global.camObj.x-80) + ui_xOffset;
	
	// Split up coin score into different parts
	coinScoreTens = floor(owner.coinScore / 10);
	coinScoreOnes = round(frac(floor(owner.coinScore) / 10) * 10);
	coinScoreTenths = floor(frac(owner.coinScore) * 10);
	coinScoreHundredths = round(frac(owner.coinScore * 10) * 10);
	
	draw_sprite(sSingleplayerHudNumbers, coinScoreTens, (global.camObj.x-80) + ui_xOffset, y);
	draw_sprite(sSingleplayerHudNumbers, coinScoreOnes, (global.camObj.x-80) + ui_xOffset + 4, y);
	draw_sprite(sSingleplayerHudNumbers, 10, (global.camObj.x-80) + ui_xOffset + 7, y);
	draw_sprite(sSingleplayerHudNumbers, coinScoreTenths, (global.camObj.x-80) + ui_xOffset + 10, y);
	draw_sprite(sSingleplayerHudNumbers, coinScoreHundredths, (global.camObj.x-80) + ui_xOffset + 14, y);
	

}


