if instance_exists(player) && (global.can_move && warp_id != noone && target_room != undefined)
{
	if place_meeting(x,y,player)
	{
		var tempdir = !(player.x < (x + sprite_width / 2))
		if reverse tempdir = !tempdir
		var p = (player.y - y) / (sprite_get_height(sprite_index) * abs(image_yscale)) // percent of the players x in comparison to the sprite
		
		var clamp_distance = 0.2 - (image_yscale - 1) * 0.1
		clamp_distance = clamp(clamp_distance,0,0.2)
		
		p = clamp(p,clamp_distance,1 - clamp_distance) // clamp it to avoid getting stuck
		
		if !instance_exists(obj_roomtransition)
		instance_create_depth(x,y,depth,obj_roomtransition,
		{
			insta_tp_party: tp_party_into_player,
			mywarp: warp_id,
			target_room: target_room,
			horizontal_dir: tempdir,
			percentage: p,
			custom_effect: custom_effect,
			force_dir: dir,
		})
	}	
}

 


