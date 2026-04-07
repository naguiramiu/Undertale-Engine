/// @description Load everything
// this code runs after both audiogroups have been loaded and it loads everything else that is needed
scr_language_main() // -- > Creates the default local language text In english and saves it to a file


initialize() /* -- > This function initializes all of the 
	games global structs and mechanics just as the characters,
	your stats, settings, flags, items
*/

scr_settings_load() // loads settings

window_set_fullscreen(global.settings.fullscreen)

window_custom_reset();

ini_open(file_dir() + "settings.ini")
	var read_language = ini_read_string("settings","language",-1)
ini_close()

// if theres a language saved to the settings file and it isnt english
if read_language != -1 // theres a read language
{
	if read_language != "English" // there is no reason to load if its english as english is on by default
	{
		var languages = scr_get_languages() // --> populates an array with the names of available languages
		// eg: ["Spanish.json","English.json"]
		if array_contains(languages,read_language + ".json") // if the language we're trying to load is avaiilable
		scr_load_language(read_language + ".json") // load it 
	}
}
else 
	scr_setup_os_language() // --> if theres no saved language, try to set it to your OS language if theres a file

application_surface_draw_enable(false) // obj_camera renders this so we dont need it
create_instances([obj_maincontroller,obj_camera,obj_debug]) // --> global instances that are allways there

if global.settings.dev.insta_load 
{
	load_game() 
	lerp_var_ext(obj_camera,"screen_darken",0.1,1,0,ease_out)
	exit;
}

room_goto(rm_titlescreen)

instance_destroy()