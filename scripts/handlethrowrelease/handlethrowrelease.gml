// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function HandleThrowRelease()
{
	state = eState.THROW_TECH;	
	animTimer = 0;
	hsp += ThrowTechDistance * -image_xscale;
}