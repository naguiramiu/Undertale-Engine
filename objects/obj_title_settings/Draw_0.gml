draw_set_align_center()
draw_text_transformed(160,28,"SETTINGS",2,2,0)
draw_reset_align()

var prev = main_selection
if !in_slider
	main_selection = scr_updown_modwrap(main_selection,array_length(settings))

var lan = get_lan(lan_text_title).settings
var interact = interact_key_press
var current_y = 0
for (var i = 0; i < array_length(settings); i++)
{
	var option = settings[i]
	var name = option.text
	var this_interact = (interact && i == main_selection)
	window_custom_reset();
	var val_x = 152
	switch option.type 
	{
		case e_settingstype.boolean:
			if this_interact
			{
				global.settings[$option.var_name] = !global.settings[$option.var_name]
				lerp_var_ext(option,"lerp_amount",0.1,1,0)
				
				window_custom_reset()
				play_sound(snd_menu_move)
			}
			draw_text_color_ext(val_x,41 + current_y,(global.settings[$option.var_name] ? lan.settings_true : lan.settings_false),merge_colour(c_gray,c_white,option.lerp_amount))
		break;
		case e_settingstype.array:
			if this_interact
			{
				play_sound(snd_menu_move)
				if !in_slider
				{
					in_slider = true 
					value_selection = 0
				}
				else
				{
					global.settings[$option.var_name] = (value_selection + global.settings[$option.var_name]) % array_length(option.values)
					in_slider = false
					
					window_custom_reset()
					goto_main_settings()
					
					
					
					main_selection = prev 
				}
			}
			
			if i == main_selection && in_slider
			{
				var start = global.settings[$option.var_name]
				var ary =  array_length(option.values)
				value_selection = scr_leftright_modwrap(value_selection,ary)
				var cx = val_x
				for (var a = start; a < start + ary; a++)
				{
					var this = a % ary
					var val = option.values[this]
					draw_text_color_ext(cx,41 + current_y,val,((a - start) == value_selection ? c_white : c_gray))
					cx += string_width(val) + 5
				}
			}
			else 
			draw_text_color_ext(val_x,41 + current_y,option.values[global.settings[$option.var_name]],c_gray)

		break;
		case e_settingstype.key: 
			if this_interact
				{
					set_later(2,id,"in_slider",!in_slider)
					play_sound(snd_menu_move)
					keyboard_lastkey = vk_nokey
					keyboard_lastchar = ""	
				}
			var selected = (i == main_selection && in_slider)
			draw_text_color_ext(val_x,41 + current_y,string_upper(global.settings.keys[$"key_" + option.var_name]),(selected ? c_white: c_gray))
			
			if selected && in_slider
			{
				if (keyboard_lastkey != vk_nokey && string_letters(keyboard_lastchar) != "")
				{
					if string_length(keyboard_lastchar) == 1 
					{
						var k = keyboard_lastchar
					    scr_setspecifickey("key_" + option.var_name,string_upper(k)) 
						in_slider = false 
						play_sound(snd_menu_move)
					}
				}
			}
			
			if escape_key_press
				global.settings.keys = scr_default_keys()
			
		break;
		case e_settingstype.event:
			if this_interact
			{
				with option
					function_call(event,customevent_get_params())
				interact = false		
			}
		break;
		case e_settingstype.slider:
			if this_interact 
			{
				play_sound(snd_menu_move)
				in_slider = !in_slider
			}
			var selected = (i == main_selection && in_slider)
			var val = global.settings[$option.var_name]
			if selected 
			{
				var prev = val
				if keyboard_check_holdpress(vk_right,1,6,0) val = min(prev + 1,100)
				if keyboard_check_holdpress(vk_left,1,6,0) val = max(prev - 1, 0)
				if prev != val
				{
					if !audio_is_playing(snd_noise)
					audio_play_sound(snd_noise,0,0,val * 0.01)
					global.settings[$option.var_name] = val
					scr_set_sound()
				}
				var xoff = 4 + ((round(time_normalized(0.008))) * ((i % 2) == 0 ? 1 : -1)) * 0.5
				if val > 0
				draw_sprite_ext(spr_arrow_2,0,142 - xoff,41 + current_y + string_height(val) / 2,-0.5,0.5,0,c_white,1)
				if val < 100
				draw_sprite_ext(spr_arrow_2,0,142 + string_width(val) + xoff,41 + current_y + string_height(val) / 2,0.5,0.5,0,c_white,1)
			}
			draw_text_color_ext(val_x,41 + current_y,val,(selected ? c_white: c_gray))
		break;
	}
	draw_text_color_ext(20,41 + current_y,name + (option.type == e_settingstype.event ? "" : ":"),(i == main_selection ? c_yellow : c_white),option.text_scale)
	current_y += 15 + (i == 0) * 15
}

if back_key_press 
{
	if in_slider
		{
			in_slider = false
			play_sound(snd_menu_move)
		}
	else
		with settings[0] // settings 0 is back
		function_call(event,customevent_get_params())
}

if weather_type != -1
{
	with weather_layout[weather_type]
	{
		if event != -1
			event(self)
		else 
		{
			if instance_exists(obj_title_settings)
			instance_create(obj_settings_leaves,fall_obj_var_struct).depth = obj_title_settings.depth + 1
			var siner = current_time / 50
			draw_sprite_ext(tobdog_sprite, floor(siner / 15), 250, 218, 1, 1, 0, c_white, 1);
			draw_set_color(c_gray);
			draw_text_transformed(220 + sin(siner / 9), 120 + cos(siner / 9), string_linebreaks(text), 1, 1, -20)
		}
	}
}
draw_set_color(c_black);
draw_rectangle(168 - initital_cover, -10, -1, 250,0);
draw_set_color(c_black);
draw_rectangle(152 + initital_cover, -10, 330, 250,0);
draw_reset_color()

keyboard_lastkey = vk_nokey