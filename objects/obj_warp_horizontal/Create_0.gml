depth = -y
works = true
dir = -1

var dist = 8
with instance_create_depth(x + dist / 2, y, depth, obj_collision_wall_rectangle)
{
    image_yscale = other.image_yscale
    image_xscale = (20 * other.image_xscale - (dist * image_xscale)) / 20
}