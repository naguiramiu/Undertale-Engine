goto_main_settings = function()
{
	main_selection = prev_sel
	play_sound(snd_menu_move)
	settings = 
	[
		new setting("exit_text",e_settingstype.event,,instance_destroy,obj_title_settings),
		new setting("language_text",e_settingstype.event,,do_later,[1,goto_language_settings]),
		new setting("keys_text",e_settingstype.event,,do_later,[1,goto_key_settings]),
		new setting("borders",e_settingstype.array,"border_type",,,["border_value_disabled","border_value_simple","border_value_enabled"]),
		new setting("show_border_windowed",e_settingstype.boolean,"show_border_windowed"),
		new setting("gen_volume",e_settingstype.slider,"gen_volume"),
		new setting("snd_volume",e_settingstype.slider,"snd_volume"),
		new setting("mus_volume",e_settingstype.slider,"mus_volume"),
	]
	
	// if your border isnt enabled then remove the show border windowed setting from the list
	if (global.settings.border_type == e_bordertype.not_enabled)
		array_remove_value_ext(settings,function(i){return (settings[i].var_name == "show_border_windowed")})
	
	if ENABLE_RUNNING
	array_push(settings,new setting("auto_run",e_settingstype.boolean,"auto_run"))
}
goto_language_settings = function()
{
	prev_sel = main_selection
	settings = [new setting("exit_text",e_settingstype.event,,goto_main_settings)]
	array_foreach(scr_get_languages(),function(value,index)
	{
		array_push(settings, new setting(filename_nameonly(value),e_settingstype.event,,function(value)
		{
			scr_load_language(value)
			goto_language_settings() // reload the settings menu
		},value,,false))
	})
	play_sound(snd_menu_move)
}

goto_key_settings = function()
{
	prev_sel = main_selection
	main_selection = 0
	settings = [new setting("finish",e_settingstype.event,,do_later,[1,goto_main_settings])]
	var implicit_order = ["up","left","down","right","confirm","back","menu"]
	array_foreach(implicit_order,function(keyvalue,keyindex)
	{
		array_push
		(
		settings,
			new setting
			(
				get_lan(lan_text_title,"settings","keys","key_" + keyvalue),
				e_settingstype.key,
				keyvalue,,,,
				false
			)
		)
	}) 
	array_push
	(
	settings, 
		new setting
		(
			"reset",
			e_settingstype.event,,
			variable_struct_set,
			[global.settings,"keys",scr_default_keys()]
		)
	)
	play_sound(snd_menu_move)
}


setting = function(_text,_type,_var_name = undefined,_event = undefined,_event_params = undefined,_values = undefined,get_language = true) constructor
{
	var lan = get_lan(lan_text_title).settings
	text = get_language ? get_lan(lan,_text) : _text
	type = _type;
	var_name = _var_name
	event = _event
	if !is_undefined(_event_params) 
	event_params = _event_params
	values = []
	for (var i = 0; i < array_length(_values); i++)
	values[i] = get_lan(lan,_values[i])
	text_scale = 1
	draw_set_font(font_deter_12)
	while (string_width(text) * text_scale) > 123 
	text_scale -= 0.01
	lerp_amount = 0
}

var weather = function(_mus_played,_text, _tobdog_sprite,_fall_obj_var_struct, _event = -1) constructor
{
	mus_played =  _mus_played
	text = _text
	tobdog_sprite = _tobdog_sprite	
	fall_obj_var_struct = _fall_obj_var_struct
	event = _event
}

weather_layout = 
[
	new weather(mus_options_winter,"cold outside{&}but stay warm{&}inside of you",spr_tobdog_winter,{sprite_index: spr_christmasflake}),
	new weather(mus_options_fall,"spring time{&}back to school",spr_tobdog_spring,{sprite_index: spr_fallleaf, image_blend: merge_color(c_red, c_white, 0.5)}),
	new weather(mus_options_summer,"try to withstand{&}the sun's life-{&}giving rays",spr_tobdog_summer,{},function(this)
	{
		with this 
		{
			var siner = current_time / 100
			var timer1 = current_time div 240
			draw_sprite_ext(tobdog_sprite, floor(siner / 15), 250, 225, 2 + (sin(siner / 15) * (0.2 + (timer1 / 900))), 2 - (sin(siner / 15) * (0.2 + (timer1 / 900))), 0, c_white, 1);
			draw_circle_colour(258 + (cos(siner / 18) * 6), 40 + (sin(siner / 18) * 6), 28 + (sin(siner / 6) * 4),c_yellow,c_yellow, 0)
			draw_text_color_ext(220 + sin(siner / 12), 120 + cos(siner / 12), string_linebreaks(text), c_gray, 1,1, -20)
		}
	}),
	new weather(mus_options_fall,"sweep a leaf{&}sweep away a{&}troubles",spr_tobdog_autumn,{sprite_index: spr_fallleaf, image_blend: choose(c_yellow, c_orange, c_red)}),
]