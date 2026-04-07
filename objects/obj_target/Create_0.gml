
do_later(6,function()
{
	var dir = choose(-1,1)
	instance_create_depth(x + (sprite_width / 2) * dir, y,depth - 1, obj_targetbar);
}
)

fade = false
damage = 0
attackspeed = 3 + random(3)