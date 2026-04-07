if interact_key_press
{
	if instance_exists(player) && 
	array_contains(allowed_dirs,player.get_current_direction(player.front_vector)) 
	&& global.can_move
	{
		if can_open_textbox() && place_meeting(x,y,player)
		{
				alarm_set_instant(0,time_to_appear)	
				if played_sound != noone play_sound(played_sound)
				
				if event_interact != -1 function_call(event_interact)
				global.can_move = false
		}
	}
}