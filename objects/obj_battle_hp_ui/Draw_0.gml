var ary = array_length(global.stats.party)

if (ary <= 1)
{
	#region ui bottom
	var char = get_char_by_party_position(0)
		draw_set_font(font_mars_18)
		draw_set_colour(c_white)
		draw_text_transformed(cam_x + 15,cam_y + 200,char.name + "   LV " + string(global.stats.lv),0.5,0.5,0)
		var hp = max(0,char.hp)
		var hp_barwdith_filled = ((char.max_hp * 1.3) / 2) - 1
		var hp_barwdith = clamp((hp >= 0 ? (hp_barwdith_filled * (hp / char.max_hp)) : 0), 0,hp_barwdith_filled)
		draw_text_transformed(cam_x + 147.5 + hp_barwdith_filled - 3, cam_y + 200,string(hp) + " / " + string(char.max_hp),0.5,0.5,0);
		draw_set_color(c_red)
		draw_rectangle_wh(cam_x + 137.5, cam_y + 200,hp_barwdith_filled, 10, false)
		draw_set_color(c_yellow)
		draw_rectangle_wh(cam_x + 137.5, cam_y + 200,hp_barwdith, 10, false)
		draw_set_color(c_white)
		draw_set_font(font_8bit_9)
		draw_text_transformed(cam_x + 128.5,cam_y + 201.5, "P",0.5,0.5,0)
		draw_text_transformed(cam_x + 122, cam_y + 201.5, "H",0.5,0.5,0)
	#endregion
	exit;	
}




with obj_battlecontroler
{
	var ary = array_length(global.stats.party)
	var w = 82 + 10;
	var h = 16; 
	var x_spacing = 20;
	if ary = 3 x_spacing = 5
	var screen_bottom_y = 240;
	var margin = 10; 
	var screen_mid_x = 160
	var total_block_width = (ary * w) + ((ary - 1) * x_spacing);
	var start_x = screen_mid_x - (total_block_width / 2);
	for (var i = 0; i < ary; i++)
	{
		var char = get_char_by_party_position(i)
		var draw_y = cam_y + 3 + -20 + screen_bottom_y - h - margin;
	    var draw_x = cam_x + start_x + (i * (w + x_spacing));
		var char_color_start = char.ui_color
		var white = c_white
		var red = c_red
		var s = 0.25
		if i == selected_char_number || battle_started
		{
			if other.ui_anim[i] < 1 other.ui_anim[i] += s
			if !battle_started
			draw_sprite(spr_arrow_1,0,draw_x - 16, draw_y + 1)
		}
		else 
		{
			if other.ui_anim[i] > 0 other.ui_anim[i] -= s
		}
		
		if char.hp <= 0 
		{
			other.ui_anim[i] = 0
			var am = 0.5
			char_color_start = merge_colour(c_black,char_color_start,am)	
			white = merge_colour(c_black,c_white,am)
			red = merge_colour(c_black,c_red,am)	
		}
		draw_y += ease_out(other.ui_anim[i],1,0) * -10
	
		draw_set_colour(merge_colour(merge_colour(c_black,red,0.5),red,other.ui_anim[i]))
		draw_rectangle_wh(draw_x + 30,draw_y + 8 + 1,18,5,0)
		var char_color = merge_colour(merge_colour(c_black,char_color_start,0.5),char_color_start,other.ui_anim[i])
		draw_set_colour(char_color)
		draw_rectangle_wh(draw_x,draw_y,w,h,1)
		if char.hp >= 0
		draw_rectangle_wh(draw_x + 30,draw_y + 8 + 1,(char.hp / char.max_hp) * 18,5,0)
		draw_set_color(merge_colour(merge_colour(white,c_black,0.5),white,other.ui_anim[i]))
		draw_set_font(font_crypt_4)
		draw_text(draw_x + 19,draw_y + 3 + 1,char.name)
		draw_text(draw_x + 19,draw_y + 3 + 6 + 1,"HP")
		draw_set_halign(fa_right)
		draw_text(draw_x + w + -1,draw_y + 10,char.max_hp)
		draw_sprite_ext(spr_ui_bar,0,draw_x + w + -3 - string_width(char.max_hp), draw_y + 9,1,1,0,draw_get_colour(),1)
		draw_text(draw_x + w + -9 - string_width(char.max_hp),draw_y + 10,char.hp)
		draw_set_halign(fa_left)
	
		var _sprite = spr_face_noicon
		draw_sprite_ext(_sprite,0,draw_x + 9, draw_y + 8,1,1,0,char_color,1)
	}
}
draw_reset_color()