/// @description Initiate battle room
function battle_start()
{
	// everything here only runs once
	instance_create(background_instance)
	
	with instance_create(obj_battlebox)
	{
		lerp_var_ext(id,"width",0.1,0,287.5) //start width 
		lerp_var_ext(id,"height",0.1,0,70) // start height
	}
	
	instance_deactivate_object(parent_char)
	globalmusic_stop()
	globalmusic_play(music_asset,0,200,true,true)
	spawn_monsters(monster_instances)
	set_border(spr_border_simple)
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




