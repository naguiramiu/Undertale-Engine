/// @description Initiate battle room
function battle_start()
{
	// everything here only runs once
	create_instances([obj_battlebox,obj_battle_hp_ui,obj_battle_background])
	instance_deactivate_object(parent_char)
	globalmusic_stop()
	globalmusic_play(music_asset,0,200,true,true)
	spawn_monsters(monster_instances)
		
	turn_length = 40
	turn_timer = -1
	created = true 
	added_gold = 0
	added_xp = 0
	button_xoffset = 0
	flavor_text = noone
	#region functions 
		
	flavor_text_reset = function()
	{
		with obj_battlecontroler.flavor_text
		{
			can_skip = false
			alarm[2] = 1
			letter_drawn_current = 1
			write = true
		}
	}
	
	if array_length(global.stats.party) > 1
		menu_buttons_lerp = function(_end){lerp_var_ext(id,"button_xoffset",0.04,button_xoffset,_end,ease_out)}
		
	#endregion
		
	global.can_move = false
}




