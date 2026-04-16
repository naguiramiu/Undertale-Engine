associated_lever = inst_ruins00_lever0

if (global.flags.ruins.toriel_lever_puzzle >= 3)
{
	associated_lever.image_index = 1 
	instance_destroy()
	exit;
}

cutscene_perform_event = false 
tori = obj_npc_base

cut = cutscene_create
(
	cut_set_var(tori,"dir",RIGHT),
	cut_set_var(tori,"dialogue",""), 
	cut_set_var(tori,"animate_walking",true),
	cut_set_var(tori,"movement","walk"),
	cut_move_instance(tori,"x",3,670),
	cut_set_var(tori,"move",-1),
	cut_set_var(tori,"dir",LEFT,0),
	cut_set_var(tori,"dialogue","* Go on, press the switch on the left."),
	cut_set_var(tori,"movement","talk"),
	cut_set_var(tori,"animate_walking",false),
	cut_set_var(tori,"dialogue_next",[["{emotion:worried}* You do know which way left is, do you not?","{/emotion}* Press the switch that I labelled for you."]]),
)


if (global.flags.ruins.toriel_lever_puzzle == 2)
{
	cutscene_start(cut)
	associated_lever.image_index = 1	
	exit;
}

first_bridge_block = create_collision(480,140,2,2)

event_interact = function()
{
	if (associated_lever.image_index == 0)
	{
		global.flags.ruins.toriel_lever_puzzle = 2
		associated_lever.image_index = 1
		play_sound(snd_noise)
		instance_destroy(obj_cutsceneplayer)
		tori.dir = RIGHT 
		instance_destroy(first_bridge_block)
		cutscene_start(cut)
	}
}