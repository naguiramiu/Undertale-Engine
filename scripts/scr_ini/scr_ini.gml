function initialize()
{
	declare_items()
	scr_textbox_talkers()
	global.stats =
	{
		party: [e_character.frisk],
		inventory: array_create_fill([ITEM_BANDAGE,ITEM_BISICLE,ITEM_MONSTER_CANDY,ITEM_ERROR,ITEM_STICK,ITEM_TOY_KNIFE],12,ITEM_EMPTY),
		gold: 12,
		lv: 1,
		xp: 0,
		char:
		{
			frisk: new game_character(
				"Frisk", 
				e_character.frisk,
				c_white,
				20,
				ITEM_STICK,
				ITEM_BANDAGE,
			),
			susie: new game_character(
				"Susie",
				e_character.susie,			
				#ff00ff,
				20,
				ITEM_EMPTY,
				ITEM_EMPTY,
			),
			ralsei: new game_character(
				"Ralsei",
				e_character.ralsei,			
				#01ff00,
				20,
				ITEM_EMPTY,
				ITEM_EMPTY,
			)
		}
	}
	
	// temporary

	global.flags = 
	{
		has_cell: false,
	}
	scr_initiate_information()
	scr_initiate_settings()
}