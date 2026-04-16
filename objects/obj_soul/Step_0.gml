if can_move 
{
	var down_key = down_key_hold
	var up_key = up_key_hold
	var left_key = left_key_hold
	var right_key = right_key_hold
	var run_key = back_key_hold
	#region X and Y movement
	xspd = (right_key - left_key) * 1
	yspd = (down_key - up_key) * 1
		
	if USING_CONTROLLER
	{
		var haxis = gamepad_get_axis_value_fixed("haxis")
		if haxis != 0 xspd = haxis
		var vaxis = gamepad_get_axis_value_fixed("vaxis")
		if vaxis != 0 yspd = vaxis
	}	
		
	if (abs(xspd) > 0 || abs(yspd) > 0)
	{
		var dist = 1
	    var target_dir = point_direction(0, 0, xspd, yspd);
		var walking_speed = main_speed
		if run_key walking_speed /= 2
		var lenx = lengthdir_x(walking_speed, target_dir); 
		var leny = lengthdir_y(walking_speed, target_dir);
	
		#region apply speed and edge detection - purely wall colisions
		var speed_modifier_hugging_wall = 0.8
		var meetingwall = false
		var movingthisinstance = ((right_key + left_key + up_key + down_key) == 1)
		var steps = 12
		var max_steps = steps
		var current = 1 
		while place_meeting(x + lenx, y, obj_battlebox)
		{
			// hugging wall
			meetingwall = true
			if movingthisinstance && !place_meeting(x + lenx, y + current, obj_battlebox)
			{
				y += current
				break;
			}
			if current > 0 current = -current else current = -current + 1
		
			if max_steps > 0 max_steps -- 
			else 
			{
				lenx = 0
				break;
			}
		}
		current = 1 
		max_steps = steps
		while place_meeting(x, y + leny, obj_battlebox)
		{
			meetingwall = true
			if movingthisinstance && !place_meeting(x + current, y + leny, obj_battlebox)
			{
				x += current
				break;
			}
			if current > 0 current = -current else current = -current + 1
		
			if max_steps > 0 max_steps -- 
			else 
			{
				leny = 0
				break;
			}
		}
		x += lenx;
		y += leny;
	}
	#endregion
}

if (can_move && can_hitbox)
{
	if place_meeting(x,y,parent_bullet) 
		get_hit(instance_place(x,y,parent_bullet))
}	

if global.invframes_timer > 0 
{
	image_speed = 1
	global.invframes_timer --
}
else 
{
	image_speed = 0
	image_index = 0	
}