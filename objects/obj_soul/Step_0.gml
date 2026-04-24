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
	    var target_dir = point_direction(0, 0, xspd, yspd);
	    var walking_speed = compensate_for_diagonal_speed(target_dir, main_speed, run_key);
		if (run_key) walking_speed /= 2

		#region calculate if inside the box
	    var 
			tx = x + lengthdir_x(walking_speed, target_dir),
		    ty = y + lengthdir_y(walking_speed, target_dir),
		    box = obj_battlebox,
		    dx = tx - box.x,
		    dy = ty - box.y,
		    ang = -box.image_angle,
		    rot_x = dx * dcos (ang) + dy * dsin (ang),
		    rot_y = -dx * dsin (ang) + dy * dcos (ang),
		    p_half = 8,
		    bw =  (box.width / 2) - p_half,
		    bh =  (box.height / 2) - p_half
		
	    rot_x = clamp (rot_x, -bw, bw)
	    rot_y = clamp (rot_y, -bh, bh)
	    x = box.x +  (rot_x * dcos (-ang) + rot_y * dsin (-ang))
	    y = box.y +  (-rot_x * dsin (-ang) + rot_y * dcos (-ang))

	
		while check_outside_battlebox()
		{
		    var dir = point_direction(x, y, obj_battlebox.x, obj_battlebox.y)
			var too_much = 0
		    while check_outside_battlebox()
		    {
		        x += lengthdir_x(1, dir);
		        y += lengthdir_y(1, dir);
				too_much ++
				if (too_much > 1000)
					{
						x = obj_battlebox.x
						y = obj_battlebox.y
						break;	
					}
		    }

		}
		#endregion
	}
	
	if (can_hitbox)
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