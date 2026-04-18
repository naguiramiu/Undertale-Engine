depth = UI_DEPTH + 10
self_visible = true
event_user(1)

scr_checkforduplicate()

var change_party_func =
function()
{
	if !variable_self_exists("selected_char")
	{
		selected_char = -1
		reset_this_menu = function()
		{
			selected_char = -1
			current_menu.settings = array_create_ext(3,change_party_options)
			with global.information
			{
				x = player.x
				y = player.y
				front_vector = player.front_vector
			}
			load_player()
		}
	}
	if (selected_char != -1)
	{
		var this_menu = 
		{
			title: "Select member",	
			func: -1,
			settings: []
		}
		
		var names = variable_struct_get_names(global.stats.char)
		for (var i = 0; i < array_length(names); i++)
		this_menu.settings[i] = new event_setting(string_capitalize(names[i]),
		function(val,i)
		{
			if (array_length(global.stats.party) - 1) < selected_char - 1
			selected_char = array_length(global.stats.party)
			
			var s = variable_struct_get_names(global.stats.char)
			global.stats.party[selected_char] = s[i]
			reset_this_menu()
		})
				
		if selected_char != 0 && array_length(global.stats.party) > selected_char
		array_push(this_menu.settings,new event_setting("Remove",function(val,i)
		{
			array_delete(global.stats.party,selected_char,1)
			reset_this_menu()
		}))
				
		for (var i = 0; i < 2; i++)
		{
			setup_vars()
			menu_x += 128 
			draw_me(!i,i,this_menu,false)
		}
	}
	if (interact || back_key)
	{
		if selected_char == -1
		event_perform(ev_create,0)
		else 
		selected_char = -1
		back_key = false	
		interact = false	
	}
}

var item_func =
function(inv_name = "inventory")
{
	var inv = get_inventory(inv_name)
	
	if !variable_self_exists("selected_item")
		selected_item = -1
	
	
	if (selected_item != -1)
	{
		var this_menu = 
		{
			title: "Select item",	
			func: -1,
			settings: []
		}
		
		var names = variable_struct_get_names(global.items)
		for (var i = 0; i < array_length(names); i++)
		this_menu.settings[i] = new event_setting(global.items[$names[i]].short_name,
		function(inv_name,val,i)
		{
			var inv = get_inventory(inv_name)
			var n = variable_struct_get_names(global.items)
			if selected_item > get_number_of_items(inv)
				add_item_to_inventory(n[i],inv)
			else
			inv[selected_item] = n[i]
			current_menu.settings = change_inventory_options(inv_name)
			selected_item = -1
		},inv_name)
				
		array_push(this_menu.settings,new event_setting("Remove",function(inv_name,val,i)
		{
			var inv = get_inventory(inv_name)
			array_delete(inv,selected_item,1)
			inv[array_length(global.stats.inventory)] = ITEM_EMPTY
			current_menu.settings = change_inventory_options(inv_name)
			selected_item = -1
		},inv_name))
				
		for (var i = 0; i < 2; i++)
		{
			setup_vars()
			menu_x += 128 
			draw_me(!i,i,this_menu,false)
		}
	}
	
	var inb = get_inventory(inv_name)
	inb = inv 
	
}
event_user(2)

true_savedata = truefile_load()

main_settings = 
[
	new setting("Show wall hitboxes","wall_hitboxes",false,e_settingstype.boolean),
	new setting("Show other hitboxes","other_hitboxes",false,e_settingstype.boolean),
	new set_menu_setting("Change party",array_create_ext(3,change_party_options),change_party_func),
	new set_menu_setting("Inventory",change_inventory_options(),item_func),
	new set_menu_setting("Storage box",change_inventory_options("storage"),item_func,"storage"),
	new struct_setting("Flags", global.flags),
	new struct_setting("Stats", [global.stats, get_char_by_party_position(0)],["inventory","party","storage_box","ui_color"]),
	new struct_setting("True savedata",true_savedata,,truefile_custom_func,function(this_setting,right)
	{
		if right
		{
			if show_question("Remove value " + this_setting.var_name + "?")
			{
				variable_struct_remove(this_setting.from,this_setting.var_name)
				truefile_overwrite(true_savedata)
			}
			else return false
		}
		else
		truefile_write(true_savedata)
		
		current_menu.settings = struct_settings_simple(this_setting.from,,current_menu.every_func)
		return right
	},177),
	new event_setting("Save game",function()
	{
		save_game()	
		show_poppup("Game saved!")
	}),
	new event_setting("Restart game",game_restart),
	new event_setting("Show active instances",get_active_instances),
	new setting("Skip title sequence","insta_load",scr_dev_load_instantly,e_settingstype.boolean,global.settings.dev),
	new setting("Can move","can_move",global.can_move,e_settingstype.boolean,0),
	new setting("Show GML overlay","debug_overlay",function(){
		show_debug_overlay(!is_debug_overlay_open(),true,1.1,0.5)
	},e_settingstype.boolean),
	new setting("Show information","show_information",false,e_settingstype.boolean),
	new event_setting("Room warp",instance_create,obj_devroomwarp,true),
]

current_menu = 
{
	settings: main_settings,
	title: "Dev menu",
	func: -1
}


setup_vars = function(_max_height = 206)
{
	padding = 10
	menu_x = cam_x + 11
	menu_y = cam_y + 23
	mouse_xx = get_mouse_pos().x
	mouse_yy = get_mouse_pos().y
	current_x = padding
	current_y = padding
	max_height = _max_height
	y_add = 11
	line_broke = false
	width = 0
	height = 0
	draw_reset_all()
	draw_set_font(font_deter_12)
	draw_reset_alpha()
	draw_reset_color()
}
event_user(0)

draw_devmenu = function()
{
	draw_set_alpha(0.5)
	var in_box = mouse_check_hovers_rect_wh(menu_x,menu_y,width,height)
	if in_box outside = false
	draw_menu_linealpha(menu_x,menu_y,width,height,,,(in_box ? 0.75 : 0.5))
	draw_reset_all()
}

prev_menu = []