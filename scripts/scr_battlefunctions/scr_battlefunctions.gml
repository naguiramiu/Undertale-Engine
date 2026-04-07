
function create_battle_textbox(_dialogue,var_struct = {},start_battle = false)
{
	with var_struct
	{	
		goo = true
		dialogue = _dialogue 
		textbox_positon = DOWN
		draw_bg = false
		texteffect_nervous = true
		x = -3.5 
		y = -35
		talker = global.talker.battle
		line_separation = 16
		if start_battle event_battle = battle_next_action
	}
	return instance_create(obj_textbox,var_struct)
}


function enemy_act(_name,_dialogue,_set_can_spare = -1,_next_speechbubble = [],_event = -1,_event_dialogue_destroy = -1) constructor 
{
	if _event_dialogue_destroy != -1 
	event_dialogue_destroy = _event_dialogue_destroy
	
	next_speechbubble = _next_speechbubble
	set_can_spare = _set_can_spare
	name = _name 
	dialogue = _dialogue
	event = _event // (monster,char (struct),cur.done_by)
}

function check_enemy_desc(dialogue = "",_name = name,atk = attack,def = defense )
{
	var str = "* {name} - ATK {atk} DEF {def} -{.}{&}"
	str = string_replace_markup_ext(str,{name: _name, atk: atk, def: def})	
	return str + dialogue
}

function get_nex_lvl(lv)
{
    var _vals = [0, 10, 20, 40, 50, 80, 100, 200, 300, 400, 500, 800, 1000, 1500, 2000, 3000, 5000, 10000, 25000, 49999];
    return _vals[clamp(lv, 0, 19)];
}

function create_speechbubble(_dialogue,bubble_x = 0,bubble_y = 0,_point_x = x,_point_y = y,max_width = 170,_var_struct = {})
{
	var var_struct = 
	{
		x:  bubble_x,
		y:  bubble_y,
		point_x: _point_x,
		point_y: _point_y,
		creator_instance: id,
		max_sentence_width: max_width,
		dialogue: _dialogue,
		color: c_black, 
		textbox_position: DOWN,
		draw_bg: false,
		font_current: font_dotumche_10,
		write_speed: 0.5, 
		talker: global.talker.battle,
		letter_width: 0.5, 
		letter_height: 0.5,
		max_sentence_width: 100,
		do_get_details: true,
		line_separation: 18,
		is_speechbubble: true,
		do_extend_box: false,
		event_battle: battle_turn_start,
		can_advance: false,
	}
	var vars = variable_struct_get_names(_var_struct)
	for (var i = 0; i < array_length(vars); i++)
	var_struct[$vars[i]] = _var_struct[$vars[i]]
	
	var speechbubble = instance_create_depth(0,0,depth - 1,obj_textbox,var_struct)
	
	set_later(5,speechbubble,"can_advance",true)
	
	with speechbubble
	{
		other.my_speechbubble = id 
		return id
	}
} 

function check_battleend() 
{
	if !variable_struct_exists(global,"monsters") return false
	var num_defeated = 0
	var ary = array_length(global.monsters)
	for (var i = 0; i < ary; i++)
	if !global.monsters[i].can_be_selected num_defeated ++
	return (num_defeated == ary)
}

function turn_set_length(timer)
{
	obj_battlecontroler.turn_length = timer
}

function turn_get_length()
{
	return (instance_exists(obj_battlecontroler) ? obj_battlecontroler.turn_length : -1)
}

function turn_get_percentage()
{
	return ((turn_get_timer() / turn_get_length()) * 100);	
}

function turn_get_timer()
{
	return (instance_exists(obj_battlecontroler) ? obj_battlecontroler.turn_timer : -1);
}

function monster_sum()
{
	var n = 0 
	with parent_monster_enemy
	if can_be_selected n ++
	return n
}

function monster_is_alive(monster_object_index_or_id)
{
	var is = 0 
	with monster_object_index_or_id 
	if can_be_selected
		is ++
	return is;
}

function self_enemy_can_attack()
{
	if !instance_exists(obj_battlecontroler) return false 
	if obj_battlecontroler.turn_timer != -1 && instance_exists(obj_soul)
	if self.can_be_selected return true 
	return false 
}



function get_unavailable_battle_menus()	
{
	var disabled_menus = ((global.stats.inventory[0] == ITEM_EMPTY) ? [e_battle_menus.item] : [])
	
	return disabled_menus
}

function battle_draw_menu_with_monster_names(cur,selection_name,show_hp = false)
{
	var ary = array_length(global.monsters)
	var cant = []
	for (var i = 0; i < array_length(global.monsters); i++)
	if !global.monsters[i].can_be_selected array_push(cant,i)
	var prev = cur[$selection_name]
	prev = modwrap(prev,0,ary,cant)
	if down_key_press prev = modwrap(prev,1,ary,cant)
	if up_key_press prev = modwrap(prev,-1,ary,cant)
	if prev != cur[$selection_name]
	{
		cur[$selection_name] = prev
		play_sound(snd_menu_move)
	}
	for (var i = 0; i < ary; i++)
	with global.monsters[i]
	{
		if i == cur[$selection_name]
		draw_sprite_ext(spr_soul,0,cam_x + 36,(cam_y) + 143 + (16 * i),0.5,0.5,0,c_white,1)
		var col = can_be_spared ? c_yellow : c_white
		if !can_be_selected col = c_gray;
		draw_set_color(col)
		draw_set_font(font_deter_12)
		draw_text(cam_x + 50,(cam_y) +  136 + (16 * i), "*") 
		draw_text_jitter(cam_x + 66,(cam_y) +  136 + (16 * i), name) 
		
		if show_hp && can_be_selected
		{
			draw_set_colour(c_red)
			draw_rectangle_wh(cam_x + 143,cam_y + 140 + 16 * i,49.5,7.5)
			draw_set_colour(c_lime)
			draw_rectangle_wh(cam_x + 143,cam_y + 140 + 16 * i,(hp / max_hp) * 49.5,7.5)
		}
	}
}

function battle_draw_menu_with_party_names(cur,selection_name = "item_char_selection")
{
	var p = global.stats.party 
	var ary = array_length(p)
	cur[$selection_name] = scr_updown_modwrap(cur[$selection_name],ary)
	for (var i = 0; i < ary; i++)
	{
		var char = get_char_by_party_position(i)
		if i == cur[$selection_name]
		draw_sprite_ext(spr_soul,0,cam_x + 36,cam_y + 143 + (16 * i),0.5,0.5,0,c_white,1)
		draw_set_color(c_white)
		draw_set_font(font_deter_12)
		var text_x = cam_x + 50
		var y_offset =  cam_y + (16 * i)
		draw_text(text_x,136 + y_offset, "*")
		draw_text_jitter(text_x + 16,136 + y_offset, char.name)
	}
}
function add_battle_action (_func,_priority = e_battle_priority.regular)
{
	play_sound(snd_select)
	var cur = current_character_selections[selected_char_number]
	cur.prev_inventory = array_copy_simple(global.stats.inventory)
	cur.done_by = selected_char_number
	actions[selected_char_number] = {}
	with actions[selected_char_number]
	{
		func = _func 
		priority = _priority 
		done_by = other.selected_char_number
	}
}

function spawn_monsters(monster_array)
{
		var ary = array_length(monster_array)
		var w = 320
		var pad = 20
		for (var i = 0; i < ary; i++)
		{
			var xoff = -pad + ((w + pad*2) / (ary + 1)) * (i + 1);

			global.monsters[i] = instance_create_depth(cam_x + xoff,cam_y + 80,UI_DEPTH + 50,monster_array[i],
			{
				pos: i,
				can_be_selected: true,
				spared: false,
				my_speechbubble: noone, 
				can_be_spared: false,
			}) 
		}
}

function battle_firstmonster_available(start)
{
	var true_start = start 
	while !global.monsters[start].can_be_selected
	{
		start = (start + 1) % array_length(global.monsters)
		if start == true_start 
		{
			show_message("Error: somehow none of the monsters are avaiable")
			break;
		}
	}
	return start 
}

function spare_monster(monster_num)
{
	if is_real(monster_num) monster_num = global.monsters[monster_num]
	
	with monster_num 
	{
		spared = true 
		can_be_selected = false
		instance_create_depth(x,y,depth - 1,obj_spare_monster,{target_instance: id})
		obj_battlecontroler.added_gold += added_gold_mercy
		if variable_instance_exists(id,"event_mercy") event_mercy()
	}
}

function scr_enemy_align_to_grid_x(_x)
{
    return cam_x + (((_x - cam_x) div 50) * 50) + 7.5;
}

function battle_use_item(cur,use_on = 0)
{
		var itm_true = cur.item_selection + (cur.item_page * 4)
		// adds the battle action to use the item later.
		add_battle_action(function(cur)
		{
			var itm_true = cur.item_selection + (cur.item_page * 4)
			use_item_main(
					cur.selected_item,itm_true,,
					true,false,
					cur.done_by,
					cur.item_char_selection,
					true
				)
		},
		e_battle_priority.regular
		)
		
		cur.selected_item = global.items[$global.stats.inventory[itm_true]]
		cur.item_char_selection = use_on

		var item = global.items[$global.stats.inventory[itm_true]]
		use_item_main(
				item,itm_true,,
				false,true,
				cur.done_by,
				cur.item_char_selection,
				true
			)
			
		inventory_clear_empty()	
		battle_advance_char()
}

function check_perfom_event(event_name)
{
	if !string_starts_with(event_name,"event_")
	event_name = "event_" + event_name
	
	if var_id_exists(event_name)
	{
		method_call(var_id_get(event_name),customevent_get_params(event_name))
	}
}
