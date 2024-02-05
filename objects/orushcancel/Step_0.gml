/// @description Insert description here
// You can write your code in this editor

image_xscale += 0.4;
image_yscale += 0.4;

fadeTimer++;

// Move the RC banner in
if (fadeTimer < 10)
{
	if (doRCLayersExist)
	{
		layer_y(rushCancelBanner_Top, lerp(layer_get_y(rushCancelBanner_Top), rushCancelBanner_Top_yOffset, 0.5));
		layer_y(rushCancelBanner_Bottom, lerp(layer_get_y(rushCancelBanner_Bottom), rushCancelBanner_Bottom_yOffset, 0.5));
	}
}
else if (fadeTimer >= 10 && fadeTimer < 30)
{
	// Fade the sprite
	image_alpha = clamp(image_alpha - 0.1, 0, 1);
	
	if (doRCLayersExist)
	{
		// Set the RC banners to their ending positions
		layer_y(rushCancelBanner_Top, rushCancelBanner_Top_yOffset);
		layer_y(rushCancelBanner_Bottom, rushCancelBanner_Bottom_yOffset);
	}
}

// Reset the RC Banner
if (fadeTimer >= 30)
{
	if (doRCLayersExist)
	{
		// Start moving the banners back
		layer_y(rushCancelBanner_Top, lerp(layer_get_y(rushCancelBanner_Top), rushCancelBanner_Top_RestPosition, 0.5));
		layer_y(rushCancelBanner_Bottom, lerp(layer_get_y(rushCancelBanner_Bottom), rushCancelBanner_Bottom_RestPosition, 0.5));
	}
}

if (fadeTimer >= 35)
{
	if (doRCLayersExist)
	{
		// Reset the RC layers to their resting positions
		layer_y(rushCancelBanner_Top, rushCancelBanner_Top_RestPosition);
		layer_y(rushCancelBanner_Bottom, rushCancelBanner_Bottom_RestPosition);
	}
	
	// Destroy this object
	instance_destroy();
}