// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DropCoins(amount)
{
	for (var i = 0; i < amount; i++;)
	{
		var coin = instance_create_depth(x, y - 10, depth - 1, oQuarterCollectable)
		
		with (coin)
		{
			obeyGravity = true;
			
			hsp = random_range(-1.5, 1.5);
			vsp = -random_range(2, 5);
		}
	}
}