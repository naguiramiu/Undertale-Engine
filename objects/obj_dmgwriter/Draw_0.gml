if (fade) 
	image_alpha -= 0.25 

if (anim) && dmg != 0
{
	vspeed += 0.25 	
	
	if vspeed > 2
	{
		vspeed = 0
		anim = false
	}
}

if image_alpha < 0 instance_destroy()


if (dmg > 0)
{
	var str = string(dmg)
	var char_w = -2 + sprite_get_width(spr_dmgnum_o) / 2
	var total_w = string_length(str) * char_w
	var xl = x - (total_w / 2) + (char_w / 2);
	for (var i = 1; i <= string_length(str); i++)
	{
	    var c = string_char_at(str, i);
	    draw_sprite_ext(spr_dmgnum_o, real(c), xl, y, 0.5, 0.5, 0, c_red, image_alpha);
	    xl += char_w
	}
}
else draw_sprite_ext(spr_dmgmiss_o,0,x,y,0.5,0.5,0,c_ltgray,image_alpha)

draw_set_alpha(image_alpha)
var xx = xstart 
var yy = ystart + 10
var hh = 6
var ww = 50
draw_set_colour(c_dkgray)
var left_edge = xx - (ww / 2) 
draw_rectangle_wh(left_edge, yy, ww, hh, false)
var w = (shown_hp / target.max_hp) * ww
draw_set_colour(c_lime)
if shown_hp > 0
    draw_rectangle_wh(left_edge, yy, w, hh, false)
draw_reset_color()
draw_reset_alpha()