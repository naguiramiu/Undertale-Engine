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

