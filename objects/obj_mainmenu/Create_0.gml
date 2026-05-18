play_sound(snd_select)
could_move = global.can_move
global.can_move = false 
depth = UI_DEPTH + 200
in_submenu = false 
main_menu_selection = 0
stats_screen = undefined
selected_char = 0
item_textbox = noone
mainscreen_yoff = 0
menu_create = false

event_destroy = function()
{
	play_sound(snd_menu_move)
	global.can_move = could_move
	instance_destroy()
}

draw_character_stats = function(char_num,_x = 0,_darken = false,_selected = false)
{
	var lan = get_lan(lan_main_menu)
	var char = get_char_by_party_position(char_num)
	var top_x = _x + x + -16
	var top_y = y + -26 + player_below_half_y() * 135
	var menu_col = (char_num == 0 ? c_white : char.ui_color)
	if (_darken && !_selected) menu_col = merge_colour(menu_col,c_black,0.5)
	draw_menu(top_x + 32,top_y + 52,70,54,3,menu_col)
	draw_set_color(c_white)
	if (_darken && !_selected) 
		draw_set_colour(merge_colour(c_white,c_black,0.5))
	draw_set_font(font_deter_12)
	draw_text(top_x + 39, top_y + 57,char.name)
	draw_set_font(font_crypt_4)
	draw_text_linesep(top_x + 46 + -7,top_y +102 + -25,[lan.lv_lan,lan.hp_lan,lan.gold_lan],9,1)
	draw_text_linesep(top_x + 46 + 18 + -7,top_y +102 + -25,[string(char.lv),string(char.hp) + "/" + string(char.max_hp),global.stats.gold],9,1)
	draw_set_font(font_deter_12)
	draw_reset_color()
}


