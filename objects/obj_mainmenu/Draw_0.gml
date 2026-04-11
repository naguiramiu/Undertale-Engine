var textbox_open = (instance_exists(obj_textbox))
x = cam_x
y = cam_y

draw_set_alpha(1)
draw_set_halign(fa_left)
var lan = get_lan(lan_main_menu)

back_key = back_key_press && !textbox_open
interact_key = interact_key_press && !textbox_open

var char = get_char_by_party_position(0)
// top menu with the name and stats
var top_x = x + -16
var top_y = y + -26 + player_below_half_y() * 135
draw_menu(top_x + 32,top_y + 52,70,54,3)
draw_set_color(c_white)
draw_set_font(font_deter_12)
draw_text(top_x + 39, top_y + 57,char.name)
draw_set_font(font_crypt_4)
draw_text_linesep(top_x + 46 + -7,top_y +102 + -25,[lan.lv_lan,lan.hp_lan,lan.gold_lan],9,1)
draw_text_linesep(top_x + 46 + 18 + -7,top_y +102 + -25,[string(char.lv),string(char.hp) + "/" + string(char.max_hp),global.stats.gold],9,1)

// main center menu
draw_menu(x + 16,y + 84,70,73,3) // main menu center body
	
draw_set_font(font_deter_12)
var lan = get_lan(lan_main_menu)

with lan 
{
	var menu_names = [menu_item,menu_stat]

	if global.flags.has_cell
	array_push(menu_names,menu_cell)
	
	var ary = array_length(menu_names)
}

var grayed_menu = []

if (global.stats.inventory[0] == ITEM_EMPTY) // no items 
array_push(grayed_menu,0) // 0 is item

		
if !textbox_open && !in_submenu
{
	main_menu_selection = modwrap(main_menu_selection,0,ary,grayed_menu)
	main_menu_selection = scr_updown_modwrap(main_menu_selection,ary,,grayed_menu)
	/// MAIN MENU OPEN SELECTED MENU
	if interact_key 
	{
		if array_contains(grayed_menu,main_menu_selection)
			play_sound(snd_cantselect)
		else
		{
			selected_char = 0
			in_submenu = true
			play_sound(snd_select)
		} 
		
		interact_key = false
	}
}
	// draw the names 
for (var m = 0; m < ary; m++)
{
	draw_text_color_ext(x + 42,y + 95 + (18 * m),string_upper(menu_names[m]),(array_contains(grayed_menu,m) ? c_gray : c_white))
}
	
if (!in_submenu || main_menu_selection == 1) // 1 is stat
	draw_sprite(spr_soul_text,m,x + 27,y + 97 + 18 * main_menu_selection)

draw_set_font(font_deter_12)
draw_set_color(c_white)

if in_submenu 
	event_user(main_menu_selection)

if back_key 
{
	instance_destroy()
	exit 	
}