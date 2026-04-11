function initialize()
{
	global.stats =
	{
		party: [CHARACTER_FRISK],
		inventory: array_create_fill([ITEM_BANDAGE,ITEM_BISICLE,ITEM_MONSTER_CANDY,ITEM_STICK,ITEM_TOY_KNIFE],8,ITEM_EMPTY),
		gold: 12,
		char:
		{
			CHARACTER_FRISK: new game_character(
				"Frisk", 
				c_white,
				20,
				ITEM_STICK,
				ITEM_BANDAGE,
			),
			CHARACTER_TORIEL: new game_character(
				"Toriel",
				#A864A9,
				120,
				ITEM_EMPTY,
				ITEM_EMPTY,
				10,
				0,
				12
			),
		}
	}
	
	global.flags = 
	{
		has_cell: false,
		ruins: 
		{
			flowey_cutscene_0 : false,
			toriel_walked_0: false, 
			toriel_puzzle_0: false,
		}
	}
	
	declare_items()
	scr_textbox_talkers()
	scr_initiate_information()
	scr_initiate_settings()
	scr_setup_encounters()
}