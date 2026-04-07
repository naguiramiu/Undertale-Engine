/// @description You won!
function battle_win()
{
	with obj_battlecontroler
	{
		battle_started = true // not actually started but makes it so you can move around in the menus
	
		var text = "* YOU WON!{.}{&}* You got " + string(added_xp) + " EXP and " + string(added_gold) + " GOLD!";

		global.stats.gold += added_gold

		var leveled_up = false 
	
		global.stats.xp += added_xp 

		while global.stats.xp >= get_nex_lvl(global.stats.lv)
		{
			leveled_up = true
			global.stats.xp -= get_nex_lvl(global.stats.lv)
			global.stats.lv ++
			
		}
		if leveled_up
		{
			for (var i = 0; i < array_length(global.stats.party); i++)
				with get_char_by_party_position(i) 
				{
					max_hp = 20 + ((global.stats.lv - 1) * 4)
					hp = max_hp
				}
			text += "{.}{&}" + "* Your LOVE increased."
			
			do_later(1,play_sound,snd_levelup)
		}
		
		create_battle_textbox(text,
		{
			event_destroy: function()
			{
				lerp_var_ext(obj_camera,"screen_darken",0.1,0,1,,,{event_destroy: battle_end})
			}
		})
	}
}