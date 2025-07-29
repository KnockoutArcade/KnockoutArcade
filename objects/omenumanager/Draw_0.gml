/// @description Insert description here
// You can write your code in this editor

if (startTextTimer > 29)
{
	startTextShow = !startTextShow;
	startTextTimer = 0;
	
}

if (startTextShow)
{
	draw_sprite(sStartText, 0, 0, 0);
}


// Draw the logo
if (animTimer > logoAppearStart && animTimer < logoAppearEnd)
{
	var sizeEquasion = (animTimer + (animTimer - logoAppearEnd + 2)) / (logoAppearEnd);
	var sizeEquasionX = lerp(maxScale, minScale, sizeEquasion);
	var sizeEquasionY = lerp(maxScale, minScale, sizeEquasion);
	
	draw_sprite_ext(sLogo, 0, 80, 60, max(sizeEquasionX, minScale), max(sizeEquasionY, minScale), 0, c_white, 1);
}
else if (animTimer >= logoAppearEnd && animTimer < logoShakeEnd)
{
	if (animTimer mod 2 == 0)
	{
		randomOffsetX = irandom_range(-logoShakeIntensity, logoShakeIntensity);
		randomOffsetY = irandom_range(-logoShakeIntensity, logoShakeIntensity);
	}
	
	if (animTimer > logoShakeEnd - 4)
	{
		randomOffsetX = irandom_range(-1, 1);
		randomOffsetY = irandom_range(-1, 1);
	}
	
	draw_sprite_ext(sLogo, 0, 80 + randomOffsetX, 60 + randomOffsetY, minScale, minScale, 0, c_white, 1);
}
else if (animTimer >= logoShakeEnd)
{
	draw_sprite(sLogo, 0, 80, 60);
	startTextTimer++;
}