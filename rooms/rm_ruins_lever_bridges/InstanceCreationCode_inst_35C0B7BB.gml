if (global.flags.ruins.toriel_lever_puzzle >= 3)
 {
	instance_destroy()
	exit;
 }

var event_set_tori_next = function()
{
	with (obj_npc_base)
	{
		mask_index = spr_toriel_talk_down
		x = 455
		dir = LEFT
		dialogue = "* The first switch is over on the wall."
		movement = "talk"
		animate_walking = false
		dialogue_next = [["{emotion:worried}{/linebreak}* Do you need some help..?{.&}* Press the switch on the{&}wall.","{/emotion}* Come on, you can do it!"]]
	}
}

tori = instance_create_depth(171,162,depth,obj_npc_base,
{
	sprite_name: "spr_toriel_{movement}_{dir}",
	movement: "talk",
	talker: global.talker.toriel
})

if (global.flags.ruins.toriel_lever_puzzle > 0)
{
	event_set_tori_next()
	instance_destroy()
	exit	
}

var add_text = function(text,var_struct = {},toriel = tori)
{
	cutscene_hold_arguments
	time_till_next = -1
	toriel.my_dialogue = scr_create_cutscene_textbox(text,toriel.dialogue_var_struct)
}

cutscene = cutscene_create
(
	add_text("* To make progress here, you will need to trigger several switches."),
	add_text("* Do not worry, I have labelled the ones that you need to flip."),
	cut_wait(1), 
	cut_can_move(true),
	cut_set_var(tori,"movement","walk"),
	cut_set_var(tori,"animate_walking",true,0),
	cut_perform_function(0,function()
	{
		global.flags.ruins.toriel_lever_puzzle = 1
	}),
	cut_move_instance(tori,"x",3,455), 
	cut_perform_function(0,event_set_tori_next),
) 