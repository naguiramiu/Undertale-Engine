function window_initialize()
{
	global.window = 
	{
		not_fullscreen:
		{
			width: 640,
			height: 480,
		},
		width: 640,
		height: 480,
		viewport:
		{
			width: 320,
			height: 240,
		}
	}
}

function window_custom_reset(fullscreen = global.settings.fullscreen, show_border_windowed = global.settings.show_border_windowed, border_type = global.settings.border_type)
{
	var width = 640 
	var height = 480
	
	var resize = (fullscreen || (show_border_windowed && border_type != e_bordertype.not_enabled))
	
	if resize
	{
		width =	960
		height = 540
	}
	
	var do_mult = fullscreen && border_type != e_bordertype.not_enabled
	
	var mult = do_mult ? 0.89 : 1 
	
	window_set_size(width,height);
	display_set_gui_size(640 / mult, 480 / mult)
	
	do_later(1,window_center,,,{persistent: true})
}

function reajust_window_size(multiplicator)
{
	with (variable_clone(global.window))
	{
		width *= multiplicator;
		height *= multiplicator;
		var window_changer = self;
	}
	window_set_size(window_changer.width,window_changer.height);
	surface_resize(application_surface, global.window.viewport.width, global.window.viewport.height);
	window_center();
}

