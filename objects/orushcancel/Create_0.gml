/// @description Insert description here
// You can write your code in this editor

image_xscale = 0;
image_yscale = 0;

// After this timer reaches a certain number, circle starts fading
fadeTimer = 0;

// Determines whether the RC layers are available right now
doRCLayersExist = false; // Failsafe in case we forget to add RC banners to a stage

// Get the layer ids of the rush cancel banners
if (layer_exists("RC_Banner_Top") && layer_exists("RC_Banner_Bottom"))
{
	rushCancelBanner_Top = layer_get_id("RC_Banner_Top");
	rushCancelBanner_Bottom = layer_get_id("RC_Banner_Bottom");
	
	doRCLayersExist = true; // set RClayers to true
}

rushCancelBanner_Top_yOffset = 35; // Where on screen the Top RC banner should appear
rushCancelBanner_Bottom_yOffset = 90; // Where on screen the Bottom RC banner should appear

rushCancelBanner_Top_RestPosition = -10; // Where the top RC banner rests when not used
rushCancelBanner_Bottom_RestPosition = 125; // where the bottom RC banner rests when not used

// If an instance of oRushCancel already exists, destroy it
if (instance_exists(oRushCancel))
{
	with (instance_exists(oRushCancel))
	{
		instance_destroy();
	}
}

// Destroy all instances of super flash background
instance_destroy(oSuperFlashBackground);