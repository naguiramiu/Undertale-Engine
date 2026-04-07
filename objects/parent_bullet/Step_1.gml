if destroy_outside_room
{
	var padding = 50
	if !point_in_rectangle(x,y,cam_x - padding, cam_y - padding, cam_x + 320 + padding, cam_y + 240 + padding)
	instance_destroy()
}

if fade_and_destroy_after_attack && inactive 
{ 
	if image_alpha > 0
	image_alpha -= 0.1 
	else instance_destroy()
}

if (life != -1)  if (life > 0) life -= (1 / 30) else instance_destroy()
