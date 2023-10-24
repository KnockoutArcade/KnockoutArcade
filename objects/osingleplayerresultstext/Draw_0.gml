/// @description Insert description here
// You can write your code in this editor

// Render text to the screen
while (currentCharacter <= string_length(textToRender))
{
	// If it's a number, draw that number
	if (string_char_at(textToRender, currentCharacter) != ":" && string_char_at(textToRender, currentCharacter) != "." && string_char_at(textToRender, currentCharacter) != "$")
	{
		draw_sprite(sLevelCompleteNumbers, string_char_at(textToRender, currentCharacter), x + ((currentCharacter - 1) * distanceBetweenLetters), y);
	}
	else if (string_char_at(textToRender, currentCharacter) == ":") // draw ":"
	{
		draw_sprite(sLevelCompleteNumbers, 11, x + ((currentCharacter - 1) * distanceBetweenLetters), y);
	}
	else if (string_char_at(textToRender, currentCharacter) == ".") // draw "."
	{
		draw_sprite(sLevelCompleteNumbers, 12, x + ((currentCharacter - 1) * distanceBetweenLetters), y);
	}
	else if (string_char_at(textToRender, currentCharacter) == "$") // draw "$"
	{
		draw_sprite(sLevelCompleteNumbers, 10, x + ((currentCharacter - 1) * distanceBetweenLetters), y);
	}
	
	currentCharacter++;
}

// reset current character
currentCharacter = 1;


