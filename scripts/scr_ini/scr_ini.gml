function initialize()
{
	declare_items()
	scr_textbox_talkers()
	global.stats =
	{
		party: [CHARACTER_FRISK],
		inventory: array_create_fill([ITEM_BANDAGE,ITEM_BISICLE,ITEM_MONSTER_CANDY,ITEM_ERROR,ITEM_STICK,ITEM_TOY_KNIFE],12,ITEM_EMPTY),
		gold: 12,
		lv: 1,
		xp: 0,
		char:
		{
			CHARACTER_FRISK: new game_character(
				"Frisk", 
				c_white,
				20,
				ITEM_STICK,
				ITEM_BANDAGE,
			),
			CHARACTER_SUSIE: new game_character(
				"Susie",
				#ff00ff,
				20,
				ITEM_EMPTY,
				ITEM_EMPTY,
			),
			CHARACTER_RALSEI: new game_character(
				"Ralsei",
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
		ruins: 
		{
			flowey_cutscene_0 : false,
			
		}
	}
	scr_initiate_information()
	scr_initiate_settings()
}