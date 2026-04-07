
/// @description Create dialogue bubbles
function battle_battlebox_appear()
{
	with obj_battlecontroler
	{
		instance_destroy(flavor_text)
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

		battle_create_speechubble()

		with obj_battlebox
		{
			lerp_var_ext(id,"width" ,0.1,[id,"width" ],global.battlebox_width )
			lerp_var_ext(id,"height",0.1,[id,"height"],global.battlebox_height)
		}

		var speechbubble_exits = false 
		if instance_exists(obj_textbox) 
			with obj_textbox 
				if is_speechbubble 
					speechbubble_exits = true 

		with instance_create_depth(obj_battlebox.x,obj_battlebox.y,obj_battlebox.depth - 20,obj_soul)
		{
			lerp_var_ext(id,"x",0.1,[id,"x"],cam_x + global.battlebox_x)
			lerp_var_ext(id,"y",0.1,[id,"y"],cam_y + global.battlebox_y)
		}

		if !speechbubble_exits battle_turn_start() // turn start
	}
}

function battle_create_speechubble()
{
	with parent_monster_enemy 
	{
		if can_be_selected
		{
			var xof = (x - cam_x) + speechbubble_x + -66 
			var yof = (y - cam_y) + speechbubble_y + -182 + -50
			var p_x = x + speechbubble_point_x
			var p_y = y + speechbubble_point_y
				
			if variable_instance_exists(id,"event_dialogue")
				script_execute_ext(event_dialogue,customevent_get_params("dialogue"))
					
			// that event can do stuff like create 2 dialogue bubbles for like an enemy 
			// with two heads
			// but it expects itself to create a speechbubble 
					
										
			else if variable_instance_exists(id,"next_dialogue") && array_length(next_dialogue)
			{
				create_speechbubble(next_dialogue[0],xof,yof,p_x,p_y) 
				array_delete(next_dialogue,0,1)
			}
			// that creates a speechbubble from an array of dialogue and removes it from the array 
				
					
			else if variable_instance_exists(id,"potential_dialogue")
			{
				repeat (pos + 1)
				var dial = potential_dialogue[irandom(array_length(potential_dialogue) - 1)]
				create_speechbubble(dial,xof,yof,p_x,p_y) 
			}
			// that picks dialogue from an array of potential dialogue but its offset by the monsters position
				
			else if dialogue != "" create_speechbubble(dialogue,xof,yof,p_x,p_y) 
			// at the end, it just created a dialogue from the dialogue string
				
				
			if instance_exists(my_speechbubble)
			{
				if var_id_exists("event_speechbubble_destroy")
				{
					my_speechbubble.event_destroy = event_speechbubble_destroy
					my_speechbubble.event_destroy_params = [id]	
				}
			}
		}
	}
}