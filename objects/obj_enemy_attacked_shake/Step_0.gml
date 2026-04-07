shake_range -= shake_speed_stop

var shake = (shake_range * dir)
enemy.x = xstart + shake 
		
if shake_range <= 0
{
	enemy.x = xstart
	enemy.y = ystart
	enemy.hurt = false
	instance_destroy()
}