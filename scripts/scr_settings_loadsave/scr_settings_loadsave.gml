
function scr_settings_save()
{
	ini_open(file_dir() + "settings.ini")
	var keys = struct_get_names(global.settings)
	for (var i = 0; i < array_length(keys); i++)
	if !is_struct(global.settings[$keys[i]])
	ini_write_string("settings",keys[i],global.settings[$keys[i]])
	else 
	{
		if keys[i] == "keys"
		{
			var keystrings = struct_get_names(global.settings.keys)
			for (var k = 0; k < array_length(keystrings); k++)
			ini_write_string("keys",keystrings[k],global.settings.keys[$keystrings[k]])	
		}
		else 
		{	
			if global.settings.dev.on 
			ini_write_string("dev","on",true)
			if ini_read_real("dev","on",false)
			{
				ini_write_string("dev","insta_load",global.settings.dev.insta_load)	
			}
		}
	}
	ini_close()
}

function scr_settings_load(set_language = false)
{
	ini_open(file_dir() + "settings.ini")
	var keys = struct_get_names(global.settings)
	
	for (var i = 0; i < array_length(keys); i++)
	if (is_real(global.settings[$keys[i]]) || is_int64(global.settings[$keys[i]]))
	global.settings[$keys[i]] = ini_read_real("settings",keys[i],global.settings[$keys[i]])
	else 
	if is_bool(global.settings[$keys[i]]) 
	bool(ini_read_real("settings",keys[i],global.settings[$keys[i]]))
	
	#region keys 
	var keystrings = struct_get_names(global.settings.keys)
	for (var i = 0; i < array_length(keystrings); i++)
	{
		var key = ini_read_string("keys",keystrings[i],global.settings.keys[$keystrings[i]])
		if (string_letters(key) == "" || string_length(key) > 1 || key == "")
			key = global.settings.keys[$keystrings[i]]
	
		global.settings.keys[$keystrings[i]] = key
	}

	if ini_read_real("dev","on",false)
		global.settings.dev.insta_load = ini_read_string("dev","insta_load",false)	
		
	// make sure all of the settings are clamped, and are their correct types.
	with global.settings
	{
		if !is_bool(fullscreen) fullscreen = false
		if !is_numeric(gen_volume) gen_volume = 75
		if !is_numeric(mus_volume) mus_volume = 100
		if !is_numeric(snd_volume) snd_volume = 100
		mus_volume = clamp(mus_volume,0,100)
		snd_volume = clamp(snd_volume,0,100)
		gen_volume = clamp(gen_volume,0,100)
		if !is_bool(auto_run) auto_run = false
	}
	scr_set_sound()
}

function scr_set_sound()
{
	audio_group_set_gain(audiogroup_music,(global.settings.mus_volume * 0.02) * (global.settings.gen_volume * 0.005),0)
	audio_group_set_gain(audiogroup_sound,(global.settings.snd_volume * 0.01) * (global.settings.gen_volume * 0.005),0)	
}



