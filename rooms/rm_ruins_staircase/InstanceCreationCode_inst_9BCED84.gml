if global.flags.ruins.toriel_walked_0
{
	instance_destroy()
	exit;
}
path_start(pth_ruins_toriel_staircaseroom,2,path_action_stop,true)
target_point = 1
moving_to_point = false
event_draw = function()
{
	if player.y < 260
	global.flags.ruins.toriel_walked_0 = true

	if path_position > 0.93
	{
		if image_alpha > 0 image_alpha -= 0.5 
		else 
			instance_destroy()
	}
	
	var _num_points = path_get_number(pth_ruins_toriel_staircaseroom)
	var tx = path_get_point_x(pth_ruins_toriel_staircaseroom, target_point)
	var ty = path_get_point_y(pth_ruins_toriel_staircaseroom, target_point)
	if (!moving_to_point) 
	{
	    if (player.y < y + 60) 
	        moving_to_point = true;
	    path_speed = 0
	}
	if (moving_to_point) 
	{
	    path_speed = 3
	    if (point_distance(x, y, tx, ty) < 4) 
		{
	        x = tx
	        y = ty
	        path_speed = 0
	        moving_to_point = false

	        if (target_point < _num_points - 1)
	            target_point++
	    }
	}
}