draw_set_color(c_white)
draw_menu(0,120,319,120,4) // main
draw_reset_alpha()
var number_of_items = get_number_of_items()

interact_key = interact_key_press && !back_key_press

if !in_submenu
{
	main_selection = scr_updown_modwrap(main_selection,4)
	
	if interact_key 
	{
		if array_contains(unavailable_menus,main_selection)
		play_sound(snd_cantselect)
		else
		{
			in_submenu = true
			open_menu = true
			instance_destroy(large_dialogue)
			play_sound(snd_select)	
			interact_key = false
			if main_selection != 3 // that is exit
			{
				item_selection = 0
				selecting_exit = false
			}
		}
	}
}

draw_set_font(font_deter_12)

draw_menu(210,120,110,120,4) // tiny

if !(in_submenu)
{
	var main_options = ["Buy","Sell","Talk","Exit"]
	for (var i = 0; i < 4; i++)
	{
		draw_set_colour(c_white)
		if array_contains(unavailable_menus,i)
		draw_set_colour(c_gray)
		if i == main_selection
		draw_sprite(spr_soul_text,0,225,134 + 20 * i)
		draw_text(240,131 + 20 * i,main_options[i])	
	}
	
	if (instance_exists(large_dialogue))
	with large_dialogue
		event_user(1)
}

draw_set_font(font_deter_12)
draw_reset_all()
draw_text(280,211,string(number_of_items) + "/8")
draw_text(230,211,string(global.stats.gold) + "G")

if in_submenu
{
	event_user(main_selection)
	open_menu = false
}

draw_set_font(font_deter_12)