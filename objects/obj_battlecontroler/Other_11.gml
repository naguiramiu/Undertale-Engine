///@desc act
var cur = current_character_selections[selected_char_number]
var ary = array_length(global.monsters)

// reset value at start

if cur.in_submenu2
{
	draw_set_font(font_deter_12)
	var monster = global.monsters[cur.act_monster_selection]
	var act = monster.actions
	var prev = cur.act_selection
	var ary = array_length(act)

	if interact_key // this is where acting is performed 
	{
		add_battle_action(function(cur)
		{
			var selected = scr_battle_get_firstmonster_available(cur.act_monster_selection)
			var monster = global.monsters[selected]
			var act = monster.actions[cur.act_selection]
			var char = get_char_by_party_position(cur.done_by)
			var dialogue = act.dialogue
			
			if act.set_can_spare monster.can_be_spared = true
			
			if !is_array(act.next_speechbubble) act.next_speechbubble = [act.next_speechbubble]
			if array_length(act.next_speechbubble)
			monster.next_dialogue = act.next_speechbubble
			
			if act.event != -1 
			{
				var event_return = act.event(cur)
				if is_string(event_return)
				dialogue = event_return
			}
			
			var var_struct = {}
			if variable_struct_exists(act,"event_dialogue_destroy")
			{
				var_struct.event_destroy = act.event_dialogue_destroy
				var_struct.event_destroy_params = [cur]
			}
			create_battle_textbox(dialogue,var_struct,true)
		},
		e_battle_priority.act
		)
		
		
		battle_advance_char()
		exit;
	}
	
	#region movement
	if left_key_press || right_key_press 
	cur.act_selection = (!(cur.act_selection % 2)) + (cur.act_selection div 2) * 2

	if cur.act_selection >= ary cur.act_selection = prev

	if down_key_press 
	{
		if cur.act_selection + 2 < ary 
		cur.act_selection += 2
		else cur.act_selection = cur.act_selection % 2
	}
	if up_key_press 
	{
		if cur.act_selection - 2 >= 0
		cur.act_selection -= 2
		else 
		{
			 if (cur.act_selection % 2)
			 {
				if (ary % 2) cur.act_selection = ary - 2 
				else cur.act_selection = ary - 1
			 }
			 else 
			 {
				 if !(ary % 2) cur.act_selection = ary - 2 
				else cur.act_selection = ary - 1
			 }
		}
	}
	#endregion
	if cur.act_selection != prev play_sound(snd_menu_move)
	
	var starty = cam_y 
	var current_x = 0
	var current_y = 0
	for (var i = 0; i < ary; i++)
	{
		draw_text(cam_x + current_x + 50,135 + starty+ current_y + 1, "*")
		draw_text_jitter(cam_x + current_x + 65 + 1,135 + starty+ current_y + 1, act[i].name)

			if i == cur.act_selection
		draw_sprite_ext(spr_soul,soul_frame,cam_x + current_x + 36,starty + current_y + 143,0.5,0.5,0,c_white,1)
		current_x += 120 + 8
		if (i % 2)
		{
			current_x = 0
			current_y += 16
		}
	}
	draw_set_font(font_deter_12)
exit;	
}

battle_draw_menu_with_monster_names(cur,"act_monster_selection")

if interact_key 
{
	cur.in_submenu2 = true 
	play_sound(snd_select)
	interact_key = false
}