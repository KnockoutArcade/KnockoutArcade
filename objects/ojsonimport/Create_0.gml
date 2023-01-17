/// @description Imports character data from JSON file

global.characterData = undefined;

var filePath = working_directory + "characters.json";

if (file_exists(filePath)) {
	var json = "";
	
	var file = file_text_open_read(filePath);
	
	while(!file_text_eof(file)) {
		json += file_text_readln(file);
	}
	
	file_text_close(file);
	
	global.characterData = json_parse(json);
}