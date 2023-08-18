// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Each character may have a command grab that requires unique code to execute.
function ProccessCommandGrab()
{
	
	// Russel's Up Special Command Grab
	if (selectedCharacter.Name == "Russel")
	{
		// Detect if we have hit the ground. We're using the late part of the move as the activation hitbox.
		if (grounded && animTimer < 99)
		{
			animTimer = 99;
		}
		else if (animTimer == 1)
		{
			// Handle moving the player away from the wall
			var ThrowDistance = instance_create_layer(x, y-15, "hitboxes", oThrowEnvDetection);
			with (ThrowDistance)
			{
				owner = other.id;
				image_xscale = other.selectedCharacter.CommandGrab.OpponentPositionData.DistanceFromWall * other.image_xscale;
				throwToCheck = other.selectedCharacter.CommandGrab;
				mode = ThrowEnvironmentWallDetectionMode.CONSTANTCHECK;
			}
		}
	}
	
	//Gunther's Neutral Special Command Grab
	if (selectedCharacter.Name == "Gunther")
	{
		
		//spawns the Bathtub after a certain amount of time passes
		if (animTimer == 9)
		{
			//Creates a bathtub object that is assigned to an owner, which is Gunther in this case
			var Bathtub = instance_create_layer(x+(30 * image_xscale),y,"Instances" ,oGunther_NSpecial_Bathtub);
			with Bathtub
			{
				owner = other.id;
			}
		}
		
		// Detect if we have hit the ground after leaving it. We're using the late part of the move as the activation hitbox.
		if ((grounded && animTimer < 99) && animTimer >20)
		{
			animTimer = 99;
		}
		else if (animTimer == 1)
		{
			// Handle moving the player away from the wall
			var ThrowDistance = instance_create_layer(x, y-15, "hitboxes", oThrowEnvDetection);
			with (ThrowDistance)
			{
				owner = other.id;
				image_xscale = other.selectedCharacter.CommandGrab.OpponentPositionData.DistanceFromWall * other.image_xscale;
				throwToCheck = other.selectedCharacter.CommandGrab;
				mode = ThrowEnvironmentWallDetectionMode.CONSTANTCHECK;
			}
		}
		
	}
}