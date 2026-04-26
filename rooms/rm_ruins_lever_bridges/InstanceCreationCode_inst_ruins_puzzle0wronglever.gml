event_after_cutscene = 
function()
{
	create_textbox("* This switch doesn't even work...")	
}

if global.flags.ruins.toriel_lever_puzzle >= 3 
{
	event_interact = event_after_cutscene
	exit;	
}

associated_lever = inst_ruins00_lever2

event_interact = function()
{
	if (associated_lever.image_index == 0) 
	{
		associated_lever.image_index = 1
		play_sound(snd_noise)
	}
	
	var tori = obj_npc_base
	
	if (tori.x > x + 40)
	tori.my_dialogue = create_textbox
	(
		[
			"{emotion:confused}* No no no!",
			"{emotion:happy}* You want to press the other switch.",
			"{emotion:confused}* I even labelled it for you..."
		],
		tori.dialogue_var_struct
	)
	else 
	{
		play_sound(snd_wrongvictory)
		create_textbox("* (Wow!){&.}* (You are superfast at being wrong.)")
	}
}