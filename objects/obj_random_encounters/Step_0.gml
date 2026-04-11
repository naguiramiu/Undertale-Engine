if (instance_exists(player) && global.can_move)
{
	var can_spawn = true  
	
	with (player) 
		if (point_direction(x,y,xprevious,yprevious) < 2)
			can_spawn = false
	
	if (can_spawn) && (irandom(1000) < encounter_chance_percent)
	{
		if !is_array(encounters)
		{
			start_encounter(encounters)
			if remove_encounter_after
				encounters = []
		}
		else if array_length(encounters)
		{
			var choice = irandom(array_length(encounters) - 1)
		
			start_encounter(encounters[choice])
		
			if remove_encounter_after
				array_delete(encounters,choice,1)
		}
	}
}
