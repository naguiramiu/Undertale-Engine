//alarm[0] = 10
event_user(0)

var get = truefile_get("flowey_firstcutscene_met") ?? 0
truefile_write({flowey_firstcutscene_met: get + 1})

var cutscene = cutscene_create
(
	cut_playsound(snd_noise,,4),
	cut_playsound(snd_noise,,4),
	cut_set_var(id,"draw_chars",false),
	cut_set_var(id,"draw_soul",true,2),
	cut_playsound(snd_battlefall),
	cut_interpolate_var(id,"soul_progress",0.05,0,1,0),
	cut_perform_function(0,function()
	{
		instance_create(obj_battle_background_dark)	
		instance_deactivate_object(parent_char)
		
		with instance_create(obj_battlebox)
		{
			
			width = global.battlebox_width 
			height = global.battlebox_height
			visible = true
		}
			
		destroy_instances(obj_flowey_firstcutscene_controler.to_destroy)	
		with instance_create_depth(cam_x + 158,cam_y + 160,BATTLE_DEPTH,obj_soul)
		instance_create_depth(x,y,depth + 1,obj_guidearrows)
		
	}),
	cut_interpolate_var(id,"battle_fade_alpha",0.1,1,0,0),
	cut_set_var(obj_soul,"can_move",true),
	add_text("See that heart?{.&}That is your SOUL, the very culmination of your being!"),
	add_text("Your SOUL starts off weak, but can grow strong if you gain{&}a lot of LV."),
	add_text("You want some LOVE, don't you?"),
	add_text("Don't worry,{&}I'll share some{&}with you!"),
	destroy_dialogue(),
	cut_perform_function(0,function()
	{
		if instance_exists(obj_guidearrows)
			instance_destroy(obj_guidearrows)
	
		with obj_flowey_firstcutscene_controler
		{
			sprite_index = spr_flowey_wink
		
			instance_create_depth(x + 20,y + 5,depth - 10,obj_event_performer,
			{
				image_xscale: 0.5,
				image_yscale: 0.5,
				friction: 0.8,
				speed: 8,
				timer: 60, 
				sprite_index: spr_winkstar,
				event_draw: function()
				{
					if (timer < 30)
				    image_alpha -= 0.1;

					image_angle += 8;
					direction = image_angle
					if timer > 0 timer --
					else instance_destroy()
			
					draw_self()
				}
		
			})
			
			alarm[1] = 60
		}
	}),
	cut_wait(60),
	cut_perform_function(1,function()
	{
		obj_flowey_firstcutscene_controler.var_struct.can_skip = false
		instance_destroy(obj_friendlypellet)
		repeat 5 
		instance_create_depth(x + 21,y + 23,obj_battlebox.depth - 10, obj_friendlypellet,
		{
			speed: 2,
		})
		sprite_index = spr_flowey_side_0
	}),
	add_text("Down here, LOVE is shared through..."),
	add_text("Little white... {.}\"friendliness pellets.\"",true),
	cut_wait(35),
	cut_set_var(obj_flowey_firstcutscene_controler,"sprite_index",spr_flowey_side_1,-1),
	add_text("Are you ready?",true),
	cut_set_var(obj_flowey_firstcutscene_controler,"sprite_index",spr_flowey_dialogue,-1),
	cut_perform_function(0,function()
	{
		with obj_friendlypellet
		{
			direction = point_direction(x,y,obj_soul.x,obj_soul.y)
			speed = 1.5
		}
	}),
	add_text("Move around!{.&}Get as many as you can!",true,false),
	cut_wait(80), 
	destroy_dialogue(),
	cut_wait(50),
	cut_perform_function(1,function()
	{
	  with get_char_by_party_position(0)
		if hp < max_hp
		{
			with obj_flowey_firstcutscene_controler
				cutscene_force_end(main_cutscene)
			exit;
		}
		
		audio_sound_pitch(obj_globalmusicplayer.playing_audio,0.95)
		obj_flowey_firstcutscene_controler.sprite_index = spr_flowey_sassy
	}),
	cut_wait(20),
	add_text("Hey buddy, {.&}you missed them."),
	add_text("Let's try again, okay?"),
	cut_perform_function(0,function()
	{
		instance_destroy(obj_friendlypellet)

		with obj_flowey_firstcutscene_controler
		{
			sprite_index = spr_flowey_dialogue
			repeat 5
			{
			    with instance_create_depth(x, y, depth, obj_friendlypellet)
				{
					alarm[0] = -1
					speed = 2
					direction = (instance_number(obj_friendlypellet)) * 30
					x = other.x + 21 + lengthdir_x(70, direction)
					y = other.y + 23 + lengthdir_y(70, direction)
					direction = point_direction(x,y,obj_soul.x,obj_soul.y)
				}
			}
		}
	}),
	cut_wait(100),
	cut_perform_function(30,function()
	{
		with get_char_by_party_position(0)
		if hp < max_hp
		{
			cutscene_force_end(obj_flowey_firstcutscene_controler.main_cutscene)
			exit;
		}
		audio_sound_pitch(obj_globalmusicplayer.playing_audio,0.9)
		obj_flowey_firstcutscene_controler.sprite_index = spr_flowey_pissed
	}),
	cut_perform_function(-1,function()
	{
		with obj_flowey_firstcutscene_controler
		{
			var _var_struct = variable_clone(var_struct)	
			with _var_struct
			{
				max_sentence_width += 50
				triggered = false
				event_destroy = -1
				can_destroy = false
				can_skip = false
				event_pagewritten = function()
				{
					if triggered exit;
					triggered = true 
					cutscene_next_event(obj_flowey_firstcutscene_controler.main_cutscene)
				}
			}
			create_my_dialogue("Is this a joke?{.&}Are you braindead?{.&}RUN.{.} INTO.{.} THE.{&.}BULLETS!!!",_var_struct)
		}
	}), 
	cut_set_var(obj_flowey_firstcutscene_controler,"sprite_index",spr_flowey_face_shock),
	cut_wait(20),
	cut_perform_function(0,function()
	{
		instance_destroy(obj_friendlypellet)
		
		with obj_flowey_firstcutscene_controler
		{
			repeat 5
			{
				with instance_create_depth(x, y, depth, obj_friendlypellet)
				{
					alarm[0] = -1
					x = other.x + 21 + lengthdir_x(70, direction)
					y = other.y + 23 + lengthdir_y(70, direction)
					direction = point_direction(x,y,obj_soul.x,obj_soul.y)
					speed = 2
				}
			}
			
			sprite_index = spr_flowey_dialogue
			image_index = 1
			with my_dialogue
			{
				var dial = string_remove_markups("Is this a joke?{.&}Are you braindead?{.&}RUN.{.} INTO.{.} THE.{&.}friendliness pellets")
				dialogue = [dial]
				letter_drawn_current = string_length(dialogue[0])
			}
		}
	}),
	cut_wait(60),
	destroy_dialogue(),
	cut_wait(60),
	cut_perform_function(0,function()
	{
		with get_char_by_party_position(0)
		if hp < max_hp
		{
			cutscene_force_end(obj_flowey_firstcutscene_controler.main_cutscene)
			exit;
		}
		obj_flowey_firstcutscene_controler.pitchlower = 1
	}),
	cut_wait(50),
	cut_set_var(obj_flowey_firstcutscene_controler,"sprite_index",spr_flowey_evil,8),
	cut_perform_function(0,set_evil_voice),
	add_text("You know what's going on here, don't you?"),
	add_text("You just wanted to see me suffer."),
	cut_perform_function(0,function()
	{
		with obj_flowey_firstcutscene_controler event_bulletcircle()	
	}),
)	
main_cutscene = cutscene_start(cutscene)
pitchlower = -1
sprite_talk = true 

event_bulletcircle = function()
{
	with obj_flowey_firstcutscene_controler
	{		
		var cut = cutscene_create
		(
			cut_perform_function(0,function()
			{
				with obj_battlebox
				{
					var w = 53 
					var h = 47
					lerp_var_ext(id,"width",0.1,width,w)
					lerp_var_ext(id,"height",0.1,height,h)
					x = 160 
					y = 310	
					var border = 6
					obj_soul.x = clamp(obj_soul.x,border + x - w / 2, (x + w / 2) - border)
					obj_soul.y = clamp(obj_soul.y,border + y - h / 2, (y + h / 2) - border)
				}
				var create_bullet = function()
				{
					var total_count = 72
					var in = instance_number(obj_fakefriendlypellet)
					if (in < total_count) 
					{
						play_sound(snd_chug,2,,,0.9)
					    var am = 53
					    var d = 270 + (in * (360 / total_count))
	
					    instance_create_depth(
					        obj_battlebox.x + lengthdir_x(am, d) + 1, 
					        obj_battlebox.y + lengthdir_y(am, d) + -11, 
					        obj_flowey_firstcutscene_controler.depth - 10, 
					        obj_fakefriendlypellet
					    )
					    do_later(1,asset_get_index(_GMFUNCTION_))
					}
				}
				create_bullet()
			}),
			cut_wait(80),
			cut_perform_function(-1,function()
			{
				with obj_flowey_firstcutscene_controler
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
		
		var char = get_char_by_party_position(0)
		if char.hp < char.max_hp 
		{
			set_evil_voice()
			sprite_index = spr_flowey_grin
			cut = array_concat(
			[
				cut_wait(1),
				cut_wait(40),
				add_text("You idiot."),
				add_text("In this world, it's kill or BE killed."),
				add_text("Why would ANYONE pass up an opportunity like this!?"),
				cut_set_var(obj_flowey_firstcutscene_controler,"sprite_index",spr_flowey_evil),
			], 
			cut)
		}
		cutscene_start(cut)
	}
}

event_hit_bullet = function()
{
	if instance_exists(my_dialogue)
	instance_destroy(my_dialogue)
	get_char_by_party_position(0).hp = 1
	instance_destroy(obj_friendlypellet)
	shake_camera(20,5)
	globalmusic_stop(true)
	play_sound(snd_hurt,2,,,0.95)
	event_bulletcircle()
}

final_event_triggered = false 

final_event = function()
{
	if final_event_triggered exit; 
	final_event_triggered = true
	
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
			
			with obj_flowey_firstcutscene_controler
			{
				hspeed = -10
				vspeed = -0.5
				sprite_index = spr_flowey_hurt
			}
			globalmusic_stop()
		}),
		cut_wait(40),
		cut_perform_function(0,
		function()
		{
			with obj_flowey_firstcutscene_controler
			{
				create_my_dialogue = function(text,_var_struct = var_struct)
				{
					image_index = 1
					my_dialogue = create_speechbubble(text,x + 62.5 + -14,y + 5.5 + -52,x - 20,y - 30,140,_var_struct,false,99,45)
				}
				sprite_talk = true
				with var_struct
				{
					talker = global.talker.toriel
					texteffect_shake = false
					write_speed = 1
				}
				hspeed = 0
				vspeed = 0
				image_angle = 0
				sprite_index = spr_toriel_full_0
				x = cam_x + 380
				y = cam_y + 100 + 19 + -41
			}
		}),
		cut_interpolate_var(obj_flowey_firstcutscene_controler,"x",0.025,cam_x + 380,obj_battlebox.x + -3,0),
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
		cut_perform_function(0,function() // end 
		{
			global.flags.ruins.flowey_cutscene_0 = true
			destroy_instances(
			[
				obj_guidearrows,
				obj_flowey_firstcutscene_controler,
				obj_battle_background_dark,
				obj_battlebox,
				obj_soul,
			])
				instance_activate_object(parent_char)
				instance_destroy(obj_npc_base)
				with instance_create_depth(162,271,0,obj_npc_base)
				{
					sprite_name = "spr_toriel_talk_{dir}"
					with dialogue_var_struct
					{
						talker = global.talker.toriel
						creator = other.id
						event_destroy = function()
						{
							with creator 
							{
								lerp_var_ext(id,"dir",0.1,DOWN,UP)	
								dialogue_talk = false 
								sprite_name = "spr_toriel_walk_{dir}"
								lerp_var_ext(id,"y",0.01,y,-20)
								do_later(36,lerp_var_ext,[id,"image_alpha",0.2,1,0])
							}
						}
					}
					do_later(1,function(){
						my_dialogue = create_textbox("* This way.",dialogue_var_struct)
					},,id)
				}
			
			lerp_var_ext(obj_camera,"screen_darken",0.1,1,0)	
		})
	)
	cutscene_start(cut)
}