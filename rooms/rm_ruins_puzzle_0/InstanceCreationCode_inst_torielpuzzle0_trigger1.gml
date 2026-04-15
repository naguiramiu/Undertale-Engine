if global.flags.ruins.toriel_puzzle_0
{
	destroy_instances(
	[
		inst_ruinspuzzle0_door,
		inst_torielpuzzle0_trigger1,
		inst_torielpuzzle0_trigger2,
		inst_ruinspuzzle0_toriel
	])
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
		inst_torielpuzzle0_trigger2.mask_index = spr_toriel_puzzle_hitbox
		with inst_ruinspuzzle0_toriel
		{
			path_start(pth_ruins_toriel_firstpuzzle,2.5,path_action_stop,true)
			sprite_name = "spr_toriel_walk_{dir}"
			dialogue_talk = false
			stopped = false
			c = 0
			event_draw = function()
			{
				if path_index == -1 && !stopped 
				{
					global.flags.ruins.toriel_puzzle_0 = true
					instance_destroy(inst_ruinspuzzle0_door)
					obj_ruins_lever.image_index = 1
					movespeed = 2
					stopped = true 
					dir = UP
					stopped = true
					path_speed = 0
					play_sound(snd_noise)
					do_later(20,cutscene_next_event,obj_cutsceneplayer)
				}
			}
		}
	}),
	cut_set_var(inst_ruinspuzzle0_toriel,"animate_walking",true),
	cut_set_var(inst_ruinspuzzle0_toriel,"move",LEFT),
	cut_wait(33),
	cut_set_var(inst_ruinspuzzle0_toriel,"move",DOWN),
	cut_wait(24),
	cut_set_var(inst_ruinspuzzle0_toriel,"move",-1),
	add_text("* The RUINS are full of puzzles."),
	add_text("* Ancient fusions between diversions and doorkeys."),
	add_text("* One must solve them to move from room to room."),
	add_text("* Please adjust yourself to the sight of them."),
	cut_wait(1),
	cut_can_move(true)
]
	