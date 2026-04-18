function array_average(array) 
{
    var ary = array_length(array)
    if !ary return 0
    
    var sum = 0
    for (var i = 0; i < ary; i++) 
        sum += array[i]
    
    return sum / ary
}

function array_create_fill(val_array,size,_default)
{
	var ar = []
	for (var i = 0; i < size; i ++)
	if i < array_length(val_array)
		ar[i] = val_array[i] 
	else ar[i] = _default
	return ar
}

function array_find_closest(val, array) 
{
    var ary = array_length(array)
    if !ary return val

    var closest = array[0]
    var min_diff = abs(val - closest)

    for (var i = 1; i < ary; i++) 
	{
        var current_diff = abs(val - array[i])
        if (current_diff < min_diff)
		{
            min_diff = current_diff
            closest = array[i]
        }
    }
    return closest
}

function inventory_clear_empty(inventory = global.stats.inventory) 
{
    var pos = 0
    var ary = array_length(inventory)
    for (var i = 0; i < ary; i++) 
    {
        if (inventory[i] != ITEM_EMPTY) 
        {
            inventory[pos] = inventory[i]
            pos++
        }
    }
    while (pos < ary) 
    {
        inventory[pos] = ITEM_EMPTY
        pos++
    }
}

function rooms_get_info() 
{
	var r = []
		var room_index = room_first
			while room_index != -1
			{
				var s = room_get_custom_info(room_index)
				array_push(r, s)
			 room_index = room_next(room_index) 
			}
	return r
}

 function array_remove_value_ext(array,func)
{
	for (var i = 0; i < array_length(array); i++)
	if func(i,array[i])
	{
		array_delete(array,i,1)
		array_remove_value_ext(array,func)
	}	
}

function array_create_struct_unique(size,struct)
{
	var new_array = []
	for (var i = 0; i < size; i++)
		{
			new_array[i] = {}
			var names = struct_get_names(struct)
			for (var j = 0; j < array_length(names); j++)
			new_array[i][$names[j]] = struct[$names[j]]
		}
	return new_array
}

function array_copy_simple(array)
{
	var new_array = []
	for (var i = 0; i < array_length(array); i ++)	
	new_array[i] = array[i]
	return new_array
}

