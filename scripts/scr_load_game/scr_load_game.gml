function load_game(savefile_num = 0, load_from_file = true)
{
	var file_name = savefile_name(savefile_num)
	var checked = false
	var checked_string = ""
	if file_exists(file_name) && load_from_file
	{
		try 
		{
			var data = file_read_all_text(file_name)

			if data != ""
			{
				var main_struct = load_savefile(data)
				global.information = struct_merge(global.information, main_struct.information)
				global.stats = struct_merge(global.stats,main_struct.stats)
				global.flags = struct_merge(global.flags,main_struct.flags)
				delete main_struct
			}
			else checked = true
		} 
		catch (ex) 
		{
			window_custom_reset(window_get_fullscreen())
			crashfile_write(get_error_message(ex))
			room_goto(rm_dogcheck)
			exit;
		}
	}
				
	load_player()
	
	var room_to_go = undefined 
	if variable_struct_exists(global.information,"room_name") && room_exists(asset_get_index(global.information.room_name))
	room_to_go = asset_get_index(global.information.room_name)
	
	if is_undefined(room_to_go)
	{ 
		room_to_go = global.information.starting_room
		with room_get_custom_info(global.information.starting_room)
			scr_teleport_player(x,y,true)
	}
	
	room_goto(room_to_go)
	
	with obj_camera set_camera_position(true,room_to_go)
	lerp_var_ext(obj_camera,"darken_screen",0.1,1,0)
	global.information.savefile_num = savefile_num
}

function load_player()
{
	global.can_move = true
	global.party_instances = []
	for (var i = 0; i < array_length(global.stats.party); i++)
	{
		var my_char = get_char_by_party_position(i)
		var is_player_character = (i == 0)
		
		var saved_coords = global.information
		var _x = saved_coords.x 
		var _y = saved_coords.y
		var _char_name = global.stats.party[i]		
		
		global.party_instances[i] = instance_create_depth(_x,_y,-_y,(is_player_character ? player : obj_char_follower), 
		{
			char_name: _char_name,
			array_size: ((array_length(global.stats.party) - 1) * global.party_distance),
			number_in_party: i,
			depth: -_y,
			front_vector: saved_coords.front_vector,
		})
		var dir = player.front_vector
		with global.party_instances[i]
		{
			if !is_player_character 
			{
				event_perform(ev_create,0)
				var reverse_dir = (dir + 180) % 360;
				for (var a = array_size - 1; a >= 0; a--)
					{
						record[a] = 
						{
							x: player.x + lengthdir_x(a, reverse_dir),
							y: player.y + lengthdir_y(a, reverse_dir),
							front_vector: dir
						}
					}
				
			} 
			set_depth(dir)
		}
	}
}
function shader_set_u_simple(u_name,_array)
{
	if !is_array(_array) _array = [_array]
	shader_set_uniform_f_array(shader_get_uniform(shader_current(),u_name),_array)	
}
function load_savefile(data,encrypt = ENCRYPT_SAVEDATA)
{
	if encrypt
	{
		var string_struct = scr_struct_fy_load(data)
		string_struct = string_quote_parse(string_struct)
		return json_parse(string_struct)
	}
	else
		return json_parse(data)
}