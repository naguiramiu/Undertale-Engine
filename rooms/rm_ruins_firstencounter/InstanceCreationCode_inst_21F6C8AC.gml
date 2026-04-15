event_interact = function()
{
	if global.flags.ruins.toriel_lever_1
	{
		instance_destroy()	
		exit;
	}
	
	if inst_ruins00_lever2.image_index == 0 
	{
		inst_ruins00_lever0.image_index = 1
		play_sound(snd_noise)
	}
	
	if obj_npc_base.x > x + 40
	obj_npc_base.my_dialogue = create_textbox
	(
		[
			"{emotion:confused}* No no no!",
			"{emotion:happy}* You want to press the other switch.",
			"{emotion:confused}* I even labelled it for you..."
		],
		obj_npc_base.dialogue_var_struct
	)
	else 
	{
		play_sound(snd_wrongvictory)
		create_textbox("* (Wow!){&.}* (You are super fast at being wrong.)")
	}
}