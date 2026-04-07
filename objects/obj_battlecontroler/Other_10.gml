////@desc Fight
var cur = current_character_selections[selected_char_number]

battle_draw_menu_with_monster_names(cur,"fight_selection",true)

if interact_key
{
		
	add_battle_action(function(cur)
	{
		with obj_battlebox
		instance_create_depth(x,y,depth - 1,obj_target,
		{
			mytarget: cur.fight_selection
		})	
	},e_battle_priority.attack)
	
	battle_advance_char()
}