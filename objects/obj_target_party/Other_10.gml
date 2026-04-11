attacking = array_shuffle(attacking)

var cx = 0
for (var i = 0; i < array_length(attacking); i++)
{
	var dist = 10 + irandom(10)
	var spd = 3 + random(2)
	var ammount = 1 + irandom(2)
	var char = get_char_by_party_position(i)
	if char.weapon != ITEM_EMPTY
	{
		var weapon = global.items[$char.weapon]
		if variable_struct_exists(weapon,"number_of_attack_bars")	
		ammount = weapon.number_of_attack_bars
	}
	
	attacking[i].bars = []
	
	for( var a = 0; a < ammount; a ++)
	{
		with instance_create_depth((x + obj_battlebox.width * 0.75) + cx, y + 30 * i, depth - 10, obj_targetbarparty,
		{
			hspeed: -spd,
			target: attacking[i].target_monster,
			character_done_by: attacking[i].party_member_attacking
		})
			array_push(other.attacking[i].bars,id)
			
		cx += dist * 2
	}
	cx += dist * 2
} 