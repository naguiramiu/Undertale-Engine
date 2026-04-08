/// @description Next action

function battle_next_action()
{
	if check_battleend()
	{
		battle_win()
		exit;
	}
	if array_length(obj_battlecontroler.actions) == 0
		battle_end_actions()
	else
	with array_pop(obj_battlecontroler.actions)
	{
		obj_battlecontroler.selected_char_number = done_by
		func(obj_battlecontroler.current_character_selections[done_by])	
	}
}