function get_char_by_party_position(pos, stats = global.stats)
{
	return get_char_by_id(stats.party[pos],stats)
}

function get_char_by_id(character_id,stats)
{
	return stats.char[$character_id]
}

#macro CHARACTER_FRISK "frisk"
#macro CHARACTER_SUSIE "susie"
#macro CHARACTER_RALSEI "ralsei"

function game_character(_name,_ui_color,_max_hp = 20,_weapon_slot = ITEM_EMPTY, _armor_slot = ITEM_EMPTY) constructor
{
	name = _name
	ui_color = _ui_color
	max_hp = _max_hp
	weapon = _weapon_slot
	armor = _armor_slot
	hp = max_hp
	attack = 0
	defense = 0
}