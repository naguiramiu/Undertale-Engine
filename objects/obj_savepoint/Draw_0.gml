var interact = interact_key_press
if interact && global.can_move && can_open_textbox()
{
	if player_is_facing_point(x + sprite_width / 2,y + sprite_height / 2)
	{
		if restore_hp
		{
			play_sound(snd_heal)
			for (var i = 0; i < array_length(global.stats.party); i++)
				with get_char_by_party_position(i) hp = max_hp
		}
		interact = false
		if is_defined(dialogue)
		{	
			var dial = variable_clone(dialogue)
			if !is_array(dial) dial = [dial]
			if restore_hp array_push(dial,"* (HP fully restored.)")
			
			create_textbox(dial,
			{
				let_player_move_end: false,
				event_destroy: open_save,
				stop_drawing_after_destroy: false
			})
		}
		else
			open_save() 	
	}
}
draw_self()