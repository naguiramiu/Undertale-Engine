if (fade) 
	image_alpha -= 0.1 

if image_alpha < 0 instance_destroy()


if (dmg > 0)
{
	var str = string(dmg) 
	var xl = x - string_width(str) / 2
	for (var i = 1; i <= string_length(str); i++)
	{
		var c = string_char_at(str,i)
		draw_sprite_ext(spr_dmgnum_o,real(c),xl,y,0.75,0.75,0,c_red,image_alpha)
		xl += 22
	}
}
else draw_sprite_ext(spr_dmgmiss_o,0,x,y,0.75,0.75,0,c_white,image_alpha)