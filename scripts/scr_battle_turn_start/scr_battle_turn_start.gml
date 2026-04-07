///@desc Turn start
function battle_turn_start()
{
	with obj_battlecontroler
	{
		var speechbubble_exits = false 
		if instance_exists(obj_textbox) with obj_textbox 
		if is_speechbubble && !is_destroyed speechbubble_exits = true 
		if speechbubble_exits exit
		obj_soul.can_move = true
		turn_timer = 0
		with parent_monster_enemy if variable_instance_exists(id,"event_turn_start")
		event_turn_start()
	}
}