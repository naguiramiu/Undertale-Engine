function is_even(n)
{
	return ((n % 2) == 0)	
}

function destroy_instances(instances_array)
{
	for (var i = 0; i < array_length(instances_array);i++)
	if instance_exists(instances_array[i]) instance_destroy(instances_array[i])
}

function can_open_textbox()
{
	if !instance_exists(player) return false 
	if !global.can_move return false
	if instances_exist([obj_textbox,obj_mainmenu]) return false 
	return true
}

function scr_checkforduplicate()
{
	if (instance_number(object_index) > 1)
	{ 
		show_poppup("Error! There are " + string(instance_number(object_index)) + " instances of " + object_get_name(object_index) + " when there should only be one present at runtime!");
		instance_destroy();
		return true 
	}
	return false
}

function audiogroups_load()
{
	if !audio_group_is_loaded(audiogroup_music)
	audio_group_load(audiogroup_music)
	if !audio_group_is_loaded(audiogroup_sound)
	audio_group_load(audiogroup_sound)
	return 0;
}


function scr_namecheck(name)
{
	var silly_string = true 
	var check_name = string_upper(name)
		
	var firstchar = string_char_at(check_name,1)
	for (var i = 1; i <= string_length(check_name); i++)
		if string_char_at(check_name,i) != firstchar silly_string = false 
			
	if (string_copy("ABCDEF", 1, string_length(check_name)) == string_upper(check_name)) 
	silly_string = true
		
	var lan = get_lan(lan_text_title,"namescreen")
	var names = variable_struct_get_names(lan.names) 
	var entry_chosen = 
	{
		response: silly_string ? lan.name_not_creative : lan.name_correct,
		allow: true,
	}
		
	for (var i = 0; i < array_length(names); i++)
	{
		var this_check = lan.names[$names[i]]
		var is_this_entry = false
			
		if is_array(this_check.entry)
		{
			var check_array = []
			for (var n = 0; n < array_length(this_check.entry); n ++)
			if check_name == string_upper(this_check.entry[n])
			{
				is_this_entry = true 
				break;
			}
		}
		else is_this_entry = (check_name == string_upper(this_check.entry))
			
		if is_this_entry
		{
			entry_chosen = this_check
			break;
		}
	}
	
	return entry_chosen
}

function get_party_array_by_depth()
{
	var chars = []
	with parent_char array_push(chars,id)
	array_sort(chars,function(this,next){return this.depth < next.depth})
	return chars
}

function get_player_direction()
{
	return (instance_exists(player) ? get_current_direction(player.front_vector) : -1)	
}

function get_current_direction(vec)
{
	var dir = round(vec / 90) * 90;
	return (dir + 360) % 360;
}

function scr_warpdoor_get(warpdoor_id = 0)
{
	switch warpdoor_id
	{
		default:
		case 0: return
		[
			{
				room: rm_dev_testingarea,
				name: "Test Area"
			},
			{
				room: rm_ruins_startingroom,
				name: "Flower room"
			}
		]
	}
	
}

function scr_buildversion()
{
	#region build version
	draw_set_font(font_mars_12)
		draw_set_halign_center()
			draw_set_colour(#808080)
				draw_text_transformed(room_width / 2,231,"UNDERTALE ENGINE V 0.0",0.5,0.5,0)
			draw_reset_color()
		draw_reset_halign()
	draw_set_font(font_deter_12)
	#endregion
}

function scr_get_char_item_attack(char)
{
	return (get_item_value_safe(char.weapon,"attack") ?? 0) + (get_item_value_safe(char.armor,"attack") ?? 0)
}

function scr_get_char_item_defense(char)
{
	return (get_item_value_safe(char.weapon,"defense") ?? 0) + (get_item_value_safe(char.armor,"defense") ?? 0)
}

function get_item_value_safe(item,value)
{
	return (item == ITEM_EMPTY ? undefined : global.items[$item][$value])
}

function sprite_get_speed_ammount(sprite)
{
	if (sprite_get_speed_type(sprite) == spritespeed_framespersecond) 
	    return sprite_get_speed(sprite) / game_get_speed(gamespeed_fps);
	else 
	    return sprite_get_speed(sprite)
}

function array_from_struct_value(array, value_name)
{
    var len = array_length(array);
    var result = array_create(len);
    for (var i = 0; i < len; i++)
        result[i] = array[i][$value_name];
    return result;
}

function show_poppup(str) 
{
	return instance_create(obj_info_poppup,{text: str})
}

function instances_exist(instances_array)
{
	if !is_array(instances_array) instances_array = [instances_array]
	for (var i = 0; i < array_length(instances_array); i++)
	if instance_exists(instances_array[i]) return true;
	return false;
}

function array_burst(array)
{
	if array_length(array)
	{
		var res = array_first(array)
		array_delete(array,0,1)
		return res 
	}
	return undefined
}
function string_shorten(str,l = 10)
{
	if string_length(str) > l 
	{
		str = string_copy(str,1,l - 1)
		str += "."
	}
	return str 
}

function party_get_follower_remember_size()
{
	return ((array_length(global.stats.party) - 1) * global.party_distance)
}

function room_transition_warp(target_room,mywarp = noone,horizontal_dir = -1, vertical_dir = -1,insta_tp_party = false, percentage = 0.5)
{
	if (mywarp != noone)
	{
		var instances = room_get_info(target_room,false,true,false,false,false,false).instances
		for (var i = 0; i < array_length(instances); i++)
		if instances[i].id == mywarp 
		{
			mywarp = instances[i]	
			break;
		}
		
		if (horizontal_dir != -1)
		{	
			var 
				tp_y = round(mywarp.y + (20 * abs(mywarp.yscale) * percentage)),
				imgxscale = (20 * mywarp.xscale),
				xoff = (!horizontal_dir ? imgxscale + 10 : -15),
				tp_x = round(mywarp.x + xoff)
		}
		else if (vertical_dir != -1)
		{
			var 
				tp_x = round(mywarp.x + (20 * abs(mywarp.xscale) * percentage)),
				imgyscale = (20 * mywarp.yscale),
				yoff = (!vertical_dir ? imgyscale + 15 : -15),
				tp_y = round(mywarp.y + yoff)
		}
	}
	else 
	{
		with room_get_custom_info(target_room)
		{
			var tp_x = x 
			var tp_y = y
		}
	}
	scr_teleport_player(tp_x,tp_y,insta_tp_party)
}


function draw_gui_surface_borderfix(surf,alpha = 1)
{
	gpu_set_blendmode(bm_normal)

	if (global.settings.border_type != e_bordertype.not_enabled) && (global.settings.fullscreen || global.settings.show_border_windowed)
	{
		var 
		final_mult = (display_get_gui_height() / surface_get_height(surf)) * 0.89,
		draw_w = surface_get_width(surf) * final_mult,
		draw_h = surface_get_height(surf) * final_mult,
		draw_x = (display_get_gui_width() - draw_w) / 2,
		draw_y = (display_get_gui_height() - draw_h) / 2
		//29.65 39.69 show_message(draw_x) show_message(draw_y)
		draw_surface_stretched_ext(surf, draw_x, draw_y, draw_w, draw_h,c_white,alpha);
	}
	else 
		draw_surface_ext(surf,0,0,1,1,0,c_white,alpha)
		
	gpu_set_blendenable(true);
}

