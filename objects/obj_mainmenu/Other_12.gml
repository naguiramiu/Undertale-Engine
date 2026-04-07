/// @description Cell

var _x = 45 + x
var _y = -7 + y

draw_menu(_x + 188,_y + 52,345,377,6) // bg menu

gpu_set_tex_filter(true)
draw_sprite_stretched(spr_sprite133,0,_x + 194,_y + 58,200 + 134,100 + 133 * 2)
gpu_set_tex_filter(false)

if (back_key || interact_key)
{
	back_key = false 
	interact_key = false
	menu_open = false 
	if !back_key_press
	play_sound(snd_menu_move)	
}