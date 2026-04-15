if (image_index == 0)
{
	if !instance_exists(collision)
	collision = create_collision(x,y)
}
else
{
	if instance_exists(collision)
	instance_destroy(collision)
}