function scr_init_flags()
{
	global.flags = { 
		has_cell: false,
		ruins: 
		{
			flowey_cutscene_0 : false,
			toriel_walked_0: false, 
			toriel_puzzle_0: false,
			toriel_lever_puzzle: 0,
		},
		glooby: 
		{
			text_entry: "Testing!",
			bloop: 23,
			john: [ 81, { roomba: 22 }, "aa" ]
		}
	}
}