/// @description Main Draw event
draw_me = function(draw_box = false,draw_options = true, this_menu = current_menu,_setup_vars = true,_max_height = 206)
{
	if (_setup_vars)
		setup_vars(_max_height)
	var settings = this_menu.settings
	
	for (var i = 0; i < array_length(settings); i++)
	{
		var 
			this_setting = settings[i],
			title = this_setting.title,
			textcol = c_white
		
		if variable_struct_exists(this_setting,"from")
			var me = (!is_array(this_setting.from) ? variable_self_get(this_setting.var_name,this_setting.from) : this_setting.from[this_setting.var_name])
		switch this_setting.type
		{
			case e_settingstype.array:
				title += ": (Array)"
			break;
			case e_settingstype.slider:
				title += ": [-]" + string(me) + "[+]"
			break;
			case e_settingstype.get_numeric:
			case e_settingstype.get_str:
				title += ": " + string(me)
			break;
			case e_settingstype.boolean:
				title += ": " + (me ? "True  " : "False")
			break;
			
		}
		
		draw_set_colour(c_white)
		
		 if (draw_options)
		 {
			var str_w = string_width(title) / 2
			if mouse_check_hovers_rect_wh(menu_x + current_x,menu_y + current_y,str_w, string_height(title) / 2,mouse_xx,mouse_yy)
			{
				textcol = c_yellow
				mouse_cursor = cr_handpoint
				if interact || right_interact
				{
					var has_custom = (variable_self_exists("custom_func",this_setting) && this_setting.custom_func != -1)
					if has_custom
					{
						if this_setting.custom_func(this_setting,right_interact)
						{
							right_interact = false
							continue;
						}
					}
					
					var f = global.settings.fullscreen
					interact = false
					switch this_setting.type
					{
						case e_settingstype.array:
						
						current_menu.where_im_at = this_setting.var_name
						do_later(1,function(this_setting)
						{
							var func = current_menu.func
							array_push(obj_devmenu_debug.prev_menu, current_menu)
							
							this_setting.menu = {} 
							this_setting.menu.settings = []
							var set = this_setting.from[$this_setting.var_name]
							for (var i = 0; i < array_length(set); i++)
								this_setting.menu.settings[i] = obj_devmenu_debug.create_struct_segment("Index " + string(i) + ": " + "(" + string_capitalize(typeof(set[i]))  + ") ",set[i],i,set)
							this_setting.menu.func = -1
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
							if is_array(this_setting.from)
								this_setting.from[this_setting.var_name] = !this_setting.from[this_setting.var_name]
							else
							variable_self_set(this_setting.var_name,!variable_self_get(this_setting.var_name,this_setting.from),this_setting.from)
						}
						else 
							this_setting.default_type()
						break;
						case e_settingstype.set_menu:
						current_menu.where_im_at = this_setting.var_name
						do_later(1,function(this_setting)
						{
							var func = current_menu.func
							array_push(obj_devmenu_debug.prev_menu, current_menu)
							obj_devmenu_debug.current_menu = this_setting.menu
							if obj_devmenu_debug.current_menu.func == -1 obj_devmenu_debug.current_menu.func = func
						},this_setting)
						break;
						case e_settingstype.event:
						function_call(this_setting.event,array_concat(this_setting.params,[this_setting,i]))
						break;
					}
					
					if has_custom
						do_later(f*2,function(this_setting)
						{
							this_setting.custom_func(this_setting,false)
						},this_setting,obj_devmenu_debug)
				}
			}
				if this_setting.draw_underline
				draw_line_width_colour(menu_x + current_x - 1, menu_y + current_y + 7,menu_x + current_x + str_w - 1,menu_y + current_y + 7,0.5,c_gray,c_gray)
				draw_text_color_ext(menu_x + current_x + 0.5,menu_y + current_y + 0.5,title,c_black,0.5,0.5,0)
				draw_text_color_ext(menu_x + current_x,menu_y + current_y,title,textcol,0.5,0.5,0)
		 }
		 
		current_y += y_add * (string_height(title) div 16)
		height = max(height,current_y + padding / 2)
		if current_y + padding > max_height
		{
			line_broke = true
			current_x += 93
			current_y = padding
		}
		width = max(width,current_x + padding + string_width(title) * 0.5)  
	}
	
	if draw_box
	{
		draw_devmenu()
		draw_set_align_center()
		if string_width(this_menu.title) > (width + 30)
		{
			draw_reset_halign()
			draw_text(menu_x,menu_y - 9,this_menu.title)
		}	
		else
		draw_text(menu_x + width / 2,menu_y - 9,this_menu.title)
		draw_reset_align()
	}
}