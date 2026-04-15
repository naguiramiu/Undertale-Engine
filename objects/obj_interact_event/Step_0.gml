if interact_key_press
{
	if instance_exists(player) && 
	array_contains(allowed_dirs,get_current_direction(player.front_vector)) 
	&& global.can_move
	{
		if can_open_textbox() && place_meeting(x,y,player)
		{
			if event_interact != -1
				function_call(event_interact,customevent_get_params("interact"))
		}
	}
}