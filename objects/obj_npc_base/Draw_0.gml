if can_change_direction && instance_exists(player)
{
	dir = point_direction(x,y,player.x,player.y)
	dir = array_find_closest(dir,allowed_dirs)
}


if path_index != -1 
{
	if (x != xprevious || y != yprevious) 
	{
		var _travel_dir = point_direction(xprevious, yprevious, x, y);
		dir = array_find_closest(_travel_dir, allowed_dirs);
	}	
}
var spritename = sprite_prefix + front_direction_to_string(dir) + sprite_suffix

if prev_spritename != spritename
{
	var try_sprite = asset_get_index(spritename)
	if sprite_exists(try_sprite)
	sprite = try_sprite
}
prev_spritename = spritename

var interact = interact_key_press
if interact && global.can_move && can_open_textbox()
{
	if player_is_facing_point(x,y + base_y_off,,40)
	{
		interact = false
		if var_id_exists("dialogue")
			create_textbox(dialogue,dialogue_var_struct)

	}
}
img = ((img + (sprite_get_speed(sprite) / 30) * image_speed))

draw_sprite_ext_optional(sprite,img)