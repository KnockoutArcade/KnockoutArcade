/// @description Insert description here
// You can write your code in this editor

if p1 != noone && p2 != noone && p1.state != eState.HITSTOP && p2.state != eState.HITSTOP{
	x = (p1.x + p2.x) * .5;
}
if room != rStageArcade {
	camera_set_view_pos(view_camera[0], clamp(x-(camWidth*.5), 0, camWidth), 0);
	x = clamp(x, camWidth*.5, camWidth*1.5);
}
else {
	camera_set_view_pos(view_camera[0], clamp(x-(camWidth*.5), 0, 0), 0);
	x = camWidth*.5;
}