/// @description Setup functions
setting = function(_title,_var_name,_default,_type,_from = obj_devmenu_debug,_custom_func = -1) constructor
{
	draw_underline = false
	title = _title
	var_name = _var_name
	from = _from
	default_type = _default
	if _from == obj_devmenu_debug
	{
		if !variable_instance_exists(obj_devmenu_debug,_var_name)
		variable_instance_set(obj_devmenu_debug,_var_name,_default)
	}
	type = _type
	custom_func = _custom_func
}

array_val_name = function(_var,i)
{
	return "Index " + string(i) + ": " + "(" + string_capitalize(typeof(_var))  + ") "
}

slider_setting = function(_title,_var_name,_from = obj_devmenu_debug,_min,_max,_default = 0) constructor
{
	draw_underline = false
	struct_set_all_self(new setting(_title,_var_name,_default,e_settingstype.slider,_from))
	in_min = _min
	in_max = _max
}

set_menu_setting = function(_title,_settings,_func,_params = []) constructor
{
	var_name = "n"
	draw_underline = true
	title = _title
	menu = 
	{
		settings: _settings,
		title: _title,
		func: _func,
		func_params: is_array(_params) ? _params : [_params],
	}
	type  = e_settingstype.set_menu
	
}

event_setting = function(_title,_event,_params = [],line = false) constructor
{
	draw_underline = line
	title = _title
	type  = e_settingstype.event
	event = _event
	params = is_array(_params) ? _params : [_params]
}


change_party_options = function(i)
{
	return new event_setting
	(
		"Character slot " + string(i) + ":  " + (i < array_length(global.stats.party) ? string_capitalize(global.stats.party[i]) : "EMPTY"),
		function(val,i){self.selected_char = i}
	)
}

create_struct_segment = function(name,value,var_name,from,_custom_func = -1)
{
	if is_bool(value)
			return new obj_devmenu_debug.setting(name,var_name,false,e_settingstype.boolean,from,_custom_func)
	else if is_struct(value)
		return new obj_devmenu_debug.struct_setting(name,value,,,_custom_func,,var_name,from)
	else if is_numeric(value)
			return new obj_devmenu_debug.setting(name,var_name,false,e_settingstype.get_numeric,from,_custom_func)
	else if is_string(value)
		return new obj_devmenu_debug.setting(name,var_name,false,e_settingstype.get_str,from,_custom_func)
	else if is_array(value)
			return new obj_devmenu_debug.setting(name,var_name,false,e_settingstype.array,from,_custom_func)
}

struct_settings_simple = function(_values,_to_remove = [],_custom_func = -1)
{
	var settings = []
	
	var vars = variable_struct_get_names(_values)
		
	if array_length(_to_remove)
	for (var i = 0; i < array_length(vars); i++)
	if array_contains(_to_remove,vars[i])
	{
		array_delete(vars,i,1)
		i --
	}	
		
	for (var i = 0; i < array_length(vars); i++)
	{
		var this = _values[$vars[i]]
		var name = string_prettify(vars[i])
		settings[i] = obj_devmenu_debug.create_struct_segment(name,this,vars[i],_values,_custom_func)
	}
	return settings
}

struct_setting = function(_title,_values,_to_remove = [],event = -1,_every_func = -1,_max_height = 206,_var_name = "",_from = -1) constructor
{
	var_name = _var_name
	from = _from
	draw_underline = true
	title = _title
	type = e_settingstype.set_menu 
	menu = {}
	
	with menu 
	{
		if is_array(_values)
		{
			settings = []
			for (var i = 0; i < array_length(_values); i++)
			settings = array_concat(settings,obj_devmenu_debug.struct_settings_simple(_values[i],_to_remove,_every_func))
		}
		else 
		settings = obj_devmenu_debug.struct_settings_simple(_values,_to_remove,_every_func)
		
		func = event
		func_params = []
		title = _title
		every_func = _every_func
		max_height = _max_height
	}
}

get_inventory = function(str)
{
	switch str 
	{
		case "inventory": return global.stats.inventory
		case "storage": return global.stats.storage_box
	}
	return []
}

change_inventory_options = function(inv_name = "inventory")
{
	var inventory = get_inventory(inv_name)
	var r = []
	for (var i = 0; i < array_length(inventory); i++)
	r[i] = new event_setting
		(
			"Item slot " + string(i) + ":  " + string_prettify(inventory[i]),
			function(val,i){self.selected_item = i}
		)
	
	var final_array = 
	[
		new event_setting("Remove all items", function(inv_name)
		{ 
			var inv = get_inventory(inv_name) 
			for (var i = 0; i < array_length(inv); i++)
			inv[i] = ITEM_EMPTY
			current_menu.settings = change_inventory_options(inv_name) 
		},inv_name),
		new event_setting("Randomize inventory", function(inv_name)
		{
			var inv = get_inventory(inv_name) 
			var names = struct_get_names(global.items)
			for (var i = get_number_of_items(inv); i < array_length(inv); i++)
			inv[i] = names[irandom(array_length(names) - 1)]
			current_menu.settings = change_inventory_options(inv_name) 
		},inv_name),
	]
	return array_concat(r,final_array)
}

truefile_custom_func = function()
{
	var str = "True savedata is saved and loaded as the\nstory progresses.\nClick here to add a new variable to the struct."
	var h = height + y_add / 2
	if h > 173
		str = "Add custom variable"
	var this = 
	{
		title: "",
		settings: 
		[
			new event_setting(str,function()
			{
				var a = true_savedata
				for (var i = 1; i < array_length(prev_menu); i++)
					a = a[$prev_menu[i].where_im_at]
					
				var _var = get_variable()
				if _var != -1
				{
					struct_replace_unique(a,_var)
				
					truefile_overwrite(true_savedata)
				
					var a = true_savedata
					for (var i = 1; i < array_length(prev_menu); i++)
					{
						prev_menu[i].settings = struct_settings_simple(a,,prev_menu[i].every_func)
						a = a[$prev_menu[i].where_im_at]
					}
					current_menu.settings = struct_settings_simple(a,,current_menu.every_func)
				}
			})
		],
	}
	setup_vars()
	menu_y += h
	draw_me(false,false,this,false)
	if (h > 173)
	{
		menu_y += 4
		height += -7 
	}
	else 
	{
		menu_y += 2
		height += -8
	}
	draw_devmenu()
	setup_vars()
	menu_y += h
	draw_me(false,true,this,false)	
}