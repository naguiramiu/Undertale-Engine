if (border != spr_border_noone) 
&& (global.settings.border_type != e_bordertype.not_enabled) 
&& (global.settings.fullscreen || global.settings.show_border_windowed)
{
	var mult = global.settings.fullscreen ? 1 : 0.89
	var w = 960 * mult 
	var h = 540 * mult
	draw_set_alpha(ease_in_out(fade, 0, 1));
	gpu_set_tex_filter(true)
	var drawn_border = global.settings.border_type == e_bordertype.simple ? spr_border_simple : border
	draw_sprite_stretched(drawn_border, 0,x + -120 * mult,y, w, h);
	gpu_set_tex_filter(false) 
	draw_reset_alpha()
}

if (nextborder != noone)
{
	fade = max(0, fade - 0.05);
	if (fade == 0) || (border == spr_border_noone)
	{
		fade = 0;
		border = nextborder;
		nextborder = noone;
	}
}
else 
	fade = min(1, fade + 0.05);