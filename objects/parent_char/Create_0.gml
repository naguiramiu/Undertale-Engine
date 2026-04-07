sprite_name = "spr_{char_name}_{move_state}_{dir}"
was_moving = false
frames_to_stop = -1
prev_changed = ""
get_current_direction = function(vec)
{
	var dir = round(vec / 90) * 90;
	return (dir + 360) % 360;
}

compensate_for_diagonal_speed = function(spd,run_key)
{
	var dir = round(front_vector / 45) * 45;
	dir = (dir + 360) % 360;
	if (dir % 45 == 0 && dir % 90 != 0) 
	return spd / 0.7
	return spd
}

set_depth = function(vec = front_vector)
{
	depth = ((-y - 10) + (vec < 180 ? -number_in_party : number_in_party))
	return depth 
}

player_animate = function()
{
	var is_moving = (x != xprevious || y != yprevious)
	
	if is_moving
	{
		current_frame += frame_animation_speed
		
		if object_index == obj_char_follower 
			set_depth()
	}
	
	if (was_moving != is_moving) 
	{
		if is_moving // if started moving, set animation to walk and reset the timer to stop walking
		{
			current_frame ++ // frame 0 is standing, 1 is walking
			frames_to_stop = -1 // not stopping	
		}
		else 
		{
			frames_to_stop = 10 // if stopped moving, timer to stop walking
			
			if (object_index == player) && global.can_move
			{
			    front_vector = angle_lerp(front_vector, point_direction(0, 0, prev_xspd, prev_yspd), 0.75);
				front_vector = (front_vector + 360) % 360; // rotation
			}
		}
	}
	
	was_moving = is_moving
	prev_xspd = xspd  
	prev_yspd = yspd
	
	if frames_to_stop > 0 frames_to_stop --
	if frames_to_stop == 0
		{
			frames_to_stop = -1
			current_frame = 0
		}
}

update_sprite = function()
{
	sprite = asset_get_index(
		string_replace_markup_ext(sprite_name,
		{
			char_name: string_lower(char_name),
			move_state: "walk",
			dir: front_direction_to_string(get_current_direction(front_vector))
		})
	)
	
}


sprite = undefined
frame_animation_speed = player.frame_animation_speed