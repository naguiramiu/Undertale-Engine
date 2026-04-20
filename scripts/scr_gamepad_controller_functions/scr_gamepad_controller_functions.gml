function scr_check_for_gamepad_controller()
{
	if async_load[?"event_type"] == "gamepad discovered"
	{
		global.controller = async_load[?"pad_index"]
		gamepad_set_axis_deadzone(global.controller, 0.4);
		gamepad_set_colour(global.controller,c_red) // this literally does not work bceause its only if youre playing on a playstation (not just with a ps controller) 
	}
	else if async_load[?"event_type"] == "gamepad lost"
	global.controller = -1

	if variable_global_exists("controller") && USING_CONTROLLER
		scr_set_c_axis()
} 

function scr_gamepad_keys_initialize()
{
	global.controller = -1
	global.controller_axis = 
	{
		axis_l: {},
		axis_r: {},
	}
	with global.controller_axis
	{
		with axis_l 
			scr_get_controller_axis(0,0,false)
		with axis_r 
			scr_get_controller_axis(0,0,false)
	}
} 
function gamepad_get_axis_value_fixed(axis = "haxis")
{
	with global.controller_axis
	{
		var prev_axis = "prev_" + axis
		var haxis = (abs(axis_l[$axis]) > abs(axis_r[$axis])) ? axis_l[$axis] : axis_r[$axis];
		var prev_h = (abs(axis_l[$prev_axis]) > abs(axis_r[$prev_axis])) ? axis_l[$prev_axis] : axis_r[$prev_axis];
		if (sign(haxis) != sign(prev_h) && abs(prev_h) > 0.5) haxis = 0;
		return (abs(haxis) > 0.4) ? haxis : 0;
	}
}

function scr_get_controller_axis(_haxis,_vaxis,_get = true)
{	
	prev_haxis1 = (_get ? prev_haxis : 0)
	prev_vaxis1 = (_get ? prev_vaxis : 0)
	prev_haxis = (_get ? haxis : 0)
	prev_vaxis = (_get ? vaxis : 0)
	haxis = (_get ?  gamepad_axis_value(global.controller, _haxis) : 0)
	vaxis = (_get ?  gamepad_axis_value(global.controller, _vaxis) : 0)
}

function scr_keyboardfunctogamepad(check_func)
{
	switch check_func
	{
		case keyboard_check: return gamepad_button_check;
		case keyboard_check_pressed: return gamepad_button_check_pressed;
	}	
}

function scr_set_c_axis()
{
	with global.controller_axis
	{
		with axis_l
			scr_get_controller_axis(gp_axislh,gp_axislv)
		with axis_r
			scr_get_controller_axis(gp_axisrh,gp_axisrv)
	}
}

function scr_gamepad_key_inputs(key,gamepad_func,c)
{
	if gamepad_func == gamepad_button_check_pressed && key >= vk_left && key <= vk_down
			if joystick_just_pressed(key) return true 
	
	// Here we map certain keys to controller keys
	// hover over the names like on gp_face3 to know what they map to
	switch key 
	{	
		case vk_escape: if gamepad_func(c,gp_start) return true; break;
		case vk_control: if gamepad_func(c,gp_face4) return true; break;
		case vk_backspace: if gamepad_func(c,gp_face3) || gamepad_func(c,gp_shoulderr) || gamepad_func(c,gp_face2) return true; break;
		case vk_enter: if gamepad_func(c,gp_face1) || gamepad_func(c,gp_shoulderrb) return true; break;
		case vk_up: if gamepad_func(c,gp_padu) return true; break;
		case vk_down: if gamepad_func(c,gp_padd) return true; break;
		case vk_left: if gamepad_func(c,gp_padl) return true; break;
		case vk_right: if gamepad_func(c,gp_padr) return true; break;
	}
}

function joystick_just_pressed(key)
{
    var thresh = 0.5;
    var travel_limit = 1.5; 
	var axis = [global.controller_axis.axis_r,global.controller_axis.axis_l]
	for (var i = 0; i < 2; i++)
    with axis[i]
    {
        /*
			treat prev as the current frame
			treat prev1 as the previous frame
			treat the right now as the future frame
			if moved past thresh now (prev) and wasnt there before (prev1),
            and its still held in the "future" (actual vaxis)
        */
        switch (key)
        {
            case vk_up:    
                if (prev_vaxis <= -thresh && prev_vaxis1 > -thresh) && (vaxis <= -thresh) return true break;
            case vk_down:  
                if (prev_vaxis >= thresh && prev_vaxis1 < thresh) && (vaxis >= thresh)  return true break;
            case vk_left:  
               if (prev_haxis <= -thresh && prev_haxis1 > -thresh) && (haxis <= -thresh)  return true break;
            case vk_right: 
                if (prev_haxis >= thresh && prev_haxis1 < thresh) && (haxis >= thresh)  return true break;
        }
    }
    return false;
}