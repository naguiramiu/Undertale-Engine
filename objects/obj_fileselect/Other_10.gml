/// @description Start

globalmusic_play(mus_menu1,0)

file_data = scr_array_fill_savefiledata()

set_menu = function(_menu,bottom_sel = 0,time = 1)
{
	do_later(time,function(_menu,bottom_sel)
	{
		with obj_fileselect
		{
			var menu = {}
			var names = struct_get_names(menus)
			for (var i = 0; i < array_length(names); i++)
			if menus[$names[i]].id == _menu menu = menus[$names[i]]
			
			top_text = menu.top_text
			file_copying_from = -1
			if menu.id != e_fileselect_menu.base
			{
				bottom_selecting = false 
				selection = 0
			}
			bottom_selection = bottom_sel
			current_menu = menu
			play_sound(snd_menu_move)
		}
	},[_menu,bottom_sel])
}

var menu = function(_name,_event,_event_params = [], _available = true) constructor 
{
	name = _name event = _event event_params = _event_params available = _available
}

var file_menu = function(_id,_top_text,_interact_event,_bottom_menu) constructor 
{
	top_text = _top_text
	interact_event = _interact_event
	id = _id
	bottom_menu = _bottom_menu
}

menus = 
{
	copy_menu: new file_menu(
		e_fileselect_menu.copy,
		"Select a file to copy from.",
		function()
		{
			if file_copying_from == -1 
			{
				if file_data[selection].loaded
				file_copying_from = selection
				else play_sound(snd_cantselect)
			}
			else 
			{
				if selection == file_copying_from 
					play_sound(snd_cantselect)
				else 
				{
					file_copy(savefile_name(file_copying_from),savefile_name(selection))
					set_menu(e_fileselect_menu.base,0)
					file_data = scr_array_fill_savefiledata()
					file_copying_from = -1
					play_sound(snd_save)
				}
			}
		},
		[new menu("Back",set_menu,[e_fileselect_menu.base,0])]
	),

	erase_menu: new file_menu(
		e_fileselect_menu.erase,
		"Erase a file.",
		function()
		{
			if !file_data[selection].loaded 
				play_sound(snd_cantselect)
			else 
			{
				file_delete(savefile_name(selection))
				set_menu(e_fileselect_menu.base,1)
				file_data = scr_array_fill_savefiledata()
				play_sound(snd_break1)
			}
		},
		[new menu("Back",set_menu,[e_fileselect_menu.base,1])]
	),

	main_menu: new file_menu(
		e_fileselect_menu.base,
		"Please select a file.",
		function()
		{
			selecting = true 
			play_sound(snd_menu_move)
		},
		[
			new menu("Copy",set_menu,[e_fileselect_menu.copy,0]),
			new menu("Erase",set_menu,[e_fileselect_menu.erase,0]),
			new menu("Settings",instance_create,obj_title_settings),
			new menu("End Program",game_end),
		]
	)
}