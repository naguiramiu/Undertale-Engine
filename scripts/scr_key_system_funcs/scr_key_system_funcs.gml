function scr_default_keys()
{
	return 
	{
		key_up: "W",
		key_left: "A",
		key_down: "S",
		key_right: "D",
		key_confirm: "Z",
		key_back: "X",
		key_menu: "C"
	}
}

function keyboard_check_holdpress(key,spd = 2,timer = 12,diminify = false)
{
	var key_name = "__check_for_holdpress_" + string(key)
	if !variable_self_exists(key_name)
		variable_self_set(key_name,0)
	
	if key_check(keyboard_check_pressed,key)
		{
			variable_self_set(key_name,0)
			return true
		}
		else if key_check(keyboard_check,key)
		{
			var key_timer = variable_self_get(key_name) + 1
			variable_self_set(key_name,key_timer)
			if key_timer > 20 && diminify
				spd *= 0.75
			if (key_timer >= timer) && ((key_timer - timer) % spd == 0) 
			return true
		}
		else 
			variable_self_set(key_name,0)
	return false 
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


function scr_setspecifickey(var_name,to)
{
	var keystruct = global.settings.keys
	var all_keys = struct_get_names(keystruct)
	var this_key = global.settings.keys[$var_name]
	var sametime = 0
	for (var i = 0; i < array_length(all_keys); i++)
		{
			if all_keys[i] != var_name && (global.settings.keys[$all_keys[i]] == to)
			{
				global.settings.keys[$all_keys[i]] = this_key;
				sametime ++;
			}
		}
	global.settings.keys[$var_name] = to;
	
	if sametime > 1 // fallback
	{
		global.settings.keys = scr_default_keys()
		exit; 
	}
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
