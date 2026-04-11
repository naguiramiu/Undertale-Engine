function save_game(savefile_num = global.information.savefile_num)
{
	global.settings.selected_file = savefile_num
	scr_settings_save()
	var main_struct = {}
	
	main_struct.stats = global.stats 
	main_struct.saved_information = {}
	main_struct.flags = global.flags
	
	with main_struct.saved_information
	{
		if instance_exists(player)
		{
			x = player.x
			y = player.y
			front_vector = player.front_vector
		}
		else 
		{
			x = 0 
			y = 0 
			front_vector = DOWN
		}
		play_time = global.information.play_time
		room_name = room_get_name(room)
	}
	
	var write = (ENCRYPT_SAVEDATA ? string_quote_parse(scr_struct_fy_save(main_struct),0) : json_stringify(main_struct,1))
	
	file_write_all_text(
		savefile_name(savefile_num),
		write
	)
}

