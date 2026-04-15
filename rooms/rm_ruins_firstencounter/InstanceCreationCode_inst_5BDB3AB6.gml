if 	global.flags.ruins.toriel_lever_1
{
	obj_spikes.image_index = 1
	inst_ruins00_lever1.image_index = 1 
	instance_destroy()
	exit;
}

event_interact = function()
{
	if inst_ruins00_lever1.image_index == 0 
	{
		inst_ruins00_lever1.image_index = 1
		play_sound(snd_screenshake)
		shake_camera(20,4)
		instance_destroy(obj_cutsceneplayer)
		obj_spikes.image_index = 1
		cutscene_perform_event = false 
		global.flags.ruins.toriel_lever_1 = true
		tori = obj_npc_base
		
		var add_text = function(text,var_struct = {},toriel = tori)
		{
			cutscene_hold_arguments
			time_till_next = -1
			toriel.my_dialogue = scr_create_cutscene_textbox(text,toriel.dialogue_var_struct)
		}
		tori.dir = LEFT
		global.can_move = false
		tori.dialogue = ""
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