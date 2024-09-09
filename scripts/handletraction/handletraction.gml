// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function HandleTraction()
{
	// TEMPORARY!!!
	if (selectedCharacter.Name == "Beverly" && state == eState.RUN_BACKWARD)
	{
		traction = 0.1;
	}
	else if (selectedCharacter.Name == "Beverly")
	{
		traction = selectedCharacter.Traction;
	}
	// TEMPORARY!!
	
	if (abs(hsp) - traction >= 0)
	{
		hsp += traction * -sign(hsp);
	}
	else
	{
		hsp = 0;
	}
}