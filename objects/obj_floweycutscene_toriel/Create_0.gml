my_dialogue = noone 
sprite_talk = true

var_struct = 
{
	can_skip_while_writting: false,
	stop_drawing_after_destroy: false,
	talker: global.talker.toriel,
	event_destroy: function()
	{
		if obj_floweycutscene_toriel.my_dialogue.perform_event
			do_later(1,function()
			{
				with obj_cutsceneplayer	
					play_cutscene_event()
			})
	}
}

create_my_dialogue = function(text,_var_struct = var_struct)
{
	if !instance_exists(my_dialogue)
	{
		image_index = 1
		my_dialogue = create_speechbubble(text,x + 62.5 + -14,y + 5.5 + -52,x - 20,y - 30,140,_var_struct,false,99,45)
	}
}

add_text = function(text,advance,perform_end_event = true)
{
	cutscene_hold_arguments	
	
	time_till_next = advance ? 0 : -1
	
	with obj_floweycutscene_toriel
	{
		create_my_dialogue(text)
		my_dialogue.perform_event = perform_end_event
	}
}


cutscene_perform_event = false

var cut = cutscene_create
(
	cut_wait(50),
	[globalmusic_play,mus_fallendown2,100,100],
	add_text("What a terrible creature, torturing such a poor, innocent youth..."),
	add_text("Ah, do not be afraid, my child."),
	add_text("I am {c:b}TORIEL{/c}, caretaker of{&}the {c:r}RUINS{/c}."),
	add_text("I pass through this place every day to see if anyone has fallen down."),
	add_text("You are the first human to come here in a long time."),
	add_text("I will do my best to ensure your protection during your time here."),
	add_text("Come!{.&}I will guide you through the catacombs."),
	cut_wait(10),
	cut_interpolate_var(obj_camera,"screen_darken",0.1,0,1,0),
	cut_perform_function(0,function()
	{
		global.flags.ruins.flowey_cutscene_0 = true
		
		with obj_flowey_firstcutscene_controller
		{
			with all
				if layer == other.lay 
					instance_destroy()
		}
		
		destroy_instances(
		[
			obj_guidearrows,
			obj_floweycutscene_toriel,
			obj_flowey_firstcutscene_controller,
			obj_flowey_firstcutscene_enemy,
			obj_battle_background_dark,
			obj_battlebox,
			obj_soul,
		])
		lerp_var_ext(obj_camera,"screen_darken",0.1,1,0)	
		instance_activate_object(parent_char)
	})
)

cutscene_start(cut)