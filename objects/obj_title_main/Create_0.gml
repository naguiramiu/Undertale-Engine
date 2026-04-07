file = savefile_basic_information(savefile_number)
depth = -120
selection = 0
top_selection = 0
whiten = 0
can_move = true
event_user(0)
move = NUMBER_OF_SAVEFILES > 1 ? 
function()
{
	selection = scr_updown_modwrap(selection,4,,,2)
	selection = scr_leftright_modwrap(selection,4)
}:
function()
{
	var prev = selection
	if right_key_press selection = (selection != 1)
	if left_key_press selection = (selection == 0)
	if down_key_press || up_key_press
	{
		if selection == 2 
			selection = top_selection
		else 
		{
			top_selection = selection
			selection = 2 
		}
	}
	if prev != selection
		play_sound(snd_menu_move)
}

event_user(1)