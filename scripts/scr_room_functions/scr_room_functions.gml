function scr_room_area_contains(room_area,area)
{
	if !is_array(room_area) return (room_area == area)
	else return array_contains(room_area,area)
}
function room_get_custom_info(rm_id)
{
	if !room_exists(rm_id) return room_get_custom_info(rm_dogcheck) // replace with missing room
	var var_struct = 
	{
		room_name: room_get_name(rm_id),
		area_id: AREA_NONE,
		x: room_width / 2,
		y: room_height / 2,
		room_id: rm_id
	}
	var lan = get_lan(lan_room_name)
	
	if variable_struct_exists(lan,room_get_name(rm_id))
		var_struct.room_name = lan[$room_get_name(rm_id)]

	var room_info = room_get_info(rm_id,false,true,false,false,false,true)
	var_struct.x = room_info.width / 2
	var_struct.y = room_info.height / 2

	var instances = room_info.instances
	for (var i = 0; i < array_length(instances); i++)
	{
		var _obj = asset_get_index(instances[i].object_index)
		 
		if (_obj == obj_room_spawn)
		{
			var_struct.x = instances[i].x 
			var_struct.y = instances[i].y 
		}
		else if (object_get_parent(_obj) == obj_parent_area) || (_obj == obj_parent_area)
		{
			var check = 
			{
				set_area: true
			}
			if instances[i].pre_creation_code != -1 
					with check method_call(instances[i].pre_creation_code)
			if check.set_area
			{
				switch _obj
				{
					case obj_ruins_area: 
					var_struct.area_id = AREA_RUINS
					break;
					case obj_dev_area: 
					var_struct.area_id = AREA_DEV
					default: 
					var_struct.area_id = AREA_NONE
					break;
				}
				
			}
		}
	}
	return var_struct
}