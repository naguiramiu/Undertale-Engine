function declare_items()
{
	// you must have an item id for each item
	#macro ITEM_EMPTY -1
	#macro ITEM_ERROR "error"
	#macro ITEM_BANDAGE "bandage"
	#macro ITEM_MONSTER_CANDY "monster_candy"
	#macro ITEM_STICK "stick"
	#macro ITEM_BISICLE "bisicle"
	#macro ITEM_UNISICLE "unisicle"
	#macro ITEM_TOY_KNIFE "toy_knife"
	
	var lan = get_lan(lan_items)
	global.items = 
	{
		ITEM_ERROR: new custom_item(), 
		ITEM_BANDAGE: new custom_item({ heal_amount: 10, defense: 0 },,150),
		ITEM_STICK: new custom_item({ attack: 0 }, e_itemtype.item, 150,,false),
		ITEM_MONSTER_CANDY: new consumable_item(10,25,,,{dialogue_event: function(this) {this.use_description = this.use_description[irandom(15) <= 2]}}),
		ITEM_BISICLE: new consumable_item(11,5,true,ITEM_UNISICLE),
		ITEM_UNISICLE: new consumable_item(11,2),
		ITEM_TOY_KNIFE: new weapon_item(3,100)
	}
	
	struct_foreach(global.items,function(key,val){
		struct_add_unique(val,item_get_dialogue_struct(key))
	})
}