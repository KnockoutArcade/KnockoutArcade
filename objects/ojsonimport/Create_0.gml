global.numberOfCharacters = 0;

var i = 0;
var filePath = working_directory + "/characterdata/";
var fileName = file_find_first(filePath + "*.json", fa_directory);

while(fileName != "")
{
	var importedCharacter;
	var fullPath = filePath + fileName;
	
	if (file_exists(fullPath))
	{
		var json = "";
	
		var file = file_text_open_read(fullPath);
	
		while(!file_text_eof(file))
		{
			json += file_text_readln(file);
		}
	
		file_text_close(file);
	
		importedCharacter = json_parse(json);
	}
	
	global.characterData[i] = SetupCharacter(importedCharacter);
	global.numberOfCharacters++;
	fileName = file_find_next();
	i++;
}

file_find_close();

// This is to ensure that the code for the Json object runs before the code for the global var
instance_create_layer(0, 0, "StartText", oGlobalVars);

show_debug_message(global.characterData[1].StandLight.AttackProperty);