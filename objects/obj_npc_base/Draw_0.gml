if can_change_direction && instance_exists(player)
	dir = array_find_closest(point_direction(x,y,player.x,player.y),allowed_dirs)

if (path_index != -1)
{
	if (path_speed > 0) 
	{
	    var _look_ahead = min(path_position + (4.2 / path_get_length(path_index)), 1);
	    dir = angle_lerp(dir,point_direction(x, y,  path_get_x(path_index, _look_ahead), path_get_y(path_index, _look_ahead)),0.25)
		alarm[0] = 5
		if sprite_exists(sprite)
		img = (img + sprite_get_speed_ammount(sprite)) % sprite_get_number(sprite)
	}
	else if look_down_when_stopped
    dir = angle_lerp(dir, DOWN, 0.1)
	
	dir = (dir + 360) % 360; // rotation
	
	if prev_path_speed != path_speed 
	{
		if path_speed > 0 
		img ++
		else alarm[0] = 5
	}
	
	prev_path_speed = path_speed
}
	
if (move != -1)
{
	x += lengthdir_x(movespeed,move)
	y += lengthdir_y(movespeed,move)
}
	
	
if (animate_walking)
{
	var is_moving = (x != xprevious || y != yprevious)
	if is_moving
	{
	    dir = angle_lerp(dir,point_direction(xprevious, yprevious, x,y,),0.25)
		if sprite_exists(sprite)
			img = (img + sprite_get_speed_ammount(sprite)) % sprite_get_number(sprite)
	}
	else if look_down_when_stopped
    dir = angle_lerp(dir, DOWN, 0.1)
	
			dir = (dir + 360) % 360; // rotation

	
	if is_moving != prev_was_moving
	{
		if is_moving > 0 
		img ++
		else alarm[0] = 5
	}
	
	prev_was_moving = is_moving
	
}
else if dialogue_talk
{
	if instance_exists(my_dialogue) && audio_is_playing(my_dialogue.sound_playing)
	img += sprite_get_speed_ammount(sprite)
	else 
	img = 0
}
else if image_speed > 0
img += sprite_get_speed_ammount(sprite) * image_speed


var _dir = front_direction_to_string(get_current_direction(dir))
var sprite_test = sprite_name + _dir 

if prev_sprite_test != sprite_test
{
	var try_sprite = asset_get_index(string_replace_markup_ext(sprite_name,
	{
		dir: _dir,
		movement: movement,
	}))
	
	if sprite_exists(try_sprite)
	{
		sprite = try_sprite
		if can_collide && mask_index == -1
			mask_index = sprite
	}
}

prev_sprite_test = sprite_test

if is_undefined(sprite) exit;
var interact = interact_key_press
if interact && global.can_move && can_open_textbox()
{
	if player_is_facing_point(x,y ,,40)
	{
		direction_before_dialogue = dir
		interact = false
		if var_id_exists("dialogue") && string_length(dialogue)
		{
			dir_before_dialogue = dir
			
			var _var_struct = variable_clone(dialogue_var_struct)
			
			if !variable_struct_exists(_var_struct,"event_destroy")
			_var_struct.event_destroy = dialogue_event_destroy
			
			_var_struct.event_destroy_parameters = id

			my_dialogue = create_textbox(dialogue,_var_struct)
			dir = point_direction(x,y,player.x,player.y)
			
			if is_string(dialogue_next)
			dialogue = dialogue_next 
			else if is_array(dialogue_next) && array_length(dialogue_next)
			{
				dialogue = dialogue_next[0]
				array_delete(dialogue_next,0,1)
			}
		}
	}
}

draw_sprite_ext_optional(sprite,img)



if variable_self_exists("event_draw") event_draw()

