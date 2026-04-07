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

