/// @description Insert description here
// You can write your code in this editor

visible = global.toggleHitboxVisibility;

if place_meeting(x, y, oWall) {
	// While we are touching a wall, move us back 1 pixel at a time. One we are no longer touching the wall,
	// we will know how far away we need to move
	while place_meeting(x, y, oWall) {
		x = x - sign(image_xscale);
		distanceFromWall++;
	}
	
	// Figure out how much time we have to move by subtracting the first active frame of the move by our
	// owner's animTimer value.
	var timeToMove = throwToCheck.attackProperty.start[0] - owner.animTimer;
	
	// Velocity is distance/time. We also need to move backwards
	owner.hsp = distanceFromWall/timeToMove * (owner.image_xscale * -sign(throwToCheck.opponentPositionData.distanceFromWall));
}

instance_destroy();