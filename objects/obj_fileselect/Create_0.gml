depth = UI_DEPTH + 3
selection = 0
selecting = false 
in_selection = 0
bottom_selecting = false
bottom_selection = 0
file_copying_from = -1

event_user(0)
set_menu(e_fileselect_menu.base,0,0)

move = function()
{
	var in_bottom = bottom_selecting
	
	if !bottom_selecting && !selecting
	{
		var prev = selection
		if down_key_press 
		{
			selection ++
			if selection == NUMBER_OF_SAVEFILES
			{
				play_sound(snd_menu_move)
				bottom_selecting = true 
				selection = NUMBER_OF_SAVEFILES - 1
			}
		}
		if up_key_press
			selection = max(0,selection -1)
		
		if prev != selection play_sound(snd_menu_move)
	}
	if !in_bottom exit;
	var b_menu = current_menu.bottom_menu
	var bottom_count = array_length(b_menu)
	var prev_selection = bottom_selection
	var changed_row = false 
	var bottom_row = (prev_selection div 3)
	var bottom_number_of_rows = bottom_count div 3
	
	if down_key_press && bottom_row != bottom_number_of_rows
	{
		changed_row = true 
		prev_selection += 3
	}
	
	if up_key_press 
	{
		if bottom_row != 0
		{
			changed_row = true 
			prev_selection -= 3
		}
		else 
		{
			bottom_selecting = false
			play_sound(snd_menu_move)	
		}
	}
	if bottom_selecting // silly code 
	{
		var b_mov = function(add_to = 1,bottom_row,prev_selection,bottom_number_of_rows,bottom_count)
		{
			var ary = ((bottom_row == bottom_number_of_rows) ? (bottom_count % 3) : 3)
			if ary == 0 ary = 3
			prev_selection -= bottom_row * 3
			prev_selection += add_to
			while !current_menu.bottom_menu[prev_selection + (bottom_row * 3)].available
			{
				if add_to == 1 
				{
					if prev_selection + (bottom_row * 3) >= bottom_count
					{
						prev_selection = bottom_selection
						break;
					}
				prev_selection = (prev_selection + 1) % ary 
				}
				else prev_selection = ((prev_selection - 1) + ary) % ary 
			}
			prev_selection += (bottom_row * 3)
			return prev_selection
		}
		
		if (right_key_press && (prev_selection % 3) != 2) && bottom_count > prev_selection + 1
		prev_selection = b_mov(1,bottom_row,prev_selection,bottom_number_of_rows,bottom_count)
		
		if left_key_press && (prev_selection % 3) != 0 
		prev_selection = b_mov(-1,bottom_row,prev_selection,bottom_number_of_rows,bottom_count)

		if changed_row && (prev_selection >= bottom_count || !b_menu[prev_selection].available)
		{
			for (var i = 1; i <= 2; i++)
			{
				for (var check = -1; check <= 1; check += 2)
				{
					var to_check = prev_selection + (check * i)
					if (to_check < bottom_count && to_check >= 0)
					&& (to_check div 3) == (prev_selection div 3)
					{
						if b_menu[to_check].available
						prev_selection = to_check
					}
				}
			}
		}
		
		if bottom_selection != prev_selection
		{
			bottom_selection = prev_selection 
			play_sound(snd_menu_move)
		}
	}
}

