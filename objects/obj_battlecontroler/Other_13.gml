/// @description Mercy

var lan = get_lan(lan_battle)
var cur = current_character_selections[selected_char_number]

if cur.in_submenu2
{
	battle_draw_menu_with_monster_names(cur,"spare_monster_selection")
	
	if interact_key
	{
		add_battle_action(function(cur)
		{
			var lan = get_lan(lan_battle)
			var selected_enemy = scr_battle_get_firstmonster_available(cur.spare_monster_selection)
			var char = get_char_by_party_position(cur.done_by)
		
			var enemy = global.monsters[selected_enemy]
			
			var dial = (array_length(global.stats.party) > 1) ? lan.spare_single_party : lan.spare_single_alone
			
			dial = string_replace_markup_ext(dial,
			{
				char_name: char.name, 
				enemy_name: enemy.name
			})
			
			if variable_instance_exists(enemy,"event_spared")
			enemy.event_spared(enemy)
			
			
			if enemy.can_be_spared
			{
			    create_battle_textbox(dial,,1)
				spare_monster(enemy)
			}
			else 
				create_battle_textbox(dial + "{.}{&}" + lan.spare_single_couldnt,,1)
		},
		e_battle_priority.regular
		)
		battle_advance_char()
	}
	exit;	
}

var has_spared = false
with parent_monster_enemy if can_be_selected if can_be_spared has_spared = true 

if interact_key
{
	if !cur.mercy_selection // sparing
	{
		play_sound(snd_select)
		
		if SPARE_ALL_MONSTERS
		{
			add_battle_action(function(cur)
			{
				with parent_monster_enemy
				if can_be_spared	
				{
					if variable_instance_exists(id,"event_spared")
						event_spared(id)
					spare_monster(id)
				}
				battle_next_action()
			},
			e_battle_priority.regular
			)
			battle_advance_char()
		}
		else
		cur.in_submenu2 = true;
	}
	else // fleeing
	{
		add_battle_action(function(cur)
		{
			var lan = get_lan(lan_battle)

			var flee_chance = 50
			var char = get_char_by_party_position(cur.done_by) 
			if (irandom(100) < flee_chance)
			{
				var fleetext = lan.flee_text_default
				var extra = lan.flee_text_lowchance
				if !irandom(100) 
				fleetext = extra[irandom(5)]
				create_battle_textbox(fleetext,{can_skip: false,can_advance: false},false)
				lerp_var_ext(obj_camera,"screen_darken",0.025,0,1)
				do_later(80,battle_end,,obj_battlecontroler)
				//audio_sound_gain(music,0,2000)
				play_sound(snd_escaped)
				
				var flee = instance_create_depth(cam_x + 36, cam_y + 161 - 5, depth - 10,obj_empty)
				with flee
				{
					sprite_index = spr_soul_flee
					hspeed = -1.5
					image_speed = 0.2
					image_xscale = 0.5
					image_yscale = 0.5
					event_battle_end = instance_destroy
				}
			} 
			else 
			{	
				var dial = (array_length(global.stats.char) > 1) ? lan.flee_dialogue_party : lan.flee_dialogue_alone
				create_battle_textbox(string_replace_markup(dial,char.name),,1)	
			}
		}) 
		battle_advance_char()
	}
}

if can_flee 
{
	if up_key_press || down_key_press
	{
		cur.mercy_selection = !cur.mercy_selection	
		play_sound(snd_menu_move)
	}
}

var mercyoptions =  ["Spare","Flee"]

draw_set_font(font_deter_12)
draw_set_colour(has_spared ? c_yellow : c_white)
draw_text_jitter(cam_x + 50,cam_y + 136 , "* Spare")
draw_reset_color()
if can_flee
draw_text_jitter(cam_x + 50,cam_y +  136 + 16 , "* Flee")
draw_sprite_ext(spr_soul,soul_frame,cam_x + 36,cam_y + 143 + (16 * cur.mercy_selection),0.5,0.5,0,c_white,1)