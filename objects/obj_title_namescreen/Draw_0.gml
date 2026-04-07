var interact = interact_key_press
var back = back_key_press

if !name_chosen
{
	if in_instructions
	{
		draw_instructions() 
		exit;
	}
	var letters_per_row = 7;
	var number_of_rows = 4
	var current_row = (selected_letter div letters_per_row) % number_of_rows
	var total_letters = 26; 
	var up_key = up_key_press
	var down_key = down_key_press
	if bottom_selection == -1 
	{
		var sel_lowercase = selected_letter > 25
		var prev = selected_letter
		var drawn_sel = function()
		{
			var sel_lowercase = selected_letter > 25
			return (sel_lowercase ? selected_letter - 28 : selected_letter)
		}
		if right_key_press
		{
			if drawn_sel() == total_letters - 1
			selected_letter = (selected_letter div letters_per_row) * letters_per_row
			else 
			{
				if (selected_letter % letters_per_row) == letters_per_row - 1
					selected_letter = (selected_letter div letters_per_row) * letters_per_row
				else 
					selected_letter ++
			}
		}
	
		if left_key_press
		{
			if (selected_letter % letters_per_row) == 0
				selected_letter += ((current_row == 3 ) ? letters_per_row - 3 : letters_per_row - 1)
			else selected_letter --
		}
	
		if up_key
		{
			selected_letter -= letters_per_row
		
			if drawn_sel() < 0 
			selected_letter -= letters_per_row
		
			if selected_letter < 0
				bottom_selection = round(remap(prev,0,letters_per_row,0,2.5))
			up_key = false 
		}
	
		if down_key
		{
			selected_letter += letters_per_row
			var over = drawn_sel() < 0 || drawn_sel() >= total_letters
			if over && !sel_lowercase
			selected_letter += letters_per_row
			if sel_lowercase && (selected_letter > 53 || over)
			{
				selected_letter -= letters_per_row * (prev >= 49)
				bottom_selection = round(remap(selected_letter - 49,0,letters_per_row,0,2.5))
			}
			down_key = false
		}
		if prev != selected_letter play_sound(snd_menu_move)
	}
	var current_y = 76 
	var start_x = 60
	var i = 0

	for (var lowercase = 0; lowercase < 2; lowercase ++)
	{
		for (var row = 0; row < 4; row ++)
		{
			var current_x = start_x
			for (var letter = 0; letter < 7; letter++)
			{
				var pos = (letter + row * 7)
				var selected = (i == selected_letter) && bottom_selection == -1
				draw_text_shake(current_x,current_y,(pos < 26 ? chr(65 + pos + (lowercase * 32)) : ""),0.3,,(selected ? c_yellow : c_white))
				current_x += 32
				i ++
			}
			current_y += 14
		}
		current_y += 4
	} 

	var ary = array_length(bottom_menu)
	if bottom_selection != -1 
	{
		var prev = bottom_selection
		bottom_selection = scr_leftright_modwrap(bottom_selection,ary,-1)
		if up_key
		{
			selected_letter = 47 + ((bottom_selection + 1) % ary) * 2
			bottom_selection = -1 	
		}
		if down_key
		{
			selected_letter = round(remap(bottom_selection,0,ary,0,letters_per_row))
			bottom_selection = -1 	
		}
		if prev != bottom_selection 
			play_sound(snd_menu_move)
		
		if interact && bottom_menu[bottom_selection].event != -1 
			bottom_menu[bottom_selection].event()
	}
	
	draw_set_align_center()
	
	for (var i = 0; i < ary; i++)
	draw_text_color_ext(74 + (77.5 * i) + 5 * (i == 2), 209,bottom_menu[i].name,(i == bottom_selection ? c_yellow : c_white))

	draw_reset_align()

	if interact && bottom_selection == -1 
	{
		var char = chr(65 + selected_letter + (selected_letter > total_letters) * 4)
		name = (string_length(name) < max_name_length ? name + char : string_copy(name,1,max_name_length - 1) + char)
		
		if string_pos(string(716583846982),string_to_real(string_upper(name)))
				game_restart()
	}
	if back && string_length(name) 
	{
		name = string_copy(name,1,string_length(name) - 1)
		back = false	
	}
	
	name_lerp = 0
}
else if image_alpha <= 0
{
	draw_set_halign_center()
	
	var b_menu = name_allows_entry ? [lan.name_correct_no, lan.name_correct_yes] : [lan.name_correct_go_back]
	
	var ary = array_length(b_menu)
	instructions_selection = scr_leftright_modwrap(instructions_selection,ary)

	for (var i = 0; i < ary; i++)
	draw_text_color_ext(80 + (160 * i),201,b_menu[i],(i == instructions_selection) ? c_yellow : c_white)
	draw_reset_align()
	
	if back || (interact && !instructions_selection)
	{
		if instance_exists(obj_title_main)
		{
			instance_destroy()
			obj_title_main.visible = true 
		}
		else
		{
			play_sound(snd_menu_move)
			name_chosen = false
			top_text = lan.name_entry_title
		}
	}
	else if interact 
	{
		global.stats.char[$"frisk"].name = name

		lerp_var_ext(id,"image_alpha",0.0067,0,1,,,
		{
			event_destroy: do_later,
			event_destroy_params: [25,function()
			{
				load_game(,load_from_file)	
				lerp_var_ext(obj_camera,"screen_darken",0.05,1,0)
			}]
		})
		play_sound(snd_cymbal)
		globalmusic_stop()
	}
}

var q = ease_in_out(name_lerp,0,123)
draw_text_transformed(140 - (q / 3) + random(1) * name_lerp,q / 2 + 56,name, 1 + (q / 50), 1 + (q / 50), random_range((-0.5 * q) / 60, (0.5 * q) / 60))

if image_alpha <= 0
{
	draw_set_colour(c_white)
	draw_set_valign(fa_bottom)
	var w = string_width(top_text)
	draw_text(room_width / 2 - w / 2,31 + 20,top_text)
	draw_reset_align()
}
else
	screen_cover(c_white,image_alpha)