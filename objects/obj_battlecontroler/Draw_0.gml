
interact_key = interact_key_press

var cur = current_character_selections[selected_char_number]
var prev = cur.main_menu_selection

var in_submenu = cur.in_submenu
var disabled_menus = get_unavailable_battle_menus(selected_char_number)

if controler_can_move
{
	if !cur.in_submenu
	{
		if back_key_press && selected_char_number != 0
		{
			selected_char_number -- 
			while (get_char_by_party_position(selected_char_number).hp <= 0) && selected_char_number != 0
				selected_char_number --
				
			menu_buttons_lerp(selected_char_number)
			flavor_text_reset()
			var cur = current_character_selections[selected_char_number]
			var prev = cur.main_menu_selection
			play_sound(snd_menu_move)
			global.stats.inventory = array_copy_simple(cur.prev_inventory)
		}
		
		if right_key_press cur.main_menu_selection = modwrap(cur.main_menu_selection,1,4,disabled_menus)
		if left_key_press cur.main_menu_selection = modwrap(cur.main_menu_selection,-1,4,disabled_menus)

		if interact_key && instance_exists(flavor_text_instance)
		{
			cur.in_submenu = true 
			interact_key = false
			if !audio_is_playing(snd_select)
			play_sound(snd_select)
		}
	}
	else 
	{
		if back_key_press
		{
			if cur.in_submenu2
				cur.in_submenu2 = false
			else 
			{
				cur.in_submenu = false 
				flavor_text_reset()
			}
			play_sound(snd_menu_move)
		}
	}
}


if prev != cur.main_menu_selection
play_sound(snd_menu_move)


battle_draw_bottom_ui() // draw bottom ui

with obj_battlebox
	event_perform(ev_draw,ev_draw_normal) // draw battle box 

if !cur.in_submenu && instance_exists(flavor_text_instance)
{
	with flavor_text_instance 
		event_user(1) // draw flavor text 	
}

if cur.in_submenu && controler_can_move
event_user(cur.main_menu_selection) // draw menys««us


if turn_timer != -1 
{
	if turn_length != -1
	{
		if turn_timer < turn_length turn_timer ++ 
		else 
		{
			battle_end_turn()
			turn_timer = -1	
		}
	}
}


if global.invframes_timer > 0 
{
	if !instance_exists(obj_soul)
		global.invframes_timer --
	soul_frame += sprite_get_speed_ammount(spr_soul)
}
else 
	soul_frame = 0