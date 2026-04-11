function get_char_by_party_position(pos, stats = global.stats)
{
	return get_char_by_id(stats.party[pos],stats)
}

function get_char_by_id(character_id,stats)
{
	return stats.char[$character_id]
}

#macro CHARACTER_FRISK "frisk"
#macro CHARACTER_TORIEL "toriel"

function game_character(_name,_ui_color,_max_hp = 20,_weapon_slot = ITEM_EMPTY, _armor_slot = ITEM_EMPTY,_base_defense = 0, _base_attack = 0,_starting_lv = 1) constructor
{
	name = _name
	ui_color = _ui_color
	max_hp = _max_hp
	weapon = _weapon_slot
	armor = _armor_slot
	hp = _max_hp
	attack = _base_defense
	defense = _base_attack
	lv = _starting_lv
	xp = 0
}