
/// @description Create dialogue bubbles
function battle_end_actions()
{
	with obj_battlecontroler
	{
		instance_destroy(flavor_text_instance)
		battle_started = true
		var won = true  
		with parent_monster_enemy
			{
				if can_be_selected 
					won = false 
				if variable_instance_exists(id,"event_battlebox_appear")
					event_battlebox_appear()
			}
		
		if won
		{
			battle_win()
			exit;
		}

		battle_create_speechubbles()

		with obj_battlebox
		{
			lerp_var_ext(id,"width" ,0.075,width,global.battlebox_width )
			lerp_var_ext(id,"height",0.075,height,global.battlebox_height)
		}

		var speechbubble_exits = false 
		if instance_exists(obj_textbox) 
			with obj_textbox 
				if is_speechbubble 
					speechbubble_exits = true 

		with instance_create_depth(obj_battlebox.x,obj_battlebox.y,obj_battlebox.depth - 20,obj_soul)
		{
			lerp_var_ext(id,"x",0.1,x,cam_x + global.battlebox_x)
			lerp_var_ext(id,"y",0.1,y,cam_y + global.battlebox_y)
		}

		if !speechbubble_exits battle_turn_start() // turn start
	}
}
