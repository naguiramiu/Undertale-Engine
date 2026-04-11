
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
	if instance_exists(obj_textbox) return false 
	if instance_exists(obj_mainmenu) return false 
	return true
}

function scr_checkforduplicate()
{
	if (instance_number(object_index) > 1)
	{ 
		show_debug_message("Error! There are " + string(instance_number(object_index)) + " instances of " + object_get_name(object_index) + " when there should only be one present at runtime!");
		instance_destroy();
	}
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
	var _attack = 0
	if char.weapon != ITEM_EMPTY
		_attack += global.items[$char.weapon].attack
	if char.armor != ITEM_EMPTY
		_attack += global.items[$char.armor].attack
	return _attack
}


function scr_get_char_item_defense(char)
{
	var _defense = 0
	if char.weapon != ITEM_EMPTY
		_defense += global.items[$char.weapon].defense
	if char.armor != ITEM_EMPTY
		_defense += global.items[$char.armor].defense
	return _defense
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