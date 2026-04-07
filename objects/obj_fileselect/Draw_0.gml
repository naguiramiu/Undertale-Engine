draw_set_alpha(1)
screen_cover()

move()

var back = back_key_press
var interact = interact_key_press
var c_menu_id = 0

if !bottom_selecting && interact && !selecting
{
	interact = false
	current_menu.interact_event()
}

draw_set_font(font_deter_12)
var rows = 3
var columns = 1
var column_x_offset = 0
for (var i = 0; i < 3; i++) // save menu boxes 
{
	var this_file = file_data[i]
	var column_x = 0
	var selected = (i == selection) && !bottom_selecting
	var this_file_open = (selected && selecting)
	var current_y = i * 45
	if selected && !this_file_open
		draw_sprite_ext(spr_soul_menu,0,column_x + 69, current_y + 72,0.5,0.5,0,c_white,1)
	
	var color = (i == file_copying_from ? c_yellow : c_white)
	draw_set_color(color)
	draw_rectangle_border_width(column_x + 52.85 ,current_y +53,column_x + 52.85 +  213 ,current_y + 53 + 42 ,2)
	draw_set_font(font_deter_12)
	with this_file 
	{
		draw_text_shadow(column_x + 80,current_y + 61,name ?? "[EMPTY]"	,color) // NAME
		if is_defined(play_time)
		{
			draw_set_halign(fa_right)
			draw_text_shadow(column_x + 235,current_y + 61,play_time,color)
			draw_reset_halign()
		}
		else 
		draw_text_hyphen(column_x + 204,current_y + 61,"__:__",color) // TIME
		if !this_file_open
		draw_text_hyphen(column_x + 80,current_y + 76,room_name ?? "____________",color) // LOCATION
	}
	if this_file_open
	{
		in_selection = scr_leftright_modwrap(in_selection,2)
		var options = 
		[
			this_file.loaded ? "Resume" : "Start",
			"Back"
		]
			for (var s = 0; s < 2; s++)
				draw_text_shadow(column_x + 90 + 90 * s,current_y +76, options[s],c_white)
			draw_sprite_ext(spr_soul_menu,0,column_x + 81 + 90 * in_selection , current_y + 84,0.5,0.5,0,c_white,1)
			
		if interact
		{
			if !in_selection
			{
				instance_destroy()
				instance_create(obj_title_main,{file: this_file})
			}
			else back = true 
		}
		
		if back
		{
			selecting = false 
			in_selection = 0 
			play_sound(snd_menu_move)
			back = false
		}
	}
}


#region bottom menu 

if interact && bottom_selecting
	with current_menu.bottom_menu[bottom_selection]
			function_call(event,customevent_get_params())
var b_menu = current_menu.bottom_menu

var bottom_count = array_length(b_menu)

for (var i = 0; i < bottom_count; i ++)
{
	var current_option = b_menu[i]
	if !current_option.available continue; 
	var selected = (bottom_selecting && (i == bottom_selection))
	var color = selected ? c_white : c_gray
	var title = current_option.name  
	var bottom_col = (i % 3)
	var bottom_option_x = -13 + 10 + bottom_col * 85
	draw_text_shadow(bottom_option_x + 54,191 + (i div 3) * 20,title,color)
	if selected
		draw_sprite_ext(spr_soul_menu,0,40 + bottom_option_x - -8,4 + + 195 + (i div 3) * 20,0.5,0.5,0,c_white,1)
}
#endregion	

draw_text_shadow(40 ,31 ,top_text)