/// @description Interact array settings

interact_array_menu = function(this_setting,i)
{
					
	var f = global.settings.fullscreen
	interact = false
					
	if mouse_check_button_pressed(mb_middle) && array_contains([e_settingstype.get_numeric,e_settingstype.get_str,e_settingstype.boolean,e_settingstype.set_menu],this_setting.type) 
		change_var(f,this_setting)
	else
	switch this_setting.type
	{
		case e_settingstype.get_struct:
		do_later(1,function(this_setting)
		{
			obj_devmenu_debug.scroll_target = 0
			array_push(obj_devmenu_debug.prev_menu,
			{
				where_im_at: this_setting.var_name,
				from: this_setting.from,
				menu_from_array: false,
				title: this_setting.title
			})
			with obj_devmenu_debug.current_menu
			{
				to_remove = this_setting.to_remove
				var fu = (this_setting.from == "global" ? variable_global_get : variable_self_get)
				var vars = string_split(this_setting.var_name,".",true)
				settings = fu(array_burst(vars),this_setting.from)
				while array_length(vars)
				settings = settings[$array_burst(vars)]
				title = this_setting.title
				menu_from_array = false
				max_height = this_setting.max_height
				func = this_setting.always_runs_func
				func_params = []
				every_func = this_setting.every_func
			}
			
		},this_setting)
		break;
						
		case e_settingstype.array:
						
		current_menu.where_im_at = this_setting.var_name
		do_later(1,function(this_setting)
		{
			obj_devmenu_debug.scroll_target = 0
			var func = current_menu.func
			array_push(obj_devmenu_debug.prev_menu, current_menu)
							
			this_setting.menu = {} 
			this_setting.menu.settings = []
			var set = (is_array(this_setting.from) ? this_setting.from[this_setting.var_name] : this_setting.from[$this_setting.var_name])
			for (var i = 0; i < array_length(set); i++)
				this_setting.menu.settings[i] = obj_devmenu_debug.create_struct_segment(array_val_name(set[i],i),set[i],i,set)
			this_setting.menu.func = -1
			this_setting.scroll_amount = 0 
			this_setting.menu.title = this_setting.title
			obj_devmenu_debug.current_menu = this_setting.menu
		},this_setting)
						
		break;
		case e_settingstype.get_numeric:
		case e_settingstype.get_str:	
		window_set_fullscreen(false)
		with obj_maincontroller
			event_perform(ev_alarm,0)
						
		do_later(f,function(this_setting)
		{
			var f = (this_setting.type == e_settingstype.get_numeric ? get_integer : get_string)
			obj_devmenu_debug.mouse_cursor = cr_default
			window_set_cursor(cr_default)
			obj_devmenu_debug.interact = false
			if is_array(this_setting.from)
			{
				var prev = this_setting.from[this_setting.var_name]
				this_setting.from[this_setting.var_name] = f("Insert the value",prev)
				var n = this_setting.from[this_setting.var_name]
				if is_undefined(n) || (string_length(n) == 0)
				this_setting.from[this_setting.var_name] = prev
			}
			else
			{
				var prev = variable_self_get(this_setting.var_name,this_setting.from) 
				variable_self_set(this_setting.var_name,f("Insert the value",prev),this_setting.from)
				var n = variable_self_get(this_setting.var_name,this_setting.from)
				if is_undefined(n) || (string_length(n) == 0)
				variable_self_set(this_setting.var_name,prev,this_setting.from)
			}
		},[this_setting],id)
		break;
		case e_settingstype.boolean:
		if is_bool(this_setting.default_type) 
		{
			if this_setting.from == 0 
				variable_global_set(this_setting.var_name,!variable_global_get(this_setting.var_name))
			else
			{
				if is_array(this_setting.from)
					this_setting.from[this_setting.var_name] = !this_setting.from[this_setting.var_name]
				else
				variable_self_set(this_setting.var_name,!variable_self_get(this_setting.var_name,this_setting.from),this_setting.from)
			}
		}
		else 
			this_setting.default_type()
		break;
		case e_settingstype.set_menu:
		current_menu.where_im_at = this_setting.var_name
		do_later(1,function(this_setting)
		{
			obj_devmenu_debug.scroll_target = 0
			var func = current_menu.func
			array_push(obj_devmenu_debug.prev_menu, current_menu)
			obj_devmenu_debug.current_menu = this_setting.menu
			obj_devmenu_debug.current_menu.scroll_amount = 0
			if obj_devmenu_debug.current_menu.func == -1 obj_devmenu_debug.current_menu.func = func
		},this_setting)
		break;
		case e_settingstype.event:
		function_call(this_setting.event,array_concat(this_setting.params,[this_setting,i]))
		break;
	}
	if (variable_self_exists("custom_func",this_setting) && this_setting.custom_func != -1)
		this_setting.custom_func(this_setting)				
	return false
}
	