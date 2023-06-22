// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function StructCopy(ref)
{
	var new_struct = {}; 
	var struct_names = variable_struct_get_names(ref);
			
	for (var i = 0; i < array_length(struct_names); i++)
	{
	    var _name = struct_names[i];
		
	    if (is_struct( ref[$ _name] ) ) 
		{
	        new_struct[$ _name] = StructCopy(ref[$ _name]);
	    } 
		else 
		{
	        new_struct[$ _name] = ref[$ _name];
	    }
	}
	return new_struct;
}
		
		