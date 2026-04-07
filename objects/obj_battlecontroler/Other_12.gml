/// @description Item screen
draw_set_font(font_deter_12)
draw_set_color(c_white)
draw_set_alpha(1)
var cur = current_character_selections[selected_char_number]
//if cur.in_submenu2
//{
//	battle_draw_menu_with_party_names(cur,"item_char_selection")
//	if interact_key
//		battle_use_item(cur,cur.item_char_selection)
//	exit;	
//}

var inventory = global.stats.inventory

var number_of_items = get_number_of_items()

with cur 
{
	var prev = item_selection
	var prevtrue = item_selection + (item_page * 4)

	if right_key_press
	{
		if item_page = 0 && (item_selection % 2)
		{
			if global.stats.inventory[((item_selection) + 3)] != ITEM_EMPTY
			{
				item_page = 1
				item_selection --
			}
		}
		else
			item_selection ++
	}

	if left_key_press
	{
		if item_page = 1 && !(item_selection % 2)
		{
			if global.stats.inventory[item_selection + 1] != ITEM_EMPTY
			{
				item_page = 0
				item_selection ++
			}
		}
		else if item_selection != 2
			item_selection --
	}

	if down_key_press && item_selection < 2
		item_selection += 2
	if up_key_press && item_selection >= 2
		item_selection -= 2

	var itm_true = item_selection + (item_page * 4)

	if (itm_true >= number_of_items || itm_true < 0)
	item_selection = prev 

	var itm_true = item_selection + (item_page * 4)

	if global.stats.inventory[itm_true] == ITEM_EMPTY item_selection = prev 

	if prevtrue != item_selection + (item_page * 4) 
		play_sound(snd_menu_move)

	for (var i = (item_page * 4); i < 4 + (item_page * 4); i++)
	{
		if global.stats.inventory[i] == ITEM_EMPTY continue;
		var item = global.items[$global.stats.inventory[i]].name
		var curi =  i - (item_page * 4)
		var text_x = cam_x + 50 + ((i % 2 == 0) ? 0 : 120)
		var y_offset =  cam_y + (8 * curi) -  ((curi % 2 == 0) ? 0 : 8 )
		draw_text(text_x,136 + y_offset, "*")
		draw_text_jitter(text_x + 16,136 + y_offset, item)

		if curi == item_selection 
			draw_sprite_ext(spr_soul,0, text_x - 14,143 + y_offset,0.5,0.5,0,c_white,1)
	}
	
	draw_set_font(font_deter_12)
	draw_text(cam_x + 178 + 15,cam_y + 168,"PAGE " + string(item_page + 1))
	draw_set_font(font_deter_12)
}

if interact_key
{
	//cur.in_submenu2 = true
	battle_use_item(cur,selected_char_number)
	interact_key = false
	play_sound(snd_select)
}