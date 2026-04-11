/// @description BUY
var back_key = back_key_press

if (open_menu)
{
	box_progress = 0
	create_tiny_dialogue("Take what you want, little buddy.")
}

draw_reset_all()

var backout = false
var boxtext = ""

if !item_in_choicer
{
	var prev = item_selection + selecting_exit
	
	if down_key_press
	{
		if selecting_exit
		{
			item_selection = 0	
			selecting_exit = false
		}
		else
		{
			if item_selection != array_length(my_items) - 1
			item_selection ++
			else selecting_exit = true
		}
	}

	if up_key_press
	{
		if selecting_exit
		{
			item_selection = array_length(my_items) - 1	
			selecting_exit = false
		}
		else
		{
			if item_selection != 0
			item_selection --
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
{
	if instance_exists(tiny_dialogue)
	{
		with tiny_dialogue
			event_user(1)
		
		draw_reset_all()
	}
}
var selected_item = get_item_by_id(my_items[item_selection].id)

for (var i = 0; i < array_length(my_items); i++)
{
	var item_s = my_items[i]
	if i == item_selection && !selecting_exit
	{
		if !item_in_choicer
		draw_sprite(spr_soul_text,0,15,134 + 20 * i)
		boxtext = item_s.description
	}
	var item = get_item_by_id(item_s.id)
	var s = string(item_s.sell_price) + "G"
	draw_text(30,131 + 20 * i,s)
	draw_text(30 + string_width(s) + 13,(20 * i) + 131 ,item.name)
	draw_text(30 + string_width(s),(20 * i) + 125 ," _ ")
}

if (selecting_exit)
	draw_sprite(spr_soul_text,0,15,215)
	
draw_text(30,211,"Exit")
var	number_of_items = get_number_of_items()

if item_in_choicer
{
	var tiny_text = tiny_dialogue_text.exit_out_buy
	if interact_key
	{
		if item_choicer_sel == 1 backout = true 
		else
		{
			if (number_of_items == array_length(global.stats.inventory))
			{
				tiny_text = tiny_dialogue_text.inventory_full
				play_sound(snd_cantselect)
			}	
			else if (global.stats.gold < my_items[item_selection].sell_price)
			{
				tiny_text = tiny_dialogue_text.no_gold
				play_sound(snd_cantselect)
			}
			else
			{
				global.stats.gold -= my_items[item_selection].sell_price
				tiny_text = tiny_dialogue_text.bought
				play_sound(snd_buyitem)
				add_item_to_inventory(my_items[item_selection].id)
				number_of_items = get_number_of_items()
			}
		}
	}
	
	if (back_key || interact_key)
	{
		backout = false
		back_key = false
		item_in_choicer = false
		instance_destroy(tiny_dialogue)
		create_tiny_dialogue(tiny_text)
		if !audio_is_playing(snd_cantselect) play_sound(snd_menu_move)
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
		
		draw_sprite(spr_soul_text,0,224,173 + 15 * mouse_check_button(mb_right))
		draw_text_ext(230,131,string_linebreaks(string_replace_all(tiny_dialogue_text.buy_text,"{required}",string(my_items[item_selection].sell_price))),15,80)
		for (var i = 0; i < 2; i++)
		draw_text(240,171 + 15 * i,i ? "No" : "Yes")
	}
}

start_mask()
draw_rectangle_wh(0,0,room_width,119)
end_mask()
draw_masked_start()
var yoff = ease_out_back(box_progress,120,39)
draw_text(0,50,yoff)
draw_menu(210,yoff,110,240,4)
var drawn_text = string_replace_all(boxtext,"{&}","\n")

if array_contains([e_itemtype.armor,e_itemtype.weapon],selected_item.item_type)
{
	var char = get_char_by_party_position(0)
	var current_attack = scr_get_char_item_attack(char)
	var current_defense = scr_get_char_item_attack(char)
	var could_be_defense = 0 
	var could_be_attack = 0 
	
	if variable_struct_exists(selected_item,"defese")
	could_be_defense += selected_item.defense 
	
	if variable_struct_exists(selected_item,"attack")
	could_be_attack += selected_item.attack 
	
	if selected_item.item_type == e_itemtype.weapon
	{
		if char.armor != ITEM_EMPTY
		{
			could_be_attack += global.items[$char.armor].attack
		    could_be_defense += global.items[$char.armor].defense
		}
	}
	else 
	if selected_item.item_type == e_itemtype.armor
	{
		if char.weapon != ITEM_EMPTY
		{
			could_be_attack += global.items[$char.weapon].attack
		    could_be_defense += global.items[$char.weapon].defense
		}
	}
	
	var _defense_dif = could_be_defense - current_defense
	var _attack_dif = could_be_attack -  current_attack
	
	var get_operator = function(n)
	{
		return n >= 0 ? "+" : "";
	}
	
	drawn_text = string_replace_markup_ext(drawn_text,
	{
		defense_dif: get_operator(_defense_dif) + string(_defense_dif),
		attack_dif: get_operator(_attack_dif) + string(_attack_dif),
	})
}

if drawn_text != ""
box_text_current = drawn_text

draw_text_ext(224,15 + yoff,box_text_current,16,90)
draw_masked_end()
draw_set_color(c_white)

if boxtext == ""
{
	if box_progress > 0
	box_progress -= 0.1
}
else
{
	if box_progress < 1 
	box_progress += 0.1
}

if back_key || backout
{
	in_submenu = false 
	create_large_dialogue(large_text_dialogue.exiting_menu)
	instance_destroy(tiny_dialogue)
	play_sound(snd_menu_move)
	alarm_set_instant(0,0)
}