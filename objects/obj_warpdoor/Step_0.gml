if interact_key_press && get_player_direction() == UP
if place_meeting(x,y,player) && can_open_textbox()	
{
	if !open 
	create_textbox("* (It's a lone doorframe.){.&}* (But for some reason, you can't see through it...)")
	else 
	{
		var _options = []
		for (var i = 0; i < array_length(places); i++)
		_options[i] = textbox_option(places[i].name,func,places[i].room)
		
		create_textbox
		(
			["* (It's a door.){.&}* (Where will you go?)",""],
			{
				options: _options,
				let_player_move_end: false,
				options_diagonal: true
			}
		)
	}
}