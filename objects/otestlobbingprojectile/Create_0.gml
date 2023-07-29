/// @description Insert description here
// You can write your code in this editor

// We can get the data of a projectile by getting the data from an index of projectileData. Since the index
// of each projectile may be different from build to build, I've set up this code that will iterate
// through each index to find the name of each index, with which we can use to access the correct
// projectile data
selectedProjectile = -1;
for (var i = 0; i < global.numberOfProjectiles; i++;)
{
	if (global.projectileData[i].Name == "TestLobbingProjectile")
	{
		selectedProjectile = global.projectileData[i];
		break;
	}
}

event_inherited();



