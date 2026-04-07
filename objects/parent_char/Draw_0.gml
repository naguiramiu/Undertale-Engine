var vec, name

var changed = char_name + string(get_current_direction(front_vector))

if prev_changed != changed 
{
	update_sprite()
	prev_changed = changed 
}


if sprite_exists(sprite)
	draw_sprite(sprite,current_frame,x,y)