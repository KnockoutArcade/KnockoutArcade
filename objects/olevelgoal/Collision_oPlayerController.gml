/// @description Insert description here
// You can write your code in this editor

room_goto(levelDestination);

global.campaignMapLocationX = mapReturnX;
global.campaignMapLocationY = mapReturnY;

ds_list_add(global.completedLevels, levelName)