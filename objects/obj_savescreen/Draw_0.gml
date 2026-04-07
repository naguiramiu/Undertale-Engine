x = cam_x
y = cam_y

draw_menu(x + 54,y + 59,211,86,3,c_white)
var char = get_char_by_party_position(0)

if !file_saved && (right_key_press || left_key_press)
{
	selection = !selection
	play_sound(snd_menu_move)
}

var destroy = false

if (created && interact_key_press)
{
	if !file_saved && !selection
	{
		if NUMBER_OF_SAVEFILES > 1 
		{
			instance_create(obj_savescreen_files)
			instance_destroy()
		}
		else 
		{
			save_game()
			struct_set_all_self(savefile_basic_information(global.information.savefile_num))
			file_saved = true 
			play_sound(snd_save)
		}
	}
	else destroy = true
}

draw_set_color(file_saved ? c_yellow : c_white)
draw_set_font(font_deter_12)
draw_text(x + 70,y + 71 ,name ?? "EMPTY") 
draw_text(x + 162 + -8,y + 71 ,"LV " + (is_defined(lv) ? string(global.stats.lv) : string(0)))
draw_set_halign(fa_right)
draw_text(x + 250,y + 71 ,play_time ?? format_time(0))
draw_reset_halign()
draw_text(x + 70,y + 91 ,room_name ?? "--")

var ary = ["Save","Return"]
if !file_saved
{
	for (var i = 0; i < 2; i++)
		draw_text(x + 85 + 90 * i,y + 121, ary[i])
	draw_sprite(spr_soul_text,0,x + 70 + 90 * selection,y + 122)
}
else 
draw_text(x + 85,y + 121,"File saved.")

draw_set_colour(c_white)
if back_key_press || (destroy)
{
	play_sound(snd_menu_move)
	global.can_move = true
	instance_destroy()	
}

created = true