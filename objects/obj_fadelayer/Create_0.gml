alpha = 0

var layers = layer_get_all()

for (var i = 0; i < array_length(layers); i++)
{
	if string_starts_with(layer_get_name(layers[i]),prefix)	
	{
		layer_script_begin(layers[i],function ()
		{
			if event_type == ev_draw
			{
				shader_set(sh_fullalpha)
				shader_set_uniform_f(shader_get_uniform(shader_current(),"u_alpha"),self.alpha)
			}
		})	
		layer_script_end(layers[i],function ()
		{
			if event_type == ev_draw
			{
				if shader_current() != -1 shader_reset()
			}
		})
	}
}

