
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

function create_speechbubble(_dialogue,bubble_x = 0,bubble_y = 0,_point_x = x,_point_y = y,max_text_width = 80,_var_struct = {},_get_size_auto = true,width = 0,height = 0, _depth = depth - 10)
{
	var var_struct = 
	{
		get_size_auto: _get_size_auto,
		max_width: width,
		max_height: height,
		can_skip_while_writting: true,
		letter_spacing: 0,
		monospaced: false,
		x:  bubble_x,
		y:  bubble_y,
		point_x: _point_x,
		point_y: _point_y, 
		creator_instance: id,
		max_sentence_width: max_text_width,
		dialogue: _dialogue,
		color: c_black, 
		textbox_position: DOWN,
		draw_bg: false,
		font_current: font_dotumche_10,
		write_speed: 1, 
		talker: global.talker.battle,
		letter_width: 0.5, 
		letter_height: 0.5,
		do_get_details: true,
		line_separation: 20,
		is_speechbubble: true,
		do_extend_box: false,
		event_battle: battle_turn_start,
		can_advance: false,
		depth: _depth,
	}
	
	struct_replace_unique(var_struct,_var_struct)
	
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

function draw_text_mono(x,y,text,spacing = undefined)
{
	if is_undefined(spacing) spacing = string_width("A")		
	
	for (var i = 1; i <= string_length(text); i++)
	draw_text(x + spacing * i,y, string_char_at(text,i))
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
			
			var _var_struct = 
			{
				pos: i,
				can_be_selected: true,
				spared: false,
				my_speechbubble: noone, 
				can_be_spared: false,
				hurt: false,
			}	
			
			var monster_obj = monster_array[i]
			
			if is_struct(monster_obj)
			{
				struct_replace_unique(_var_struct,monster_obj.var_struct)
				monster_obj = monster_obj.monster_object
			}
			global.monsters[i] = instance_create_depth(cam_x + xoff,cam_y + 80,UI_DEPTH + 50,monster_obj,_var_struct)
			
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

function battle_draw_bottom_ui()
{
	#region battle buttons 
	
	var cur = current_character_selections[selected_char_number]
	var disabled_menus = get_unavailable_battle_menus()

	for (var p = 0; p < array_length(global.stats.party); p++)
	for (var i = 0; i < 4; i++)
	{ 
		var current_x = cam_x + 17.5 + (77.5 * i) + (-button_xoffset * 320) + (p * 320) + (i == 0 ? -1.5 : (i == 1 ? -2.5 : 0))
		var current_y = cam_y + 216
	
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
	
	#endregion
	
	#region hp and stats thingy
	var in_a_party = (array_length(global.stats.party) > 1)
	
	if in_a_party 
		scr_battle_draw_party_healthbars()
	else
		scr_battle_draw_player_healthbar()

	draw_reset_color()
	#endregion
}

function scr_battle_draw_player_healthbar()
{
	#region ui bottom
	var char = get_char_by_party_position(0)
		draw_set_font(font_mars_18)
		draw_set_colour(c_white)
		draw_text_transformed(cam_x + 15,cam_y + 200,char.name + "   LV " + string(char.lv),0.5,0.5,0)
		var hp = max(0,char.hp)
		var hp_barwdith_filled = ((char.max_hp * 1.3) / 2) - 1
		var hp_barwdith = clamp((hp >= 0 ? (hp_barwdith_filled * (hp / char.max_hp)) : 0), 0,hp_barwdith_filled)
		draw_text_transformed(cam_x + 147.5 + hp_barwdith_filled - 3, cam_y + 200,string(hp) + " / " + string(char.max_hp),0.5,0.5,0);
		draw_set_color(c_red)
		draw_rectangle_wh(cam_x + 137.5, cam_y + 200,hp_barwdith_filled, 10, false)
		draw_set_color(c_yellow)
		draw_rectangle_wh(cam_x + 137.5, cam_y + 200,hp_barwdith, 10, false)
		draw_set_color(c_white)
		draw_set_font(font_8bit_9)
		draw_text_transformed(cam_x + 128.5,cam_y + 201.5, "P",0.5,0.5,0)
		draw_text_transformed(cam_x + 122, cam_y + 201.5, "H",0.5,0.5,0)
	#endregion
	exit;	
}

function scr_battle_draw_party_healthbars()
{
	static ui_anim = array_create_ext(array_length(global.stats.party),function(i){return!i})

	var ary = array_length(global.stats.party)
	var w = 82 + 10;
	var h = 16; 
	var x_spacing = 20;
	if ary = 3 x_spacing = 5
	var screen_bottom_y = 240;
	var margin = 10; 
	var screen_mid_x = 160
	var total_block_width = (ary * w) + ((ary - 1) * x_spacing);
	var start_x = screen_mid_x - (total_block_width / 2);
	for (var i = 0; i < ary; i++)
	{
		var char = get_char_by_party_position(i)
		var draw_y = cam_y + 3 + -20 + screen_bottom_y - h - margin;
		var draw_x = cam_x + start_x + (i * (w + x_spacing));
		var char_color_start = char.ui_color
		var white = c_white
		var red = c_red
		var s = 0.25
		if i == selected_char_number || battle_started
		{
			if ui_anim[i] < 1  ui_anim[i] += s
			if !battle_started
			draw_sprite(spr_arrow_1,0,draw_x - 16, draw_y + 1)
		}
		else 
		{
			if ui_anim[i] > 0 
				ui_anim[i] -= s
		}
		if char.hp <= 0 
		{
			ui_anim[i] = 0
			var am = 0.5
			char_color_start = merge_colour(c_black,char_color_start,am)	
			white = merge_colour(c_black,c_white,am)
			red = merge_colour(c_black,c_red,am)	
		}
		draw_y += ease_out(ui_anim[i],1,0) * -10
	
		draw_set_colour(merge_colour(merge_colour(c_black,red,0.5),red,ui_anim[i]))
		draw_rectangle_wh(draw_x + 30,draw_y + 8 + 1,18,5,0)
		var char_color = merge_colour(merge_colour(c_black,char_color_start,0.5),char_color_start,ui_anim[i])
		draw_set_colour(char_color)
		draw_rectangle_wh(draw_x,draw_y,w,h,1)
		if char.hp >= 0
		draw_rectangle_wh(draw_x + 30,draw_y + 8 + 1,(char.hp / char.max_hp) * 18,5,0)
		draw_set_color(merge_colour(merge_colour(white,c_black,0.5),white,ui_anim[i]))
		draw_set_font(font_crypt_4)
		draw_text(draw_x + 19,draw_y + 3 + 1,char.name)
		draw_text(draw_x + 19,draw_y + 3 + 6 + 1,"HP")
		draw_set_halign(fa_right)
		draw_text(draw_x + w + -1,draw_y + 4 + -0.5, "LV " + string(char.lv))
		draw_text(draw_x + w + -1,draw_y + 10,char.max_hp)
		draw_sprite_ext(spr_ui_bar,0,draw_x + w + -3 - string_width(char.max_hp), draw_y + 9,1,1,0,draw_get_colour(),1)
		draw_text(draw_x + w + -9 - string_width(char.max_hp),draw_y + 10,char.hp)
		draw_set_halign(fa_left)
		var _sprite = spr_battle_face_default
		var spr = asset_get_index("spr_" + global.stats.party[i] + "_battle_face")
		if sprite_exists(spr)
		_sprite = spr 
		draw_sprite_ext(_sprite,0,draw_x + 9, draw_y + 8,1,1,0,char_color,1)
	}
}

function targetbar_do_damage(character_done_by_pos,monster_attacked_pos,target_x)
{
	var m =  global.monsters[monster_attacked_pos]
	var char = get_char_by_party_position(character_done_by_pos)
		
	var weapon_attack = 0
	if char.weapon != ITEM_EMPTY
	weapon_attack = global.items[$char.weapon].attack
	var armor_attack = 0
	if char.armor != ITEM_EMPTY
	armor_attack += global.items[$char.armor].attack
		
	damage = ((char.attack + weapon_attack + 10) - m.defense) + random(2);

	var bonusfactor = abs(x - target_x);
	
	if instance_exists(obj_targetbarparty)
	{
		if x < target_x - 4
			bonusfactor = -bonusfactor
	}
		
	if (bonusfactor == 0)
	bonusfactor = 1;
        
	var _stretch = (sprite_get_width(spr_target) - bonusfactor) / sprite_get_width(spr_target) 
        
	if instance_number(obj_targetbar) > 1
	{
		var perfect = (bonusfactor <= 4)
		play_sound(perfect ? snd_multibar_notperfect : snd_multibar_notperfcet) 
		if perfect 
		{
			image_blend = c_yellow
			damage *= 2	
		}
	}
	if (bonusfactor <= 12)
	damage = round(damage * 2.2);
        
	if (bonusfactor > 12)
	damage = round(damage * _stretch * 2);
		  
	attacked = true  
	return damage
}

function do_damage_to_monster(monster_target_num,damage)
{
	var m = global.monsters[monster_target_num]

	if damage > 0 
	{
		m.hp -= damage
		m.hurt = true
		instance_create_depth(m.x, m.y - 15, m.depth - 50,obj_slice,{stretch: m.sprite_height});
	}
	
	do_later(20,
	function(m,damage)
	{
		instance_create_depth(m.x, m.y - 54, m.depth - 50, obj_dmgwriter, {target: m, dmg: damage})
		if damage > 0
		instance_create(obj_enemy_attacked_shake,{enemy: m})
	
		do_later(40,function(m)
		{
			if (m.hp <= 0) // enemy died 
			{
				if variable_instance_exists(m,"event_defeated")
					with m event_defeated()
			
				obj_battlecontroler.added_gold += m.added_gold_defeated
				obj_battlecontroler.added_xp += m.added_xp_defeated 
			
				instance_create(obj_vaporized,{target: m})
				m.can_be_selected = false;
			}
		},m)
	
	},[m,damage])
}