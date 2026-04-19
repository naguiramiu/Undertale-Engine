/// @description Room Warp
var mouse = cr_default

with get_mouse_pos()
{
	var mouse_xx = x 
	var mouse_yy = y	
}

draw_reset_color()

x = 0 
y = 0 
draw_set_font(font_deter_12)
draw_reset_align()
var padding = 10 
var str = "ROOM WARP"
var menu_x = x + 7
var menu_y = y + 25 
var current_x = menu_x + padding - x 
var current_y = menu_y + padding - y

var width = 0 
var height = 0
for (var i = 0; i < array_length(room_info); i++)
{
	if filter && !(room_area_selected = room_info[i].area_id) continue;

	width = max(width,padding / 2 + current_x + string_width(room_info[i].room_name) / 2)
	height = max(height,current_y - 6)
	
	current_y += 10
	
	if current_y + padding > 227
	{
		current_x += 93
		current_y = menu_y + padding
	}
}

draw_set_alpha(0.5)
draw_menu_linealpha(cam_x + menu_x,cam_y + menu_y,width,height,,,(mouse_check_hovers_rect_wh(menu_x,menu_y,width,height) ? 0.75 : 0.5))
draw_reset_alpha()

for (var i = 1; i <= string_length(str); i++) 
    draw_text((cam_x + menu_x + ((width + 90) / 2) - ((string_length(str) * 8) / 2)) + 8 * (i - 1),cam_y +  y + 7 + sin((current_time * 0.005) + ((i / string_length(str)) * (pi * 2))) * 0.5, string_char_at(str, i))


var current_x = menu_x + padding 
var current_y = menu_y + padding

for (var i = 0; i < array_length(room_info); i++)
{
	if filter && !(room_area_selected = room_info[i].area_id) continue;
	
	var selected = mouse_check_hovers_rect_wh(cam_x + current_x,cam_y + current_y,string_width(room_info[i].room_name) / 2,8,mouse_xx,mouse_yy)
	
	if selected 
	{
		mouse = cr_handpoint	
		if mouse_check_button_pressed(mb_left)
		{
			if instance_exists(obj_devmenu_debug)
			obj_devmenu_debug.self_visible = false 
			instance_activate_object(parent_char)
			if !instance_exists(player) load_player()
			global.can_move = true 
			scr_teleport_player(room_info[i].x,room_info[i].y,true)
			room_goto(room_info[i].room_id)
			show_poppup(room_info[i].room_id)
			globalmusic_stop(true)
			audio_stop_all()
			window_set_cursor(cr_default) 
			instance_destroy()
			audio_group_stop_all(audiogroup_sound)
			mouse = cr_default
			exit
		}
	}
	
	draw_set_colour(selected ? c_yellow : c_white)
	draw_text_transformed(cam_x + current_x,cam_y + current_y,room_info[i].room_name,0.5,0.5,0)
	current_y += 10
	
	if current_y + padding > 227
	{
		current_x += 93
		current_y = menu_y + padding
	}
}

draw_reset_color()
var _x = cam_x + menu_x + width + 8
var _y = cam_y + menu_y
var h = 21 
var wd = 82
for (var i = 0; i < array_length(room_options); i++)
{
	var selected = mouse_check_hovers_rect_wh(_x,_y,wd,h,mouse_xx,mouse_yy)
	draw_set_alpha(0.5)
	draw_menu_linealpha(_x,_y,wd,h,2,room_options[i].color,selected ? 0.8 : 0.5)	
	draw_reset_alpha()
	
	if selected 
		{
			mouse = cr_handpoint	
			if mouse_check_button_pressed(mb_left)
			{
				room_area_selected = room_options[i].type
				filter = true	
			}
		}
	
	draw_set_align_center()
	draw_text_transformed(_x + wd / 2,1 + _y + h / 2,room_options[i].name,0.5,0.5,0)
	draw_reset_align()
	
	_y += (6 + h)
}
window_set_cursor(mouse)

if keyboard_check_pressed(vk_f3) || back_key_press
{
	instance_destroy()
	window_set_cursor(cr_default)
}
