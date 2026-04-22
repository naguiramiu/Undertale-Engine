if self_enemy_can_attack() && monster_sum() != 3
{
	for (var i = 0; i < 2; i++)
	if bullet[i] > 0 bullet[i] --
	else if !irandom(4)
	{
		with instance_create_depth((cam_x + global.battlebox_x - global.battlebox_width / 2) + (global.battlebox_width / 4) * (i == 0 ? 1 : 3),cam_y + global.battlebox_y + (global.battlebox_height / 2) - 10 - random(4),obj_battlebox.depth - 1,parent_bullet,
		{
			draw_in_battlebox: true,
			sprite_index: spr_butterflybullet_0,
			vspeed: -1,
			image_angle: 90,
			image_xscale: 0.5, image_yscale: 0.5,
			life: 3,
			tp_give: 1
		}) 
		bullet[i] = irandom(12) + 15
	}
}