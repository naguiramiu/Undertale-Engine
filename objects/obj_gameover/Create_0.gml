depth = UI_DEPTH + 20
sprite = spr_soul
darken = false
image_alpha = 0
created = false
cutscene_perform_event = false 

var death_custscene = cutscene_create(
	cut_wait(40),
	cut_set_var(id,"darken",true),
	cut_set_var(id,"sprite",spr_soul_shatter),
	cut_playsound(snd_break1),
	cut_wait(40),
	cut_playsound(snd_break2),
	cut_perform_function(0,
		function()
		{
			var ev = obj_gameover
			for (var i = 0; i < 6;i++)
			with instance_create_depth(ev.x + (2 * (i -1)),ev.y + (i mod 3) * 3,ev.depth - 10,obj_empty)
			{
				direction = random(360)
				speed = 7
				gravity_direction = 270
				gravity = 0.2
				sprite_index = spr_soulbits
				image_speed = 0.2
			}
		}),
	cut_set_var(id,"sprite",spr_nothing),
	cut_wait(40),
	cut_interpolate_var(id,"image_alpha",0.1,0,1,0),
	cut_textbox(["You cannot give{&}up just yet...","You!{.}{&}Stay determined..."],,,
	{
		talker: { sound_to_play: snd_txtasg },
		textbox_position: DOWN, 
		draw_bg: false,
		letter_spacing: 4,
		x: 25,
		y: 10,
		write_speed: 0.5,
	}),
	cut_interpolate_var(id,"image_alpha",0.1,1,0,0),
	cut_perform_function(0,instance_destroy,id),
	cut_perform_function(0,room_goto,rm_setup)
)


cutscene_start(death_custscene,,true)
obj_camera.shake_strenght = 0
obj_camera.shake_duration = 0