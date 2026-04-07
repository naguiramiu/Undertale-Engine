draw_sprite_ext(spr_undertale_logo_full,0,0,0,1,1,0,c_white,1)
if waited
{
	draw_set_colour(c_gray)
	draw_set_font(font_crypt_4)
	draw_set_align_center()
	draw_text(160,180,get_lan(lan_text_title).start_poppup_hint)
	draw_reset_align()
}
draw_set_font(font_deter_12)
draw_set_colour(c_white)

if keyboard_lastchar != ""
{
	keyboard_lastchars = string_copy(keyboard_lastchars + keyboard_lastchar,2,string_length(keyboard_lastchars))
	keyboard_lastchar = ""	
	
	var to_check = ["BALL","wwssadadbas"] // here you can easily add custom behaviours to play in the title if you type something
	if mouse_check_button_released(mb_left) clipboard_set_text(keyboard_lastchars)
	for (var i = 0; i < array_length(to_check); i++)
	if string_pos(string_upper(to_check[i]),string_upper(keyboard_lastchars))
	{
		switch to_check[i]
		{
			case "BALL": 
			if !ball_triggered
			play_sound(snd_ballchime) 
			ball_triggered = true 	
			break;
			case "wwssadadbas":
			play_sound(snd_item)
			break;
		}
		keyboard_lastchars = string_repeat(" ",string_length(keyboard_lastchars))
	}
}