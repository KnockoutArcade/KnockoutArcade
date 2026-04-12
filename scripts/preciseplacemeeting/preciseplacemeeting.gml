// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// This is a more precise collision function than the base function from GSM2.
// The GSM2 function rounds positions to the nearest integer, which causes slight rounding errors
function PrecisePlayerCollision(obj1, obj2)
{
	var obj1_originx = obj1.x;
	var obj2_originx = obj2.x;
	
	obj1.x += (obj1.hsp + obj1.environmentDisplacement);
	obj2.x += (obj2.hsp + obj2.environmentDisplacement);
	
	if (obj1.x < obj2.x + round(obj2.bbox_right - obj2.bbox_left))
	&& (obj1.x + round(obj1.bbox_right - obj1.bbox_left) > obj2.x)
	&& (obj1.y < obj2.y + round(obj2.bbox_bottom - obj2.bbox_top))
	&& (obj1.y + round(obj1.bbox_bottom - obj1.bbox_top)> obj2.y)
	{
		obj1.x = obj1_originx;
		obj2.x = obj2_originx;
		
		return true;
	}
	
	obj1.x = obj1_originx;
	obj2.x = obj2_originx;
	return false;
}