/// @description Insert description here
// You can write your code in this editor

vsp += fallSpeed;

// Crash onto the ground
if (place_meeting(x, y + vsp, oWall))
{
	floor(y);
	
	while (!place_meeting(x, y, oWall))
	{
		y += 1;
	}
	
	fallSpeed = 0;
	image_index = 1;
	vsp = 0;
	
	// Handle Opening Objects
	if (place_meeting(x, y, oDestructibleObject) && !hasFallen)
	{
		var collidedObjectsList = ds_list_create();
		var collidedObjects = instance_place_list(x, y, oDestructibleObject, collidedObjectsList, false);
		hasFallen = true;
		
		for (var i = 0; i < collidedObjects; i++;)
		{
			with (collidedObjectsList[| i])
			{
				if (openableByObjects)
				{
					isOpened = true;
					image_index = 1;
				}
			}
		}
		
		ds_list_destroy(collidedObjectsList);
	}
}

y += vsp;
