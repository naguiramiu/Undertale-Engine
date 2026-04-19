/// @description Interact struct

get_struct_ext = function(m = 0)
{
	var fu = (prev_menu[0].from == "global" ? variable_global_get : variable_self_get)
	var vars = string_split(prev_menu[0].where_im_at,".",true)
	var a = fu(array_burst(vars),prev_menu[0].from)
	while array_length(vars)
	a = a[$array_burst(vars)]
	
	for (var i = 1; i < array_length(prev_menu) - m; i++)
	{
		if is_string(prev_menu[i].where_im_at)
		{
			var vars = string_split(prev_menu[i].where_im_at,".",true)
			a = a[$array_burst(vars)]
			while array_length(vars)
			a = a[$array_burst(vars)]
		}
		else a = a[prev_menu[i].where_im_at]
	}
	return a
}


interact_struct_menu = function(this_setting,var_name,is_from_array)
{
	var a = get_struct_ext()
	var f = global.settings.fullscreen
	
	if right_interact
	{
		if show_question("Remove value " + var_name + "?")
		{
			if is_from_array
				array_delete(a,var_name,1)
			else
			variable_struct_remove(a,var_name)
		}
	}
	else if mouse_check_button_pressed(mb_middle)
	{
		var _var = get_variable(var_name,json_stringify(this_setting,true))
		if _var != -1
			struct_replace_unique(a,_var)
	}
	else
	switch typeof(this_setting)
	{
		case "bool": case "boolean":
			a[$var_name] = !a[$var_name]
		break;
		case "struct":
		case "array":
			current_menu.where_im_at = var_name
			do_later(1,function(this_setting,a,var_name,is_from_array)
			{
				var func = current_menu.func
				array_push(obj_devmenu_debug.prev_menu, 
				{
					where_im_at: var_name,
					menu_from_array: current_menu.menu_from_array
				})
				with obj_devmenu_debug.current_menu
				{
					title = (is_from_array ? obj_devmenu_debug.array_val_name(this_setting,var_name) : string_prettify(var_name))
					settings = (is_from_array ? a[var_name] :  variable_self_get(var_name,a))
					menu_from_array = (typeof(this_setting) == "array")
				}
			},[this_setting,a,var_name,is_from_array])
		break;
		default:
		
		window_set_fullscreen(false)
		with obj_maincontroller
			event_perform(ev_alarm,0)
						
		do_later(f,function(this_setting,a,var_name,is_from_array)
		{
			var fu = (typeof(this_setting) == "string" ? get_string : get_integer)
			obj_devmenu_debug.interact = false
			window_set_cursor(cr_default)
			var prev = this_setting
			var get = fu("Insert the value",prev)
			if !(is_undefined(get) || (string_length(get) == 0))
			if is_from_array
				a[var_name] = get
			else
				a[$var_name] = get
		},[this_setting,a,var_name,is_from_array],id)
		break;
	}
	if variable_instance_exists(current_menu,"every_func") && current_menu.every_func != -1
	current_menu.every_func()
}