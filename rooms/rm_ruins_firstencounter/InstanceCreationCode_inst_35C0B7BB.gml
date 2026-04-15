if global.flags.ruins.toriel_lever_0
{
	instance_destroy()
	exit	
}

instance_destroy(inst_2B7C7ABB)

var add_text = function(text,var_struct = {},toriel = tori)
{
	cutscene_hold_arguments
	time_till_next = -1
	toriel.my_dialogue = scr_create_cutscene_textbox(text,toriel.dialogue_var_struct)
}

tori = instance_create_depth(171,162,depth,obj_npc_base,
{
	sprite_name: "spr_toriel_{movement}_{dir}",
	movement: "talk",
	movespeed: 3,
	talker: global.talker.toriel
})



cutscene = cutscene_create
(
	add_text("* To make progress here, you will need to trigger several switches."),
	add_text("* * Do not worry, I have labelled the ones that you need to flip."),
	cut_wait(1), 
	cut_can_move(true),
	cut_set_var(tori,"movement","walk"),
	cut_set_var(tori,"animate_walking",true,0),
	cut_set_var(tori,"move",RIGHT,94),
	cut_set_var(tori,"move",-1,0),
	cut_set_var(tori,"dir",LEFT,0),
	cut_set_var(tori,"dialogue","* The first switch is over on the wall."),
	cut_set_var(tori,"movement","talk"),
	cut_set_var(tori,"animate_walking",false),
	cut_set_var(tori,"dialogue_next",[["{emotion:worried}{/linebreak}* Do you need some help..?{.&}* Press the switch on the{&}wall.","{/emotion}* Come on, you can do it!"]]),
) 