x = obj_battlebox.x - obj_battlebox.width / 2
y = obj_battlebox.y - obj_battlebox.height / 2
width = obj_battlebox.width 
height = obj_battlebox.height

//wh stands for width and height

//draw_rectangle_wh(x + 5,y + 5,width - 12,height - 11,1)

var num = array_length(global.stats.party)
draw_set_font(font_crypt_4)
var padding = 5 
var spacing = 4
var total_x = x + padding
var total_y = y + padding
var total_w = (width - 2) - (padding * 2)
var total_h = (height - 1) - (padding * 2)
var available_h = total_h - (spacing * (num - 1))
var member_h = round(available_h / num)
var start_x_off = 32
var sel_bar_w = total_w * 0.33
for (var i = 0; i < num; i++)
{
	var char = get_char_by_party_position(i)
    var draw_y = total_y + (i * (member_h + spacing))
    draw_set_colour(char.ui_color)
	draw_line_colour(total_x + start_x_off + sel_bar_w + 3,draw_y + -1.1,total_x + total_w + -24,draw_y + -1.1,draw_get_colour(),c_black)
	draw_line_colour(total_x + start_x_off + sel_bar_w + 3,round(draw_y + member_h ) + 0.2,total_x + total_w,round(draw_y + member_h) + 0.2,draw_get_colour(),c_black)

	
	for (var a = 0; a < 3; a ++)
	draw_sprite_stretched_ext(spr_target_arrow,0, round(max(sin((current_time * 0.0075) + a * 208),0)) + total_x + start_x_off + 14 + 26 * a,draw_y + spacing - 0.5,26,member_h - spacing,merge_colour(draw_get_colour(),c_black,(a / 3) * 0.8),(1 + -(abs(sin((current_time * 0.0025) + a * 40) + 0.5) * 0.2)) * draw_get_alpha())
	
    draw_rectangle_wh(total_x + start_x_off + 3, draw_y,sel_bar_w, member_h, true)
	draw_set_halign_center()
	draw_text(total_x + start_x_off / 2,draw_y + member_h / 2,"PRESS")
	draw_reset_align()
	draw_sprite_stretched_ext(spr_targetfield_1,current_time / 100,round(total_x + start_x_off + 2),draw_y - 1,8,member_h + 2.5,draw_get_colour(),draw_get_alpha())
}
