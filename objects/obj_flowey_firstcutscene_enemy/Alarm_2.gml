var total_count = 72
var in = instance_number(obj_fakefriendlypellet)
if (in < total_count) 
{
	play_sound(snd_chug,2,,,0.9)
    var am = 53
    var d = 270 + (in * (360 / total_count))
	
    instance_create_depth(
        obj_battlebox.x + lengthdir_x(am, d) + 1, 
        obj_battlebox.y + lengthdir_y(am, d) + -11, 
        obj_flowey_firstcutscene_enemy.depth - 10, 
        obj_fakefriendlypellet
    )
    alarm[2] = 1
}
