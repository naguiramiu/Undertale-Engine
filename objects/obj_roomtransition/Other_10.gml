/// @description Room start
if !works || !instance_exists(player) exit

var instances = room_get_info(target_room,false,true,false,false,false,false).instances
var instance_found = noone 
for (var i = 0; i < array_length(instances); i++)
if instances[i].id == mywarp 
{
	mywarp = instances[i]	
	break;
}
var tp_y = 0
var tp_x = 0

if mywarp != noone
{
	if horizontal_dir != -1
	{	
		tp_y = round(mywarp.y + (20 * abs(mywarp.yscale) * percentage))
		var imgxscale = (20 * mywarp.xscale)
		var xoff = (!horizontal_dir ? imgxscale + 10 : -15)
		tp_x = round(mywarp.x + xoff)
	}
	else if vertical_dir != -1
	{
		tp_x = round(mywarp.x + (20 * abs(mywarp.xscale) * percentage))
		var imgyscale = (20 * mywarp.yscale)
		var yoff = (!vertical_dir ? imgyscale + 15 : -15)
		tp_y = round(mywarp.y + yoff)
	}
}
else 
{
	with room_get_custom_info(target_room)
	{
		tp_x = x 
		tp_y = y
	}
}
scr_teleport_player(tp_x,tp_y,insta_tp_party)