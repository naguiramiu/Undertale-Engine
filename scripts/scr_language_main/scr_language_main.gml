function scr_language_main()
{
	
	global.language_text = {language_code: "EN"}
	#macro lan_room_name "room_names"
	
	global.language_text[$lan_room_name] = 
	{
		rm_dev_testingarea: "Testing Area",
		rm_ruins_first_flowey_encounter: "Ruins - Flowey 0",
		rm_ruins_startingroom: "Ruins - Flower bed",
		rm_ruins_staircase: "Ruins - Entrance",
		rm_ruins_puzzle_0: "Ruins - Puzzle 0",
		rm_ruins_firstencounter: "Ruins - First encounter"
	}
	
	#macro lan_battle "battle"

	global.language_text[$lan_battle] = 
	{
		buttons: ["FIGHT","ACT","ITEM","MERCY"],
		flee_dialogue_alone: "* You tried to escape, but were unsuccessful.",
		flee_dialogue_party: "* {char} tried to escape, but was unsuccessful.",
		flee_text_default: "* Escaped...",
		flee_text_lowchance: [ "* I need to go.", "* Don't slow me down.", "* I'm outta here.", "* I've got better to do."],
		spare_single_couldnt: "* But its name wasn't {col:yellow}YELLOW{/col}...",
		spare_single_alone: "* You spared {enemy_name}!",
		spare_single_party: "* {char_name} spared {enemy_name}!",
	}
	
	#macro lan_main_menu "main_menu"
	
	global.language_text[$lan_main_menu] = 
	{
		menu_item: "ITEM",
		menu_stat: "STAT",
		menu_cell: "CELL",
		gold_lan: "G",
		lv_lan: "LV",
		hp_lan: "HP",
		stats: 
		{
			name: "\"{name}\"", 
			lv: "LV  {lv}",
			hp: "HP  {hp} / {max_hp}",
			attack:  "AT  {attack} ({item_attack})",
			defense: "DF  {defense} ({item_defense})",
			xp: "EXP: {xp}",
			next: "NEXT: {next}",
			weapon: "WEAPON: {weapon}",
			armor: "ARMOR: {armor}",
			gold: "GOLD: {gold}"
		}, 
		name_was_edited_response: "Easy to change, huh?",
		empty_slot: "EMPTY",
		drop_item_dialogue:
		[
			"* You bid a quiet farewell to the {item}.",
			"* You put the {item} on the ground and give it a little pet.",
			"* You threw the {item} on the ground like the piece of trash that it is.",
			"* You abandoned the {item}",
			"* The {item} was thrown away."
		],
		cant_drop_item_dialogue: "* You don't feel like throwing {item} away.",
		use: "USE",
		info: "INFO",
		drop: "DROP",
	}
	
	#macro lan_savescreen "savescreen"
	
	global.language_text[$lan_savescreen] = 
	{
		room_text: 
		{
			rm_dev_testingarea: "* (Finding yourself in a room of developer things...){.&}* (Fills you with dread. yeah.)",
			rm_ruins_startingroom: "* (The thought that this is just the start of your journey fills you with determination.)",
			rm_ruins_staircase: "* (The shadow of the ruins looms above, filling you with determination.)"
		}
		
	}
	
	scr_language_set_items()
	scr_language_set_title()
	
	
	////uncomment this to see which strings are set in the languages or nott
	//scr_test_language_text(global.language_text)
	
	//write a default english script
	file_write_all_text(working_directory + "Languages\\English.json",json_stringify(global.language_text,true))
}