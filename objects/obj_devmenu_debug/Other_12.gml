/// @description Insert description here
change_var = function(f,this_setting)
{
	window_set_fullscreen(false)
	with obj_maincontroller
		event_perform(ev_alarm,0)
	do_later(f,function(this_setting)
	{
		obj_devmenu_debug.mouse_cursor = cr_default
		window_set_cursor(cr_default)
		if is_array(this_setting.from)
		{
			var prev = this_setting.from[this_setting.var_name]
			var a = get_variable_value("var",json_stringify(prev))
			if a != -1
			{
				this_setting.from[this_setting.var_name] = a[$"var"]
				var me = current_menu.settings[this_setting.var_name]
				current_menu.settings[this_setting.var_name] = create_struct_segment(array_val_name(a[$"var"],this_setting.var_name),a[$"var"],me.var_name,me.from,current_menu.func)
			}
		}
		else
		{
			var prev = variable_self_get(this_setting.var_name,this_setting.from) 
			var a = get_variable_value(this_setting.var_name,json_stringify(prev))
			if a != -1 
			{
				variable_struct_set(this_setting.from,this_setting.var_name,a[$this_setting.var_name])
				this_setting = create_struct_segment(this_setting.title,variable_self_get(this_setting.var_name,this_setting.from),this_setting.var_name,this_setting.from,current_menu.every_func) 
			}
		}
	},[this_setting],id)
	
}