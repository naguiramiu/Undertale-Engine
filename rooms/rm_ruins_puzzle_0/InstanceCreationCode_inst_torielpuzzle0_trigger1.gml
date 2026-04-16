if global.flags.ruins.toriel_puzzle_0
{
	destroy_instances
	(
		[
			inst_ruinspuzzle0_door,
			inst_torielpuzzle0_trigger1,
			inst_torielpuzzle0_trigger2,
			inst_ruinspuzzle0_toriel
		]
	)
	obj_ruins_lever.image_index = 1
	
	exit;
}


var add_text = function(text,var_struct = {})
{
	cutscene_hold_arguments
	time_till_next = -1
	inst_ruinspuzzle0_toriel.my_dialogue = scr_create_cutscene_textbox(text,var_struct)
}

cutscene =  
[
	cut_textbox_talker(global.talker.toriel),
	add_text("* Welcome to your new home, innocent one."),
	add_text("* Allow me to educate you in the operation of the RUINS."),
	cut_perform_function(-1,function()
	{
		inst_torielpuzzle0_trigger2.can_start = true
		with inst_ruinspuzzle0_toriel
		{
			mask_index = spr_toriel_puzzle_hitbox
			path_start(pth_ruins_toriel_firstpuzzle,3,path_action_stop,true)
			movement = "walk"
			dialogue_talk = false
			stopped = false
			event_draw = function()
			{
				if path_index == -1 && !stopped 
				{
					path_speed = 0
					global.flags.ruins.toriel_puzzle_0 = true
					instance_destroy(inst_ruinspuzzle0_door)
					obj_ruins_lever.image_index = 1
					stopped = true 
					dir = UP
					play_sound(snd_noise)
					cutscene_next_event(obj_cutsceneplayer)
				}
			}
		}
	}),
	cut_wait(20),
	cut_set_var(inst_ruinspuzzle0_toriel,"animate_walking",true),
	cut_move_instance(inst_ruinspuzzle0_toriel,"x",-3,141),
	cut_move_instance(inst_ruinspuzzle0_toriel,"y",3,132),
	cut_set_var(inst_ruinspuzzle0_toriel,"animate_walking",false),
	cut_set_var(inst_ruinspuzzle0_toriel,"dialogue_talk",true),
	cut_set_var(inst_ruinspuzzle0_toriel,"movement","talk"),
	add_text("* The RUINS are full of puzzles."),
	add_text("* Ancient fusions between diversions and doorkeys."),
	add_text("* One must solve them to move from room to room."),
	add_text("* Please adjust yourself to the sight of them."),
	cut_wait(1),
	cut_can_move(true)
]
	