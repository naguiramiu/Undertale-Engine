if instance_exists(player) && (global.can_move && target_room != undefined)
{
	if place_meeting(x,y,player)
	{
		var tempdir = (player.y > y + sprite_height / 2) // get if the player is above or below
		if reverse tempdir = !tempdir
		var p = (player.x - x) / (sprite_get_width(sprite_index) * abs(image_xscale)) // percent of the players x in comparison to the sprite
		
		var clamp_distance = 0.2 - (image_xscale - 1) * 0.1
		clamp_distance = clamp(clamp_distance,0,0.2)
		
		p = clamp(p,clamp_distance,1 - clamp_distance) // clamp it to avoid getting stuck
		
		if !instance_exists(obj_parent_roomtransition)
		instance_create_depth(x,y,depth,obj_roomtransition,
		{
			insta_tp_party: tp_party_into_player,
			mywarp: warp_id,
			target_room: target_room,
			vertical_dir: tempdir,
			percentage: p,
			custom_effect: custom_effect,
			force_dir: dir,
			//force_fol: force_follower
		})
	}	
}

 


