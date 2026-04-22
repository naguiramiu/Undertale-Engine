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
		menu_from_array: false,
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
	var h = height + y_add / 2
	var shorten = (h > 173)
	var str = (shorten ? "Add custom variable" : "True savedata is saved and loaded as the story progresses. Click here to add a new variable to the struct.")
	var this = 
	{
		title: "",
		settings: 
		[
			new event_setting(str,function()
			{
				var _var = get_variable()
				if _var != -1
				{
					struct_replace_unique(get_struct_ext(),_var)
					truefile_overwrite(true_savedata)
				}
			}),
		],
	}
	setup_vars()
	menu_y += h
	draw_me(true,false,this,false)
	setup_vars()
	menu_y += h
	draw_me(false,true,this,false)	
}

flags_custom_func = function()
{
	var h = height + y_add / 2
	var str = "Reset flags"
	var this = 
	{
		title: "",
		settings: 
		[
			new event_setting(str,function()
			{
				if show_question("Are you sure?")
				{
					global.flags = scr_init_flags()
					with obj_devmenu_debug event_perform(ev_create,0)
				}
			}),
		],
	}
	setup_vars()
	menu_y += h
	draw_me(true,false,this,false)
	setup_vars()
	menu_y += h
	draw_me(false,true,this,false)	
}