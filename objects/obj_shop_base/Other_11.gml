/// @description SELL

var back_key = back_key_press

if open_menu
	create_tiny_dialogue(tiny_dialogue_text.default_sell_dialogue)

var number_of_items = get_number_of_items()

var backout = false

if !item_in_choicer
{
	var prev = item_selection + selecting_exit

	if down_key_press
	{
		if selecting_exit
		{
			sell_scroll_offset = 0
			item_selection = 0	
			selecting_exit = false
		}
		else
		{
			if item_selection != number_of_items - 1
			{
				if item_selection - sell_scroll_offset == 3
				sell_scroll_offset ++
				item_selection ++
			}
			else selecting_exit = true
		}
	
	}

	if up_key_press
	{
		if selecting_exit
		{
			item_selection = number_of_items - 1	
			sell_scroll_offset = max(0,item_selection - 3)
			selecting_exit = false
		}
		else
		{
			if item_selection != 0
			{
				if item_selection - sell_scroll_offset == 0
				sell_scroll_offset --
				item_selection --
			}
			else selecting_exit = true
		}
	
	}

	if prev != item_selection + selecting_exit
	play_sound(snd_menu_move)
	
	if interact_key
	{
		if selecting_exit
		backout = true 
		else
		{
			item_choicer_sel = 0
			interact_key = false
			item_in_choicer = true 
			play_sound(snd_select)
		}
	}
}

if !item_in_choicer
with (tiny_dialogue)
event_user(1)

draw_reset_all()

var selected_item = get_item_by_id(global.stats.inventory[item_selection])

var current_y = 0
for (var i = sell_scroll_offset; i < (sell_scroll_offset + 4); i++)
{
	if i >= number_of_items || global.stats.inventory[i] == ITEM_EMPTY break;
	
	var item = get_item_by_id(global.stats.inventory[i])
	if i == item_selection && !selecting_exit
	{
		if !item_in_choicer
		draw_sprite(spr_soul_text,0,15,134 + current_y)
	}
	var s = string(item.sell_price) + "G"
	draw_text(30,131 + current_y,s)
	draw_text(30 + string_width(s) + 13,current_y + 131 ,item.name)
	draw_text(30 + string_width(s),current_y + 125 ," _ ")
	current_y += 20
}

if sell_scroll_offset != max(0,number_of_items - 4) 
	draw_sprite(spr_arrows,0, 189, 218)
if sell_scroll_offset != 0
	draw_sprite(spr_arrows,1, 189,  133)

if selecting_exit
draw_sprite(spr_soul_text,0,15,215)

draw_text(30,211,"Exit")

if item_in_choicer
{
	var smalldialogue = tiny_dialogue_text.exit_out_sell
	if interact_key
	{
		if item_choicer_sel == 1 backout = true 
		else
		{
			if number_of_items == 1
			{
				backout = true
				interact_key = false
			}
			smalldialogue = tiny_dialogue_text.sold
			
			global.stats.gold += selected_item.sell_price
			
			array_delete(global.stats.inventory,item_selection,1) 
			global.stats.inventory[array_length(global.stats.inventory)] = ITEM_EMPTY
			
			if sell_scroll_offset != 0 && item_selection - sell_scroll_offset == 0 sell_scroll_offset --
			if item_selection > 0 item_selection --
			
			play_sound(snd_buyitem)
			sell_scroll_offset = max(0,item_selection - 3)
		}
	}

	if back_key || interact_key
	{
		backout = false
		back_key = false
		item_in_choicer = false
		instance_destroy(tiny_dialogue)
		create_tiny_dialogue(smalldialogue)
		if !audio_is_playing(snd_cantselect) 
			play_sound(snd_menu_move)
	}
	else
	{
		if !interact_key
		{
			if down_key_press || up_key_press
			{
				play_sound(snd_menu_move)	
				item_choicer_sel = !item_choicer_sel
			}
		}
		
		draw_sprite(spr_soul_text,0,225,175 + 15 * item_choicer_sel)
		
		draw_text_ext(230,131,string_replace_all(tiny_dialogue_text.sell_text,"{required}",string(selected_item.sell_price)),15,80)
		for (var i = 0; i < 2; i++)
		draw_text(240,171 + 15 * i,i ? "No" : "Yes")
	}
}

if back_key || backout
{
	in_submenu = false 
	create_large_dialogue(other.large_text_dialogue.exiting_menu)
	play_sound(snd_menu_move)
	instance_destroy(tiny_dialogue)
	alarm_set_instant(0,0)
}