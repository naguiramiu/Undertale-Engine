function scr_language_set_items()
{
	#macro lan_items "items"
	global.language_text.items = {
		ITEM_ERROR: new item_dialogue(
			"Error item",
			"* \"Error!\" - {.&}* You are not meant to have this.",
			"* This was not meant to be used.",
		),
		ITEM_BANDAGE: new item_dialogue(
			"Bandage",
			"* \"Bandage\" - Heals 10 HP{.&}* It has already been used many times.",
			"* You re-applied the bandage.{.&}* Still kind of gooey."
		),
		ITEM_MONSTER_CANDY: new item_dialogue( 
			"Monster Candy",
			"* \"Monster Candy\" - Heals 10 HP{,&}* Has a distinct, non-licorice flavor.",
			["* You ate the Monster Candy.{.&}* Very un-licorice-like.","* You ate the Monster Candy{.&}* ....{.&}* tastes like licorice."],
			"MnstrCndy"
		),
		ITEM_STICK: new item_dialogue(
			"Stick",
			"* \"Stick\" - Weapon AT 0{,&}* Its bark is worse than its bite.",
			"* You threw the stick away.{.&}* Then picked it back up."
		),	
		ITEM_BISICLE: new item_dialogue( 
			"Bisicle",
			"* \"Bisicle\" - Heals 11 HP{,&}* It's a two-pronged popsicle, so you can eat it twice.",
			"* You eat one half of the Bisicle."
		),
		ITEM_UNISICLE: new item_dialogue( 
			"Unisicle",
			"* \"Unisicle\" - Heals 11 HP{,&}* It's a SINGLE-pronged popsicle.{.} Wait, that's just normal...",
			"* You ate the Unisicle."
		),
		ITEM_TOY_KNIFE: new item_dialogue( 
			"Toy Knife",
			"* \"Toy Knife\" - Weapon AT 3{,&}* Made of plastic. A rarity nowadays."
		)
	}
}