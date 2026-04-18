depth = -y - sprite_height
if (open) 
	flame = instance_create_depth(x + 2, y + 48, depth, obj_empty,{sprite_index: spr_doorflame})
collision = create_collision(x,y + 29,1.8,1)

places = scr_warpdoor_get(warp_id)

func = function(rm)
{
	if (rm == room)
		create_textbox("* (Amazingly, you are already there.)")
	else
	{
		play_sound(snd_dooropen)
		image_index = 1
		create_textbox("* (The door opened...)",
		{
			let_player_move_end: false,
			event_destroy: function(rm)
			{
				cutscene_perform_event = false
				var inst = instance_create_depth(0,0,UI_DEPTH + 1,obj_darken,{image_alpha: 0, persistent: true})
				
				cutscene_start(cutscene_create
				(
					cut_set_var(inst,"image_alpha",1),
					cut_perform_function(1,room_goto,rm),
					cut_perform_function(0,function()
					{
						player.front_vector = DOWN 
						if instance_exists(obj_warpdoor)
							with obj_warpdoor
								scr_teleport_player(x + sprite_width / 2,y + sprite_height + 10,true)
						else
							with room_get_custom_info(room)
								scr_teleport_player(x,y,true)
					},rm),
					cut_playsound(snd_doorclose),
					cut_wait(40),
					cut_playsound(snd_dooropen),
					cut_interpolate_var(inst,"image_alpha",0.1,1,0,0),
					cut_perform_function(0,variable_global_set,["can_move",true]),
					cut_perform_function(0,instance_destroy,inst)
				),,true)
			},
			event_destroy_parameters: rm
		})
	}
}