/// @description Setup methods

x = cam_x + 137.5
y = cam_y + 65 
depth = BATTLE_DEPTH
set_border(spr_border_simple)
draw_soul = false
cutscene_perform_event = false
draw_chars = true
global.can_move = false 
soul_progress = 0
battle_fade_alpha = 1
my_dialogue = noone

var_struct = 
{
	can_skip: true,
	can_skip_while_writting: false,
	stop_drawing_after_destroy: false,
	talker: global.talker.flowey_default,
	max_sentence_width: 140,
	event_destroy: function()
	{
		if obj_flowey_firstcutscene_controler.my_dialogue.perform_event
			do_later(1,function()
			{
				with obj_cutsceneplayer	
					play_cutscene_event()
			})
	}
}
set_evil_voice = function()
{
	with obj_flowey_firstcutscene_controler.var_struct	
	{
		talker = global.talker.flowey_evil
		texteffect_shake = true
		write_speed = 0.5
	}
}
create_my_dialogue = function(text,_var_struct = var_struct)
{
	if !instance_exists(my_dialogue)
	{
		image_index = 1
		my_dialogue = create_speechbubble(text,x + 62.5,y + 5.5,x,y + 15,140,_var_struct,false,99,45)
	}
}

add_text = function(text,advance,perform_end_event = true)
{
	cutscene_hold_arguments	
	
	time_till_next = advance ? 0 : -1
	
	with obj_flowey_firstcutscene_controler
	{
		create_my_dialogue(text)
		my_dialogue.perform_event = perform_end_event
	}
}

destroy_dialogue = function()
{
	cutscene_hold_arguments
	
	if instance_exists(obj_flowey_firstcutscene_controler.my_dialogue)
		instance_destroy(obj_flowey_firstcutscene_controler.my_dialogue)

}


