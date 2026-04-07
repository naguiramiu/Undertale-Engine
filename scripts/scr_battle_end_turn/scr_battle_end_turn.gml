/// @description End turn

function battle_end_turn()
{
	if instance_exists(parent_bullet)
	parent_bullet.inactive = true
	battle_started = false
	instance_destroy(obj_soul)
	with parent_monster_enemy if variable_instance_exists(id,"event_turn_end") event_turn_end()
	
	with obj_battlebox // reset battlebox
	{
		lerp_var_ext(id,"width",0.1,[id,"width"],287.5)
		lerp_var_ext(id,"height",0.1,[id,"height"],70)
		lerp_var_ext(id,"x",0.1,[id,"x"],cam_x + global.battlebox_x)
		lerp_var_ext(id,"y",0.1,[id,"y"],cam_y + global.battlebox_y)
		lerp_var_ext(id,"image_angle",0.25,[id,"image_angle"],0)
	}
	event_perform(ev_create,0)
}