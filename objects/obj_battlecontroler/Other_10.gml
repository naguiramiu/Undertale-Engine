////@desc Fight
var cur = current_character_selections[selected_char_number]

battle_draw_menu_with_monster_names(cur,"fight_selection",true)

if interact_key
{
	add_battle_action(function(cur)
	{
		if (array_length(global.stats.party) == 1)
		{
			with obj_battlebox
			instance_create_depth(x,y,BATTLE_DEPTH - 20,obj_target_party,
			{
				mytarget: cur.fight_selection
			})	
		}
		else 
		{
			var target = instance_exists(obj_target_party) ? obj_target_party : instance_create(obj_target_party)
			
			array_push(target.attacking,
			{
				party_member_attacking: selected_char_number,
				target_monster: cur.fight_selection,
				done_damage: false, 
				damage: 0,
			})
			
			if (array_length(actions) == 0)
			{
				battle_started = true
				with target 
				{
					visible = true
					event_user(0)	
				}
			}
			else
				battle_next_action()
		}
	},e_battle_priority.attack)
	
	battle_advance_char()
}