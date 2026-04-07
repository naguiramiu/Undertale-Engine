var camera_x = camera_get_view_x(view_camera[view_current])
var camera_y = camera_get_view_y(view_camera[view_current])

if (!sprite_animated && !surface_exists(surf)) || (sprite_animated)
{
	if !surface_exists(surf) surf = surface_create(width,height)
		
	surface_set_target(surf)
	draw_clear_alpha(c_black,0)
	
	with target 
	{	
		x -= camera_x
		y -= camera_y
		visible = true
		event_perform(ev_draw,0)
		x += camera_x
		y += camera_y
		visible = false
	}
	surface_reset_target()
	buffer_get_surface(buffer, surf, 0)
	
}
var crow = current_row - 1

if !sprite_animated
    draw_surface_part(surf, 0, crow, width, height - crow, camera_x, camera_y + crow)
else
if instance_exists(target)
{
	with target
	{
		shader_set(sh_y_clip);
		shader_set_u_simple("u_y_limit",camera_y + crow)
		visible = true 
		event_perform(ev_draw,0)
		visible = false 
		shader_reset();
	}
}
if current_row < height
{
    var rows_processed_this_frame = 0
    var max_rows_per_frame = 4
    var found_pixel_in_a_row = false
    while (rows_processed_this_frame < max_rows_per_frame && current_row < height)
    {
        var row_has_pixel = false
        for (var xx = 0; xx < width; xx++) 
            if (buffer_peek(buffer, ((xx + (current_row * width)) * 4) + 3, buffer_u8) >= 127) 
            {
                row_has_pixel = true
                found_pixel_in_a_row = true
                break;
            }
        if row_has_pixel
        {
            for (var xx = 0; xx < width; xx++) 
            {
                var pos = (xx + (current_row * width)) * 4
                if (buffer_peek(buffer, pos + 3, buffer_u8) > 0) 
                {
					// buffer peek returns a 255 value for the colors
                    part_type_color1(p_pix, make_colour_rgb(
                        buffer_peek(buffer, pos, buffer_u8),  // r 
                        buffer_peek(buffer, pos + 1, buffer_u8), // g 
                        buffer_peek(buffer, pos + 2, buffer_u8) // b 
                    ))
                    part_particles_create( p_sys,camera_x + xx,camera_y + current_row, p_pix, 1)
                }
            }
            current_row++
            rows_processed_this_frame++
        }
        else 
        {
            current_row++
            rows_processed_this_frame += 0.2
        }
    }
}
else if alarm[0] == -1 alarm[0] = 40 // make sure this alarm value matches the particles max life time