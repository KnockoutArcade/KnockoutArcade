/// @description Insert description here
// You can write your code in this editor

// Clean up any lists
ds_list_destroy(collidedWithProjectileList);
collidedWithProjectileList = -1;

ds_list_destroy(processedWithProjectileList);
processedWithProjectileList = -1;

ds_list_destroy(hitboxID);
hitboxID = -1;

ds_list_destroy(objectsHitList);
objectsHitList = -1;
