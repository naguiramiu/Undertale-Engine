var vec, name,
changed = char_name + string(get_current_direction(front_vector)) // this is a string but its just to update
// this is in the parent char code

if prev_changed != changed // asset get index is an expensive funciton so dont do it every frame, this fixes it
{
	update_sprite()
	prev_changed = changed 
}

if sprite_exists(sprite)
	draw_sprite(sprite,current_frame,x,y)