
function game_character(_name,_id,_ui_color,_max_hp = 20,_weapon_slot = e_weaponid.empty, _armor_slot = e_armorid.empty) constructor
{
	name = _name
	id = _id
	ui_color = _ui_color
	max_hp = _max_hp
	hp = max_hp
	attack = 0
	defense = 0
	attack = 0
	defense = 0
	weapon = _weapon_slot
	armor = _armor_slot
}

function scr_initiate_information()
{
	global.information =
	{
		starting_room: rm_ruins_startingroom,
		play_time: 0,
		room_name: "", 
		savefile_num: 0,
		front_vector: DOWN
	}

	with global.information
	{
		with room_get_custom_info(starting_room)	
		{
			other.x = x 
			other.y = y 
		}
	}
}


	
function scr_initiate_settings()
{
	global.settings = 
	{
		enable_borders: true,
		show_border_windowed: true,
		border_type: e_bordertype.enabled,
		selected_file: 0,
		language: "English",
		fullscreen: false,
		gen_volume: 75,
		mus_volume: 100,
		snd_volume: 100,
		auto_run: false,
		dev: 
		{
			on: true,
			insta_load: false,
		},
		keys: scr_default_keys()
	}
		
	global.screen_darken = 0;
	global.can_move = true;
	global.party_distance = 12;
}
