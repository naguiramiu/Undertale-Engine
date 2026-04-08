alarm[0] = 10
my_dialogue = noone
cutscene_perform_event = false

var_struct = 
{
	can_skip_while_writting: false,
	stop_drawing_after_destroy: false,
	talker: global.talker.flowey_default,
	event_destroy: function()
	{
		if obj_flowey_firstcutscene_enemy.my_dialogue.perform_event
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
		my_dialogue = create_speechbubble(text,x + 62.5,y + 5.5,x,y + 15,140,_var_struct,false,99,45)
	}
}

add_text = function(text,advance,perform_end_event = true)
{
	cutscene_hold_arguments	
	
	time_till_next = advance ? 0 : -1
	
	with obj_flowey_firstcutscene_enemy
	{
		create_my_dialogue(text)
		my_dialogue.perform_event = perform_end_event
	}
}

destroy_dialogue = function()
{
	cutscene_hold_arguments
	
	if instance_exists(obj_flowey_firstcutscene_enemy.my_dialogue)
		instance_destroy(obj_flowey_firstcutscene_enemy.my_dialogue)

}

event_hit_bullet = function()
{
	get_char_by_party_position(0).hp = 1
	instance_destroy(obj_friendlypellet)
	shake_camera(10,3)
	globalmusic_stop(true)
	play_sound(snd_hurt,2,,,0.95)

	with obj_flowey_firstcutscene_enemy
	{
		var_struct.talker = global.talker.flowey_evil
		var_struct.texteffect_shake = true
		var_struct.write_speed = 0.5
		sprite_index = spr_flowey_grin
		var cut = cutscene_create
		(
			cut_wait(15),
			add_text("You idiot."),
			add_text("In this world, it's kill or BE killed."),
			add_text("Why would ANYONE pass up an opportunity like this!?"),
			cut_set_var(obj_flowey_firstcutscene_enemy,"sprite_index",spr_flowey_evil),
			cut_perform_function(0,function()
			{
				with obj_battlebox
				{
					width = 53 
					height = 47
					x = 160 
					y = 310	
				}
				
				with obj_flowey_firstcutscene_enemy
				event_perform(ev_alarm,2)
				
			}),
			cut_wait(80),
			cut_perform_function(-1,function()
			{
				with obj_flowey_firstcutscene_enemy
				{
					image_index = 1
					var _var_struct = variable_clone(var_struct)
					_var_struct.texteffect_shake = false
					_var_struct.perform_event = true
					_var_struct.font_current = font_add_sprite_ext(spr_bigdotumche,"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz,.?!*",true,4)
					my_dialogue = create_speechbubble("Die.",x + 62.5,y - 7,x,y + 18,140,_var_struct,false,99,45)
				}
			}),
			cut_perform_function(0,function()
			{
				obj_fakefriendlypellet.move = true
				play_sound(snd_floweylaugh)
				sprite_index = spr_flowey_grin_laugh
				sprite_talk = false 
				image_speed = 1
			}),
			cut_wait(140),
			cut_perform_function(0,final_event)
		)
		 
		cutscene_start(cut)
	
	
	}
}

sprite_talk = true 
final_event_triggered = false 

final_event = function()
{
	if final_event_triggered exit; 
	final_event_triggered = true
	
	with obj_battlebox
	{
		width = 53 
		height = 47
		x = 160 
		y = 310	
	}
	
	sprite_talk = false
	instance_destroy(obj_fakefriendlypellet)	

	image_speed = 0
	image_index = 0
	
	if audio_is_playing(snd_floweylaugh)
		audio_stop_sound(snd_floweylaugh)
	
	with get_char_by_party_position(0)
		hp = max_hp
		
	play_sound(snd_heal,2)
	shake_camera(10,3)
	
	var fire = instance_create_depth(x + 120, y + 20, depth - 1, obj_toriel_flame_cutscene)
	
	var cut = cutscene_create(
		cut_wait(40),
		cut_set_var(id,"sprite_index",spr_flowey_pissed),
		cut_set_var(id,"image_index",1),
		cut_wait(60),
		cut_set_var(fire,"sprite_index",spr_toriel_flame),
		cut_set_var(fire,"hspeed",-4),
		cut_wait(12),
		cut_set_var(id,"sprite_index",spr_flowey_face_shock, 10),
		cut_perform_function(0,function()
		{
			play_sound(snd_floweyhurt)
			instance_destroy(obj_toriel_flame_cutscene)
			
			with obj_flowey_firstcutscene_enemy
			{
				hspeed = -10
				vspeed = -0.5
				sprite_index = spr_flowey_hurt
			}
			globalmusic_stop()
		}),
		cut_wait(40),
		cut_perform_function(0,instance_create_depth,[cam_x + 380,cam_y + 100 + 19 + -41,obj_battlebox.depth - 10, obj_floweycutscene_toriel]),
		cut_interpolate_var(obj_floweycutscene_toriel,"x",0.05,cam_x + 380,obj_battlebox.x + -3,0),
		cut_set_var(obj_floweycutscene_toriel,"start",true)
	)
	cutscene_start(cut)
}