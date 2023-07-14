if room != rCredits || rMainMenu || rOptions || rTitleScreen || rCharacterSelectScreen
{
	if keyboard_check_pressed(vk_escape)
		{
    paused  = !paused ;
	
		if paused_surf == -1
			{
        instance_deactivate_all(true);
		}
	
    if paused  == false
        {
        instance_activate_all();
        surface_free(paused_surf);
        paused_surf = -1;
        }
    }
	
if paused == true
    {
    alarm[0]++;
    alarm[1]++;
    }
}