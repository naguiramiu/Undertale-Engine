depth = UI_DEPTH - 1
event_user(0)

name = ""
max_name_length = 6
name_chosen = false
name_allows_entry = true
top_text = lan.name_entry_title
name_lerp = 0
load_from_file = true
globalmusic_play(mus_menu1,0,,,true)
image_alpha = 0


bottom_selection = -1
selected_letter = 0
instructions_selection = 0
in_instructions = true


draw_instructions = function()
{
	draw_set_font(font_deter_12)
	draw_set_colour(c_ltgray)
	var st = lan.instruction_title
	var sw = string_width(st) / 2
	draw_text(147.5 + 6 + sw,21 ,"---")
	draw_set_halign(fa_right)
	draw_text(147.5 - sw,21 ,"---")
	draw_set_halign_center()
	draw_text(150,21,st,)
	draw_reset_halign()
	draw_text_linesep(85,51,lan.instructions,18,1)
	draw_reset_color()
	var set = [lan.instruction_begin,lan.instruction_settings]
	instructions_selection = scr_updown_modwrap(instructions_selection,2)
	for (var i = 0; i < 2; i ++)
	draw_text_color_ext(85,173 + i * 20,set[i],(instructions_selection == i ? c_yellow : c_white))
	
	if interact_key_press
	{
		if !instructions_selection
		{
			obj_title_namescreen.in_instructions = false 
			play_sound(snd_select)
		}
		else instance_create(obj_title_settings,{weather_type: -1})
	}
}


