depth = UI_DEPTH
follow_char = true;
camera_locked_to_room_dimensions = true;
shake_duration = -1;
camera_x_offset = 0;
camera_y_offset = 0;
shake_strenght = 0;
force_can_update_camera = false;
prev_shakeduration = shake_duration;
if !instance_exists(obj_border_controller) instance_create(obj_border_controller)

set_camera_position = function(can_update = false)
{
	if follow_char 
	{
		var camwidth = 320
		var camheight = 240
		if instance_exists(player)
		{
			var player_x = ((player.x) - camwidth / 2)
			var player_y = ((player.y + -20) - camheight / 2)
			if camera_locked_to_room_dimensions
			{
				player_x = clamp(player_x,0,room_width - camwidth)
				player_y = clamp(player_y,0,room_height - camheight)
			}
			x = player_x
			y = player_y
		}
	}

	
	#region camera shaking
	if shake_duration == -1 
	{
		shake_duration = 0
		can_update = true 
	}
	if shake_duration > 0
	{
		shake_strenght = max(0,shake_strenght - 0.25)
		camera_x_offset = choose(-shake_strenght,shake_strenght)
		camera_y_offset = choose(-shake_strenght,shake_strenght)
		shake_duration -= 1
		can_update = true 
		if shake_duration == 0 shake_duration = -1
	}
	else 
	{
		camera_x_offset = 0	
		camera_y_offset = 0
	}
	#endregion
	
	
	if (xprevious != x || yprevious != y) can_update = true 
	if force_can_update_camera can_update = true

	if can_update
	camera_set_view_pos(view_camera[0],x + camera_x_offset,y + camera_y_offset)
	prev_shakeduration = shake_duration
}
screen_darken = 0
