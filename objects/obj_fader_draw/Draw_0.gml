if instance_exists(target)
{
	shader_set(sh_extra_alpha)
	shader_set_u_simple("u_alphamult",image_alpha)
	with target
	{
		var prev_x = x 
		var prev_y = y 
		x = other.x 
		y = other.y 
		event_perform(ev_draw,ev_draw_normal)
		x = prev_x
		y = prev_y
	}
	shader_reset()
}

if image_alpha > 0 image_alpha -= 0.1
else instance_destroy()