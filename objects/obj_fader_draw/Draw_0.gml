if instance_exists(target)
{
	shader_set(sh_extra_alpha)
	shader_set_u_simple("u_alphamult",image_alpha)
	with target event_perform(ev_draw,ev_draw_normal)
	shader_reset()
}

if image_alpha > 0 image_alpha -= 0.1
else instance_destroy()