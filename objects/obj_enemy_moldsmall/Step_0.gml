if self_enemy_can_attack()
{
	if bullet > 0 bullet -- 
	else
	{
		instance_create_depth(cam_x + global.battlebox_x + random_range(-global.battlebox_width / 3, global.battlebox_width / 3),cam_y +  global.battlebox_y - global.battlebox_height / 2,obj_battlebox.depth - 10,obj_moldsmall_bullet)	
		bullet = 20
	}
	
	
}