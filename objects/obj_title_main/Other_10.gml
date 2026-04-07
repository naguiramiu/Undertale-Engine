/// @description Start 
globalmusic_play(mus_menu1,0)

var lan = get_lan(lan_text_title)
title_option = 
[
	{	
		x: 113, y: 114, 
		text: lan.title_options_continue,  
		event: function(num)
		{
			load_game(num)	
			lerp_var_ext(obj_camera,"screen_darken",0.05,1,0)	
		},
		event_parameters: savefile_number
	},
	{	
		x: 212, y: 114, 
		text: lan.title_options_reset,  
		event: function()
		{
			obj_title_main.visible = false
			with instance_create(obj_title_namescreen)
			{
				in_instructions = false 
				name_chosen = true 
				name = obj_title_main.file.name
				lerp_var_ext(id,"name_lerp",0.01,0,1) 
				load_from_file = false
				top_text = string_linebreaks("A name has already{&}been chosen.")
			}
			//globalmusic_stop()
			//obj_title_main.can_move = false
			//play_sound(snd_cymbal)
			//lerp_var_ext(obj_title_main,"whiten",0.0067,0,1)
			//lerp_var_ext(obj_camera,"shake_strenght",0.0067,0,1)
			//obj_camera.shake_duration = 200
			//do_later(200,load_game,[obj_title_main.savefile_number,false])
		}
	},
	{	
		x: 113 + (NUMBER_OF_SAVEFILES == 1) * 47, y: 134, 
		text: lan.title_options_settings,  
		event: instance_create,
		event_parameters: [obj_title_settings,{}]
	}
]

if NUMBER_OF_SAVEFILES > 1 
{
	array_push(title_option,
	{	
		x: 212, y: 134, 
		text: lan.title_options_return,  
		event: function(){
			instance_destroy(obj_titlescreen)
			instance_create(obj_fileselect)
		}
	})
}
