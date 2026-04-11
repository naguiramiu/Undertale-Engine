while !global.monsters[mytarget].can_be_selected
mytarget = modwrap(mytarget,1,array_length(global.monsters))

do_later(6,function()
{
	var number_of_bars = 1
	var char = get_char_by_party_position(0)
	if char.weapon != ITEM_EMPTY
	{
		var weapon = global.items[$char.weapon]
		if variable_struct_exists(weapon,"number_of_attack_bars")	
		number_of_bars = weapon.number_of_attack_bars
	}
	
	for (var i = 0; i < number_of_bars; i++)
	{
		var dir = choose(-1,1)
		instance_create_depth(((10 * dir) * i) + x + (sprite_width / 2) * dir, y,depth - 1, obj_targetbar);
	}
})

fade = false
damage = 0
attackspeed = 3 + random(3)
done_damage = false