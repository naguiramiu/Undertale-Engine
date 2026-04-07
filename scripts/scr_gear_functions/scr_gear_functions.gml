
function create_weapon(_id,_dialogue_struct,_type_of, _added_attack = 0, _added_defense = 0, _added_magic = 0, _sell_price = 10) constructor
{
	id = _id 
	dialogue_struct = _dialogue_struct
	type_of = _type_of 
	sell_price = _sell_price
	added_attack = _added_attack
	added_defense = _added_defense
	added_magic = _added_magic
}

function create_armor(_id,_dialogue_struct, _added_attack = 0, _added_defense = 0, _added_magic = 0, _sell_price = 10) constructor
{
	id = _id 
	dialogue_struct = _dialogue_struct
	sell_price = _sell_price
	added_attack = _added_attack
	added_defense = _added_defense
	added_magic = _added_magic
}

