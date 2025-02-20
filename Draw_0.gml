if paused  == true
{
if !surface_exists(paused_surf)
    {
    if paused_surf == -1
        {
        instance_deactivate_all(true);
        }
	// Takes the last buffer and prints a picture (Only background at the moment) 	
    paused_surf = surface_create(room_width, room_width); 
    surface_set_target(paused_surf);
    draw_surface(application_surface, 0, 0);
    surface_reset_target();
    }
	else
    {
    draw_surface(paused_surf, resW , resH);
    draw_set_alpha(0.5);
    draw_rectangle_colour(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_text_transformed_colour(global.camObj.x, resH / 2 - 15, "PAUSED", 1, 1, 0, c_red, c_red, c_red, c_red, 1);
    draw_set_halign(fa_left);
    }
}