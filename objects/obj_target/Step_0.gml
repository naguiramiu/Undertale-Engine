if fade
{
    image_alpha -= 0.08;
    image_xscale -= 0.06;
}
if (image_xscale < 0.08)
    instance_destroy()