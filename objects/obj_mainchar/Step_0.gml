
var down_key = down_key_hold
var up_key = up_key_hold
var left_key = left_key_hold
var right_key = right_key_hold
var run_key = ENABLE_RUNNING && (global.settings.auto_run ? !back_key_hold : back_key_hold)

if run_key
	current_run_speed = lerp(current_run_speed,max_run_speed,0.2)	
else current_run_speed = lerp(current_run_speed,0,0.8)	

#region X and Y movement
xspd = 0;
yspd = 0;

if global.can_move
{
	if right_key && left_key
	{
		if xdirection 
		{
			xspd = 1
			if left_key_press 
				xdirection = !xdirection;
		}
		else
		{
			xspd = -1
			if right_key_press 
				xdirection = !xdirection;
		}
	}
	else
		xspd = (right_key - left_key) * 1
		
	if down_key && up_key
	{
		if ydirection 
		{
			yspd = 1
			if up_key_press 
				ydirection = !ydirection;
		}
		else
		{
			yspd = -1
			if down_key_press
				ydirection = !ydirection;
		}
	}
	else
		yspd = (down_key - up_key) * 1
	
	if USING_CONTROLLER
	{
		var haxis = gamepad_get_axis_value_fixed("haxis")
		if haxis != 0 xspd = haxis
		var vaxis = gamepad_get_axis_value_fixed("vaxis")
		if vaxis != 0 yspd = vaxis
	}
}
#endregion	

if (ENABLE_FRISKDANCE) && (up_key && down_key)
{	
	if place_meeting(x,y - main_speed, obj_col_parent)	
	{
        front_vector = (front_vector == UP) ? DOWN : UP
		yspd = 0
		current_frame += frame_animation_speed
	}
}


#region ROTATION AND WALL COLLISIOM - COMPLEX CODE
if (abs(xspd) > 0 || abs(yspd) > 0)
{
	var dist = prev_meetingwall ? 1 : 0.35 // if you are touching a wall let you move around faster to
	// if you dont like the player rotating when turning change the dist to always 1
	
	var target_dir = point_direction(0, 0, xspd, yspd);

	// prev walking into walls
	front_vector = angle_lerp(front_vector, target_dir, dist);
	front_vector = (front_vector + 360) % 360; // rotation
	
	var walking_speed = main_speed

	walking_speed = compensate_for_diagonal_speed(walking_speed,run_key)
	if !prev_meetingwall
	walking_speed += current_run_speed
	// IF EVER WANT TO ADD SPEED MODIFIERS ADD HERE
	var lenx = lengthdir_x(walking_speed, target_dir)
	var leny = lengthdir_y(walking_speed, target_dir)
	
	#region apply speed and edge detection - purely wall colisions
	
	// change this to 1 if you dont want the player to get slower when hugging walls
	var speed_modifier_hugging_wall = run_key ? 0.8 : 1
	var meetingwall = false
	var movingthisinstance = ((right_key + left_key + up_key + down_key) == 1)
	var max_steps = 12
	var steps = max_steps
	var current = 1 
	while place_meeting(x + lenx, y, obj_col_parent)
	{
		// hugging wall
		if current == 1 // first iteration
		{
			leny *= speed_modifier_hugging_wall
			// let player move away
			if yspd != 0 
				front_vector = ((yspd > 0) ? DOWN : UP) 
			meetingwall = true
		}
		//
		if movingthisinstance && !place_meeting(x + lenx, y + current, obj_col_parent)
		{
			y += current
			break;
		}
		
		// this current scans around up and down to see the nearest avaiable space
		if current > 0 current = -current 
			else 
		current = -current + 1
		
		if steps > 0 steps -- 
		else 
		{
			lenx = 0
			break;
		}
	}
	current = 1 
	steps = max_steps
	
	while place_meeting(x, y + leny, obj_col_parent)
	{
		// hugging wall
		if current == 1 
		{
			lenx *= speed_modifier_hugging_wall
			if xspd != 0 
				front_vector = ((xspd > 0) ? RIGHT : LEFT) 
			meetingwall = true
		}
		
		if movingthisinstance && !place_meeting(x + current, y + leny, obj_col_parent)
		{
			x += current
			break;
		}
		
		// this current scans around up and down to see the nearest avaiable space
		if current > 0 current = -current 
			else 
		current = -current + 1
		
		if steps > 0 steps -- 
		else 
		{
			leny = 0
			break;
		}
	}

	prev_meetingwall = meetingwall;
	
	// diagonal stuff
	if (place_meeting(x + lenx, y + leny, obj_col_parent)) 
	{
	    if (!place_meeting(x + lenx, y, obj_col_parent))
	        leny = 0;
	    else if (!place_meeting(x, y + leny, obj_col_parent))
	        lenx = 0;
	}
	
	#endregion
	x += lenx;
	y += leny;
}

set_depth()
#endregion

if round_coordinates 
{
	y = round(y) 
	x = round(x) 	
	//x = clamp(x,0,room_width)
	//y = clamp(y,0,room_height)
}

player_animate()
prev_xspd = xspd  
prev_yspd = yspd


if (array_length(global.party_instances) != 1 && ((x != xprevious || y != yprevious))) // update followers
	with obj_char_follower
	      event_user(0)

with obj_camera set_camera_position();

