/// @description You won!
function battle_win()
{
	globalmusic_stop()
	
	with obj_battlecontroler
	{
		battle_started = true // not actually started but makes it so you can move around in the menus
	
		var text = "* YOU WON!{.}{&}* You got " + string(added_xp) + " EXP and " + string(added_gold) + " GOLD!";

		global.stats.gold += added_gold

		var leveled_up = false 
		
		for (var i = 0; i < array_length(global.stats.party); i++)
		{
			var char = get_char_by_party_position(i)
			char.xp += added_xp 

			while char.xp >= get_nex_lvl(char.lv)
			{
				leveled_up = true
				char.xp -= get_nex_lvl(char.lv)
				char.lv ++
			}
		}
		if leveled_up
		{
			for (var i = 0; i < array_length(global.stats.party); i++)
				with get_char_by_party_position(i) 
				{
					max_hp = 20 + ((lv - 1) * 4)
					hp = max_hp
				}
			text += "{.&}" + "* Your LOVE increased."
			
			do_later(1,play_sound,snd_levelup)
		}
		
		cutscene_perform_event = false
		var cut = cutscene_create(
			cut_textbox()
		
		)
		create_battle_textbox(text,
		{
			event_destroy: function()
			{
				lerp_var_ext(obj_camera,"screen_darken",0.1,0,1,,,{event_destroy: battle_end})
			}
		})
	}
}