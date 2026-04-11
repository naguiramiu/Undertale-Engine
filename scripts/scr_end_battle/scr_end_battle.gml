///@desc end battle

function battle_end()
{
	destroy_instances
	(
		[
			obj_battlecontroler,
			obj_battle_background_parent,
			obj_battlebox,
			obj_soul,
			parent_monster_enemy,
			parent_bullet,
			obj_textbox,
			obj_spare_monster,
		]
	)
	lerp_var_ext(obj_camera,"screen_darken",0.1,1,0)
	global.can_move = true 
	instance_activate_object(parent_char)
	globalmusic_stop()
	var restart_instances = 
	[
		obj_parent_area,
		obj_play_music,
		obj_set_border,
		obj_remove_border
	]
	for (var i = 0; i < array_length(restart_instances); i++)
	if instance_exists(restart_instances[i])
	with restart_instances[i] event_perform(ev_create,0)
	
	array_foreach(["monsters","battlebox_height","battlebox_width","flavor_text"],function(val){variable_struct_remove(global,val)})
}