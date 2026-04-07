depth = -y
works = true
dir = -1

var dist = 8
with instance_create_depth(x, y + dist / 2, depth, obj_collision_wall_rectangle)
{
    image_yscale = (20 * other.image_yscale - (dist * image_yscale)) / 20
    image_xscale = other.image_xscale
}