
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

		if interact_key && instance_exists(flavor_text)
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

if !cur.in_submenu && instance_exists(flavor_text)
{
	with flavor_text 
		event_user(1) // draw self	
}

if cur.in_submenu && controler_can_move
event_user(cur.main_menu_selection)

cur = current_character_selections[selected_char_number]


var disabled_menus = get_unavailable_battle_menus()

for (var p = 0; p < array_length(global.stats.party); p++)
for (var i = 0; i < 4; i++)
{ 
	 var current_x = cam_x + 17.5 + (77.5 * i) + (-button_xoffset * 320) + (p * 320)
	 var current_y = cam_y + 216
	 if i == 0 current_x -= 1.5
	 if i == 1 current_x -= 2.5
	
	 var sprite = spr_battlebuttons_icon
	 var col = #FF7F27
	 var selected = (i == cur.main_menu_selection)
	 if array_contains(disabled_menus,i)
	 col = #707070
	 
	 if selected && controler_can_move
	 {
		 sprite = spr_battlebuttons_noicon
		 col = #FFFF40
	 }
	draw_sprite_ext(sprite, i, current_x , current_y,0.5,0.5,0,col,1)
	
	if selected && !cur.in_submenu && controler_can_move
	draw_sprite_ext(spr_soul,0,8 + current_x, 10.5 + current_y + 0.5,0.5,0.5,1,c_white,1)
 }

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