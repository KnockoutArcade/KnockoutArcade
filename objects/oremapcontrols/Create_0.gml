image_speed = 0
menuCooldown = 10;
showMessage = false;

playerSelectedText = "Player 1";

playerControlsToChange = global.player1Controls; // This holds a reference to the set of controls we want to change
playerControlsType = global.player1ControllerType; // This holds a reference to what kind of controller the player is using 

playerID = 1; // Which player is controlling this menu? 1 for p1, 2 for p2

selectedOption = 0; // The selected menu option

// Options are laid out in a 2x8 grid, with -1 being the selected player option, and the last row
// being offscreen and not used (this makes the wrap logic work correctly)
// ==========================
// 0            | 8
// 1            | 9
// 2            | 10
// 3            | 11
// 4            | 12
// 5            | 13
// 6            | 14
// 7            | 15
// ===========================
// up: -1, down: +1, left +8, right -8