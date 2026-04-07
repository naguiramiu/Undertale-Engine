// debug, shows all instances + their depth
function get_active_instances()
{
	var object_amounts = []
	with all
	if !array_contains(object_amounts,object_get_name(object_index))
	array_push(object_amounts,object_get_name(object_index))
		
	var tt = ""
	for (var i = 0; i < array_length(object_amounts); i++)
		tt += object_amounts[i] + ": " + string(instance_number(asset_get_index(object_amounts[i]))) + " depth: " + string(asset_get_index(object_amounts[i]).depth) + "\n"
	show_message(tt)
}

function scr_devfunctions()
{
	if keyboard_check_pressed(vk_f9)
	get_active_instances()
	
	if keyboard_check_pressed(vk_f2)
		game_restart()
	
	//player must exist to save
	if keyboard_check_pressed(ord("1")) 
		save_game()	

	if keyboard_check_pressed(vk_tab)
		if !instance_exists(obj_devroomwarp) 
				instance_create(obj_devroomwarp) 
			else 
			{ 
				instance_destroy(obj_devroomwarp)
				window_set_cursor(cr_default)
			}

	// insta load 
	if keyboard_check_pressed(vk_f1)
	{
		global.settings.dev.insta_load = !global.settings.dev.insta_load
		show_message("dev: insta load" + 
		(global.settings.dev.insta_load ? "on" : "off"))
		scr_settings_save()
	}
	
	if instance_exists(player) && space_key_press && global.can_move && !instance_exists(obj_battlecontroler) instance_create(obj_gotobattle)
}