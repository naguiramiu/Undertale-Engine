if area_draw_event != -1 
	area_draw_event()

#region data top
	draw_text(70,63,file.name)
	draw_set_halign(fa_center)
	draw_text(70 + 96,63,"LV " + string(file.lv))
	draw_set_halign(fa_right)
	draw_text(70 + 149 + 31,63,file.play_time)
	draw_set_halign(fa_left)
	draw_text(70,81,file.room_name)
#endregion

#region options
	draw_set_align_center()
	array_foreach(title_option,function(value,index){
	draw_text_color_ext(value.x,value.y,value.text,(selection == index ? c_yellow : c_white))})
	draw_reset_align()
	if can_move
	{
		move()
		if interact_key_press
				function_call(title_option[selection].event,customevent_get_params(,title_option[selection]))
	}
#endregion

scr_buildversion()

if whiten > 0
	screen_cover(c_white,whiten)