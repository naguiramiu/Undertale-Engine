associated_lever = inst_ruins00_lever1

event_progressed = function()
{
	obj_spikes.image_index = 1
	associated_lever.image_index = 1 
	instance_destroy()
}


if (global.flags.ruins.toriel_lever_puzzle >= 3)
{
	event_progressed()
	exit;
}

event_interact = function()
{
	if (associated_lever.image_index == 0)
	{
		event_progressed()
		
		inst_ruins_puzzle0wronglever.event_interact = inst_ruins_puzzle0wronglever.event_after_cutscene
		
		play_sound(snd_screenshake)
		shake_camera(20,4)
		instance_destroy(obj_cutsceneplayer)
		
		cutscene_perform_event = false 
		global.flags.ruins.toriel_lever_puzzle = 3
		global.can_move = false
		
		tori = obj_npc_base
		tori.dir = LEFT
		tori.dialogue = ""
		
		var add_text = function(text,var_struct = {},toriel = tori)
		{
			cutscene_hold_arguments
			toriel.my_dialogue = scr_create_cutscene_textbox(text,toriel.dialogue_var_struct)
			time_till_next = -1
		}
		
		var cut = cutscene_create
		(
			cut_wait(20),
			add_text("* Splendid!{.&}* I am proud of you, little one."),
			add_text("* Let us move to the next room."),
			cut_set_var(tori,"movement","walk"),
			cut_set_var(tori,"animate_walking",true,1),
			cut_can_move(true),
			cut_move_instance(tori,"x",3,room_width + 20),
			cut_perform_function(0,instance_destroy,tori)
		)
		cutscene_start(cut)
	}
}