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
	
	if global.settings.fullscreen
		show_poppup(tt)
	else
	show_message(tt)
}

function scr_devfunctions()
{
	if keyboard_check_pressed(vk_f9)
	get_active_instances()
	
	if keyboard_check_pressed(vk_f2)
		game_restart()
		
	if keyboard_check_pressed(ord("1")) 
	 {
		save_game()	
		show_poppup("Game saved!")
	 }
	 
	if keyboard_check_pressed(vk_tab)
		if !instance_exists(obj_devroomwarp) 
				instance_create(obj_devroomwarp) 
			else 
			{ 
				instance_destroy(obj_devroomwarp)
				window_set_cursor(cr_default)
			}
			
	if keyboard_check_pressed(vk_f3)
		if !instance_exists(obj_devmenu_debug) 
				instance_create(obj_devmenu_debug) 
			else 
			{
				obj_devmenu_debug.self_visible = !obj_devmenu_debug.self_visible
				if obj_devmenu_debug.self_visible
					with (obj_devmenu_debug) event_perform(ev_create,0)
				window_set_cursor(cr_default)
			}
	// insta load 
	if keyboard_check_pressed(vk_f1)
	scr_dev_load_instantly()
	
	if instance_exists(player) && space_key_press && global.can_move && !instance_exists(obj_battlecontroler) 
		start_encounter(global.encounters.ruins.test_battle)
}

function scr_dev_load_instantly()
{
	global.settings.dev.insta_load = !global.settings.dev.insta_load
	show_poppup("DEV: Load instantly " + 
	(global.settings.dev.insta_load ? "ON" : "OFF"))
	scr_settings_save()
}