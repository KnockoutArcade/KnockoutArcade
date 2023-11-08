/// @description Insert description here
// You can write your code in this editor

if (!global.game_paused && !global.gameHalt)
{
	// Increase millisecond count according to framerate
	levelTimerMilliseconds += (1000 / game_get_speed(gamespeed_fps));

	// Round milliseconds to the nearest Hundredth
	levelTimerMilliseconds = floor(levelTimerMilliseconds * 100) / 100;

	// if 1000 milliseconds have passed, increase seconds by 1
	if (levelTimerMilliseconds >= 1000)
	{
		levelTimerSeconds += 1;
		levelTimerMilliseconds -= 1000;
	}

	// if 60 seconds have passed, increase minutes by 1
	if (levelTimerSeconds >= 60)
	{
		levelTimerSeconds -= 60;
		levelTimerMinutes += 1;
	}
	
	#region Process Milliseconds
	// Convert time to string to make it easier to deal with (also removing decimal since we aren't displaying that)
	stringMilliseconds = string(floor(levelTimerMilliseconds));

	// if the string length is less than 3 digits, add zeros to the front to make it 3 digits
	if (string_length(stringMilliseconds) == 1)
	{
		stringMilliseconds = string("00" + stringMilliseconds);
	}
	else if (string_length(stringMilliseconds) == 2)
	{
		stringMilliseconds = string("0" + stringMilliseconds);
	}
	else if (string_length(stringMilliseconds) < 1 || string_length(stringMilliseconds) > 3)
	{
		stringMilliseconds = "000"; // Edge case if the number isn't valid
	}
	#endregion
	
	
	#region Process Seconds
	// Convert time to string to make it easier to deal with
	stringSeconds = string(levelTimerSeconds);

	// if the string length is less than 3 digits, add zeros to the front to make it 3 digits
	if (string_length(stringSeconds) == 1)
	{
		stringSeconds = string("0" + stringSeconds);
	}
	else if (string_length(stringSeconds) < 1 || string_length(stringSeconds) > 2)
	{
		stringSeconds = "00"; // Edge case if the number isn't valid
	}
	#endregion
	
	
	#region Process Minutes
	// Convert time to string to make it easier to deal with
	stringMinutes = string(levelTimerMinutes);

	// if the string length is less than 3 digits, add zeros to the front to make it 3 digits
	if (string_length(stringMinutes) == 1)
	{
		stringMinutes = string("0" + stringMinutes);
	}
	else if (string_length(stringMinutes) < 1 || string_length(stringMinutes) > 2)
	{
		stringMinutes = "00"; // Edge case if the number isn't valid
	}
	#endregion
}

// Render Milliseconds
draw_sprite(sSingleplayerHudNumbers, string_char_at(stringMilliseconds, 1), (global.camObj.x-80) + ui_xOffset + millisecondsPositionOffset + (digitMargin * 0), y);
draw_sprite(sSingleplayerHudNumbers, string_char_at(stringMilliseconds, 2), (global.camObj.x-80) + ui_xOffset + millisecondsPositionOffset + (digitMargin * 1), y);
draw_sprite(sSingleplayerHudNumbers, string_char_at(stringMilliseconds, 3), (global.camObj.x-80) + ui_xOffset + millisecondsPositionOffset + (digitMargin * 2), y);

// Render Decimal 2
draw_sprite(sSingleplayerHudNumbers, 10, (global.camObj.x-80) + ui_xOffset + decimal2Position, y);

// Render Seconds
draw_sprite(sSingleplayerHudNumbers, string_char_at(stringSeconds, 1), (global.camObj.x-80) + ui_xOffset + secondsPositionOffset + (digitMargin * 0), y);
draw_sprite(sSingleplayerHudNumbers, string_char_at(stringSeconds, 2), (global.camObj.x-80) + ui_xOffset + secondsPositionOffset + (digitMargin * 1), y);

// Render Decimal 1 (colon)
draw_sprite(sSingleplayerHudNumbers, 11, (global.camObj.x-80) + ui_xOffset + decimal1Position, y);

// Render Minutes
draw_sprite(sSingleplayerHudNumbers, string_char_at(stringMinutes, 1), (global.camObj.x-80) + ui_xOffset + minutesPositionOffset + (digitMargin * 0), y);
draw_sprite(sSingleplayerHudNumbers, string_char_at(stringMinutes, 2), (global.camObj.x-80) + ui_xOffset + minutesPositionOffset + (digitMargin * 1), y);

