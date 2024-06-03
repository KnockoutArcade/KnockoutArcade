// Character data
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

// Projectile data
global.numberOfProjectiles = 0;

i = 0;
filePath = working_directory + "/projectiledata/";
fileName = file_find_first(filePath + "*.json", fa_directory);

while(fileName != "")
{
	var importedProjectile;
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
	
		importedProjectile = json_parse(json);
	}
	
	global.projectileData[i] = SetupProjectile(importedProjectile);
	global.numberOfProjectiles++;
	fileName = file_find_next();
	i++;
}

file_find_close();

// This is to ensure that the code for the Json object runs before the code for the global var
instance_create_layer(0, 0, "StartText", oGlobalVars);

// Print debug info
show_debug_message(global.characterData[4].UpSpecial);
