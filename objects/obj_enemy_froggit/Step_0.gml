if self_enemy_can_attack()
{
	if bullet > 0 bullet --
	else 
	{
		bullet = turn_get_length() / 2
		var cy = 0
		var cx = 0
		var bx = global.battlebox_x - global.battlebox_width / 2
		var by = global.battlebox_y - global.battlebox_height / 2
		var bx2 = bx + global.battlebox_width
		var by2 = by + global.battlebox_height
		var no = irandom(2) + 1
		switch no 
		{
			case 2: 
			cx = global.battlebox_x
	        cy =  by + 10
			break;
			case 1: 
			cx = bx + 10 
	        cy = global.battlebox_y
			break;
			case 3:
			cx = bx2 - 10
	        cy = global.battlebox_y
			break;
			
		}
		with instance_create_depth(cam_x + cx,cam_y + cy, obj_battlebox.depth - 2,obj_frogbullet)
		{
			side = no;
			image_angle = no * -90;
			event_perform(ev_alarm,0) 
		}
	}
}