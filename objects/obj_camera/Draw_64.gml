gpu_set_blendenable(false)
gpu_set_blendmode(bm_normal)

var draw_x = 0 
var draw_y = 0 
var draw_w = 640 
var draw_h = 480 

if global.settings.border_type != e_bordertype.not_enabled
{
	if global.settings.fullscreen || global.settings.show_border_windowed
	{
		var 
		final_mult = (display_get_gui_height() / surface_get_height(application_surface)) * 0.89,
		draw_w = surface_get_width(application_surface) * final_mult,
		draw_h = surface_get_height(application_surface) * final_mult,
		draw_x = (display_get_gui_width() - draw_w) / 2,
		draw_y = (display_get_gui_height() - draw_h) / 2
		//29.65 39.69 show_message(draw_x) show_message(draw_y)
	}
}
draw_surface_stretched(application_surface, draw_x, draw_y, draw_w, draw_h);
gpu_set_blendenable(true);
screen_cover(,screen_darken)