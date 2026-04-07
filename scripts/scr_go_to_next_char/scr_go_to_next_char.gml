function battle_advance_char()
{
	selected_char_number ++ // advance char
	
	// check if the new chars hp is not 0, if it is skip this char 
	while selected_char_number < array_length(global.stats.party) && (get_char_by_party_position(selected_char_number).hp <= 0)
		selected_char_number ++ 
	
	// if char reached the number of chars, sort the actions
	if selected_char_number == array_length(global.stats.party)
	{
		controler_can_move = false
		selected_char_number --
		battle_sort_actions()
	}
	else // else go to next char
	{
		if array_length(global.stats.party) > 1
			menu_buttons_lerp(selected_char_number) // cool animation 
		interact_key = false 
		flavor_text_reset() // reset the flavor text 
		with current_character_selections[selected_char_number] // wrap unavailable menus
		main_menu_selection = modwrap(main_menu_selection,0,4,get_unavailable_battle_menus(other.selected_char_number))
	}
}