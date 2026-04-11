if interact_key_press && can_open_textbox()
{
	if player_is_facing_point(x + sprite_width / 2, y + sprite_height / 2)
		instance_create(obj_storage_viewer)
}