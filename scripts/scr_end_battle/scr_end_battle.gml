///@desc end battle

function battle_end()
{
	destroy_instances
	(
		[
			obj_battlecontroler,
			obj_battle_background,
			obj_battlebox,
			obj_soul,
			parent_monster_enemy,
			parent_bullet,
			obj_textbox,
			obj_spare_monster,
			obj_battle_hp_ui
		]
	)
	lerp_var_ext(obj_camera,"screen_darken",0.1,1,0)
	global.can_move = true 
	instance_activate_object(parent_char)
	globalmusic_stop()
	if instance_exists(obj_play_music)
	with obj_play_music event_perform(ev_create,0)
}