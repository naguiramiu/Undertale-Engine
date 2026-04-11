function scr_setup_encounters()
{
	var monster = function(_monster_object = obj_enemy_froggit,_var_struct = {}) constructor
	{
		monster_object = _monster_object
		var_struct = _var_struct
	}
	
	
	global.encounters = 
	{
		ruins: 
		{
			test_battle: new setup_encounter( 
				[
					new monster(obj_enemy_whimsun),
					new monster(obj_enemy_froggit),
					new monster(obj_enemy_moldsmall)
				],
				"* Froggit, Whimsun and Moldsmall drew near!",
			),
			only_froggit: new setup_encounter( 
				[
					new monster(obj_enemy_froggit),
				],
				["* Froggit is alone.","* Froggit is depressed."]
			)
		}
	}
}


function setup_encounter (_monster_array = [],_flavor_text,_music = mus_battle1,_controller_object = noone,_background_object = obj_battle_background_grid,_can_flee = true,_var_struct = {}) constructor
{
	monster_array = _monster_array
	/* 
	   an array with the monsters
	   can be formated as [obj,obj,obj]
	   or created with the new monster() function, 
	   which allows for a simple var struct parse
	*/
	flavor_text = _flavor_text
	/* 
		this text will show up as the flavor text but of course the controller can change it or monsters
		if it is an array, the battlecontroller will choose a random dialogue to display
	*/
	controller_object = _controller_object
	/* 
		this is an object that will spawn when the battle starts if it isnt set to noone
		it will be cleaned when the battle ends
		useful for cutscenes
	*/
	
	background_object = _background_object // responsible for drawing the background
	music_asset = _music // music played
	can_flee = _can_flee // self explanatory
	
	struct_set_all_self(_var_struct) // this var struct will be parsed to the battle controller
}

function start_encounter(_encounter = global.encounters.ruins.test_battle)
{
	return instance_create(obj_gotobattle,{ encounter: _encounter })
}