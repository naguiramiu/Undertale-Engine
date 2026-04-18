function scr_settings_save()
{
	ini_open(file_dir() + "settings.ini")
	
	with global.settings
	{
		struct_foreach(self,function(key,value)
		{
			if !is_struct(value)
				ini_write_string("settings",key,value)
		})
		struct_foreach(keys,function(key,value){ini_write_string("keys",key,value)})
		
		if dev.devmode_on 
			{
				ini_write_string("dev","devmode_on",true)
				ini_write_string("dev","insta_load",dev.insta_load)	
			}
	}
	
	ini_close()
}

function scr_settings_load(set_language = false)
{
	ini_open(file_dir() + "settings.ini")
	
	struct_foreach(global.settings,function(key,value)
	{
		if is_bool(value)
			global.settings[$key] = bool(ini_read_real("settings",key,value))
		else if is_numeric(value)
			global.settings[$key] = ini_read_real("settings",key,value)
		
		#region keys 
		struct_foreach(global.settings.keys,function(key,value)
		{
			var load_key = ini_read_string("keys",key,value)
			
			if (string_letters(load_key) == "" || string_length(load_key) > 1 || load_key == "")
				load_key = value
				
			global.settings.keys[$key] = load_key
		})
		
	
	})
	if ini_read_real("dev","devmode_on",false)
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



