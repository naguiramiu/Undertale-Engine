x = cam_x 
y = cam_y

screen_cover(,0.6)

var prev = selection
if !saved && !overwritting
selection = scr_updown_modwrap(selection,NUMBER_OF_SAVEFILES + 1)
var char = get_char_by_party_position(0)
var information = 
[
	{
		play_time: format_time(global.information.play_time),
		room_name: get_lan(lan_room_name,room_get_name(room)) ?? room_get_name(room),
		lv: char.lv,
		loaded: true,
		name: char.name
	},
]

for (var i = 0; i < array_length(file_data); i ++)
array_push(information,file_data[i])

var interact = interact_key_press
var back = back_key_press
var was_saved = saved 

if interact && !overwritting && selection < array_length(file_data)
{
	if (!saved)
	{
		if (!file_data[selection].loaded || (global.information.savefile_num == selection))
			save()
		 else 
		 {
			overwritting = true 
			play_sound(snd_select)
		 }
		interact = false
	}
	else 
	{
		instance_destroy()
		play_sound(snd_menu_move)
		global.can_move = true
	}
}


var draw_file = function(box_x_left,current_y,box_w,box_h,file,selected,soul = true)
{
	var language = get_lan(lan_text_title).file_select	
	var center_x = box_x_left + box_w / 2
	draw_set_halign_center()
	draw_text(center_x, current_y + 7,file.name)	
	draw_text(center_x,current_y + 23, file.room_name)
	draw_set_halign(fa_right)
	draw_text(center_x + box_w + -140, current_y + 7,file.play_time)
	draw_reset_halign()
	draw_text(box_x_left + 28 - (!soul) * 18,current_y + 7,language.lv_text_2 + " " + string(file.lv))
	if selected && soul
			draw_sprite(spr_soul_text,0,box_x_left + 10,current_y + 9)
}


var language = get_lan(lan_text_title).file_select	

var current_y = y + 10
var box_w = 252
var box_x_left = x + (320 / 2) - box_w / 2
var box_h = 45
var ary = array_length(information)
for (var i = 0; i < ary + 1; i++) 
{
	var selected = (i == selection + 1)
	
	var back = (i == ary)
	if back 
	{
		box_h = 26
		if saved break;
	}
	
	draw_menu(box_x_left,current_y,box_w,box_h,3)	
	var center_x = box_x_left + box_w / 2
	var center_y = current_y + box_h / 2
	draw_set_colour(selected ? c_yellow : c_white)
	
	if (saved) 
		draw_set_colour((!i || selected) ? c_yellow : c_dkgray)
	
	if !back 
	{
		var file = information[i]
		
		if ((was_saved) && !i) 
			file = information[selection + 1]
		
		var this_saved = (saved && selected)
		
		if !file.loaded || this_saved
		{
			var str = this_saved ? language.file_saved : language.new_file
			
			draw_set_align_center()
			draw_text(center_x,center_y,str	)
			draw_reset_align()
			if selected && !this_saved
				draw_sprite(spr_soul_text,0,center_x - string_width(str) + 8,center_y + -6)
		}
		else
			draw_file(box_x_left,current_y,box_w,box_h,file,selected)
	}
	else 
	{
		draw_set_align_center()
		draw_text(center_x,center_y + 1,language.go_back)	
		if selected 
		draw_sprite(spr_soul_text,0,center_x - string_width(language.go_back) + -3,center_y + -5)
		draw_reset_align()
		
		if interact && selected 
		{
			play_sound(snd_menu_move)
			instance_destroy()
			instance_create(obj_savescreen)
		}
	}
	
	current_y += (box_h - 3) + (14 * !i)
}

draw_set_halign(fa_left) 

if overwritting
{
	screen_cover(,0.7)
	
	draw_menu(x + 9,y + 54,301,131)
	
	draw_set_colour(c_white)
	
	var files = [information[0],information[selection]]
	var current_y = y + 76
	var box_w = 260
	draw_set_halign_center()
	draw_text(x + (320 / 2),y + 63,string_replace(language.overwrite_slot,"{num}",string(selection + 1)))
	draw_reset_halign()
	var box_x_left = x + (320 / 2) - box_w / 2
	var box_h = 45
	var ary = array_length(information)
	for (var i = 0; i < 2; i ++) 
		draw_file(box_x_left,current_y + (box_h - 10) * i,box_w,box_h,files[i],i,false)	
	
	if interact 
	{
		overwritting = false 
		if overwritting_selection 
			play_sound(snd_menu_move)
		else 
			save()
	}
	
	
	var text = [language.save,language.go_back]
	for (var i = 0; i < 2; i++) 
		draw_text_color_ext(x + 85 + 90 * i, y + 163,text[i],(i == overwritting_selection ? c_yellow : c_white))	
	
	overwritting_selection = scr_leftright_modwrap(overwritting_selection,2)
	
	draw_sprite(spr_soul_text,0,x + 69 + 90 * overwritting_selection,y + 165)
}