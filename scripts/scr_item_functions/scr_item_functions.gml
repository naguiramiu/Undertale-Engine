function use_item_main(selected_item,selection,var_struct = {}, create_textboxes = true,remove_item = true, used_by_pos = 0,used_on_pos = 0,battle = false)
{
	var character_used_on = get_char_by_party_position(used_on_pos)
	
	var item = variable_clone(selected_item)
	
	if variable_struct_exists(item,"dialogue_event")
		with item variable_struct_get(item,"dialogue_event")(item)
		
	var dialogue = item.use_description
	
	if !is_array(dialogue) dialogue = [dialogue]
	
	if variable_struct_exists(item,"dialogue_var_struct")
		struct_add_unique(var_struct,item.dialogue_var_struct)
		
	if variable_struct_exists(item,"turn_into") && remove_item
		{
			global.stats.inventory[selection] = item.turn_into
			item.remove_after_use = false 
		}
	
	var type = item.item_type
	
	if type == e_itemtype.consumable
	{
		if remove_item && variable_struct_exists(item,"remove_after_use") && item.remove_after_use
			array_delete(global.stats.inventory,selection,1)
		
		if create_textboxes
		{
			with var_struct  
				{
					event_heal_parameters = [selected_item.heal_amount,character_used_on]
					event_heal = function(heal_amount,char)
					{
						play_sound(snd_heal,2)	
						if char.hp < char.max_hp
						char.hp = min(char.max_hp,char.hp + heal_amount)
					}
				}
		
			if !string_pos_in_array("{event:heal}",dialogue) 
				do_later(11,var_struct.event_heal,var_struct.event_heal_parameters)
		}
		play_sound(snd_swallow,1)
	}
	else 
	{
		
		if !string_pos_in_array("snd_item",dialogue) && create_textboxes
			play_sound(snd_item)
		
		if type != e_itemtype.item
		{
			if is_missing_text(dialogue[0])
				dialogue[0] = "* You equipped " + item.name + "."
				
			if remove_item
			{
				var inventory = (item.item_type == e_itemtype.armor ? "armor" : "weapon")
				global.stats.inventory[selection] = character_used_on[$inventory]
				character_used_on[$inventory] = get_item_id(selected_item)
			}
		}
	}
	
	if create_textboxes
	{
		if battle 
			return create_battle_textbox(dialogue,var_struct,true)
		else
			return create_textbox(dialogue,var_struct)
	}
}





function custom_item(_var_struct = -1,_item_type = e_itemtype.consumable, _sell_price = 10,_can_drop = true,_remove_after_use = true) constructor
{
	defense = 0 
	attack = 0
	heal_amount = 0
	remove_after_use = _remove_after_use
	sell_price = _sell_price
	can_drop = _can_drop
	item_type = _item_type
	
	if is_struct(_var_struct)
		struct_set_all_self(_var_struct)
}

function consumable_item(healing_amount,_sell_price = 0, _can_drop = true,_turn_into = undefined, _var_struct = undefined) constructor
{
	item_type = e_itemtype.consumable
	heal_amount = healing_amount
	
	if is_defined(_turn_into) 
		turn_into = _turn_into
		
	sell_price = _sell_price
	can_drop = _can_drop	
	
	remove_after_use = true
	
	if is_struct(_var_struct)
	struct_set_all_self(_var_struct)
}

function weapon_item(_attack = 0,_sell_price = 0, _defense = 0, _can_drop = true) constructor
{
	item_type = e_itemtype.weapon
	attack = _attack
	sell_price = _sell_price
	defense = _defense
	can_drop = _can_drop
}


function item_get_dialogue_struct(item_id)
{
	var missing = DEFAULT_MISSING_TEXT
	var missing_struct = 
	{
		name: missing,
		check_description: missing,
		use_description: missing,
	}
	
	return struct_merge_ext(missing_struct,get_lan(lan_items,item_id))
}


enum e_itemtype
{
	consumable,
	item,
	armor,
	weapon
}

function item_dialogue(_name,_check_description,_use_description = undefined,_short_name = undefined,_extra = {}) constructor
{
	name = _name
	short_name = _short_name ?? _name
	if is_defined(_use_description) use_description = _use_description
	check_description = _check_description
	struct_replace_unique(self,_extra)
}

function drop_item(selected_item,selection,var_struct = {})
{
	if selected_item.can_drop 
		array_delete(global.stats.inventory,in_item_selection_vertical,1)
	
	var dialogue = (variable_struct_exists(selected_item,"drop_description") ? selected_item.drop_description : "")
	
	if dialogue = ""
	{
		var lan = get_lan(lan_main_menu)
		
		if selected_item.can_drop 
			dialogue = lan.drop_item_dialogue[(irandom(30) > 3 ? 4 : irandom(3))]
		else 
			dialogue = lan.cant_drop_item_dialogue
	}
	
	return create_textbox(string_replace_all(dialogue,"{item}",selected_item.name),var_struct)
}

function get_number_of_items(inventory = global.stats.inventory)
{
	var item_ary = 0
	for (var i = 0; i < array_length(inventory);i++)
	if inventory[i] != -1 item_ary ++ else break;
	return item_ary
}

function struct_set_all_self(struct)
{
	var names = variable_struct_get_names(struct)
	for (var i = 0; i < array_length(names); i++)
	self[$names[i]] = struct[$names[i]]
}

function get_item_id(item_struct)
{
	var names = struct_get_names(global.items)
	for (var i = 0; i < array_length(names); i++)
	if global.items[$names[i]] == item_struct return names[i]
	return ITEM_ERROR	
}

function string_pos_in_array(array,str)
{
	for (var i = 0; i < array_length(array); i++)
	if string_pos(str,array[i]) return true 
	return false 
}