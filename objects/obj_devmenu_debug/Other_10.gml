/// @description Main Draw event
draw_me = function(draw_box = false,draw_options = true, this_menu = current_menu,_setup_vars = true,_max_height = 206)
{
	if (_setup_vars)
		setup_vars(_max_height)
	var settings = this_menu.settings
	
	if is_struct(settings)
		settings = variable_struct_get_names(settings)
	
	var is_from_array = variable_struct_exists(this_menu,"menu_from_array")
	&& this_menu.menu_from_array
	
	for (var i = 0; i < array_length(settings); i++)
	{
		if !is_struct(settings[i]) || is_from_array
		{
			if variable_struct_exists(current_menu,"to_remove")
				if is_string(settings[i]) && array_contains(current_menu.to_remove,settings[i])
					continue;
			
			var 
				this_setting = (is_from_array ? this_menu.settings[i] : this_menu.settings[$settings[i]]),
				title = (is_from_array ? array_val_name(this_setting,i) : string_capitalize(settings[i])),
				textcol = c_white,
				draw_underline = false 
			
			switch typeof(this_setting)
			{
				case "bool": case "boolean":
					title += ":  " + (this_setting ? "True  " : "False")
				break;
				case "struct":
					draw_underline = true 
				break;
				case "array":
					title += ": (Array)"
					draw_underline = true
				break;
				default:
					title += ": " + string(this_setting)
				break;
			}
		} 
		else
		{
			var 
				this_setting = settings[i],
				title = this_setting.title,
				textcol = c_white,
				draw_underline =  this_setting.draw_underline
		
			if variable_struct_exists(this_setting,"from")
			{
				if this_setting.type == e_settingstype.get_struct
				{
					if this_setting.from == "global"
						me = variable_global_get(this_setting.var_name)
					else me = variable_self_get(this_setting.var_name)
				}
				else
				var me = (!is_array(this_setting.from) ? variable_self_get(this_setting.var_name,this_setting.from) : this_setting.from[this_setting.var_name])
			}
			
			switch this_setting.type
			{
				case e_settingstype.array:
					title += ": (Array)"
				break;
				case e_settingstype.get_numeric:
				case e_settingstype.get_str:
					title += ": " + string(me)
				break;
				case e_settingstype.boolean:
					if this_setting.from == 0 
						me = variable_global_get(this_setting.var_name)
			
					title += ": " + (me ? "True  " : "False")
				break;
			
			}
		}
		var sw = 143 + 26
		var sh = 15
		draw_set_colour(c_white)
		var str_w = string_width_ext(title,sh,sw) / 2
		 if (draw_options)
		 {
			if mouse_check_hovers_rect_wh(menu_x + current_x,menu_y + current_y,str_w, string_height_ext(title,sh,sw) / 2,mouse_xx,mouse_yy)
			{
				textcol = c_yellow
				mouse_cursor = cr_handpoint
				if interact ^^ right_interact ^^ mouse_check_button_pressed(mb_middle)
				{
					if (!is_struct(settings[i]) || is_from_array)
					interact_struct_menu(this_setting,(is_from_array ? i : settings[i]),is_from_array)
					else
					if interact_array_menu(this_setting,i) continue;
				}
			}
				var col = draw_get_colour()
				if draw_underline
				draw_line_width_colour(menu_x + current_x - 1, menu_y + current_y + 7,menu_x + current_x + str_w - 1,menu_y + current_y + 7,0.5,c_gray,c_gray)
				draw_set_colour(c_black)
				draw_text_ext_transformed(menu_x + current_x + 0.5,menu_y + current_y + 0.5,title,sh,sw,0.5,0.5,0)
				draw_set_colour(textcol)
				draw_text_ext_transformed(menu_x + current_x ,menu_y + current_y,title,sh,sw,0.5,0.5,0)
				draw_set_colour(col)
		 }
		 
		current_y += (string_height_ext(title,sh,sw) * 0.5) + y_add
		height = max(height,current_y + padding / 2)
		if (current_y + padding) > max_height
		{
			line_broke = true
			current_x += width + -11
			if current_x + str_w > (320 - (11 + padding))
			{
				has_scroll = true
				current_x = padding
			}
			else
			current_y = padding
		}
		width = max(width,current_x + padding + string_width_ext(title,sh,sw) * 0.5)  
	}
	if draw_box
	{
		if (has_scroll)
			max_scroll_height = height - 62

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