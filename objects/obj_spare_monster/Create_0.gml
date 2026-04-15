var spare_surf = surface_create(320,240)
with target_instance 
{
	var prevx = x 
	var prevy = y
	if other.vapor 
	 {
		if !audio_is_playing(snd_vaporized)
		play_sound(snd_vaporized)
		var spr_w = sprite_width / 4;
		var spr_h = sprite_height / 4;
		for (var n = 0; n < 14; n++)
		{
		    var _qx = x + random_range(-spr_w, spr_w);
		    var _qy = y + random_range(-spr_h, spr_h);
    
		    with instance_create_depth(_qx, _qy, depth - 10, obj_dustcloud)
		    {
		        direction = point_direction(other.x, other.y, x, y);
		        if (x == other.x && y == other.y) direction = random(360);
		        speed = 4;
		        friction = 0.4;
		    }
		}
	 }
	can_be_selected = false
	spared = true
	surface_set_target(spare_surf)
	draw_clear_alpha(c_black,0)
	x -= cam_x 
	y -= cam_y
	
	event_perform(ev_draw,ev_draw_normal)
	surface_reset_target()
	x = prevx
	y = prevy
	visible = false
}

my_sprite = sprite_create_from_surface(spare_surf,0,0,320,240,0,0,0,0)

surface_free(spare_surf)

lerp_var_ext(id,"image_alpha",0.1,image_alpha,0.5)
