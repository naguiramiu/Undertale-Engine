var bx = cam_x + global.battlebox_x - global.battlebox_width / 2
var by = cam_y + 5 + global.battlebox_y - global.battlebox_height / 2
var bx2 = bx + global.battlebox_width
var by2 = by + global.battlebox_height
var changed = false 
destroy_outside_room  = false
if (active)
{
    if (x < (bx + 11.5))
    {
        side = 1;
        x = (bx + 11.5);
        image_angle = -90;
		cant()
    }
    
    if (y < (by + 6.5))
    {
        side = 2;
        y = by + 6.5;
        image_angle = 180;
		cant()
    }
    
    if (x > (bx2 + -10.5))
    {
        side = 3;
        x = bx2 + -10.5;
        image_angle = 90;
		cant()
    }
    
    if (y > (by2 - 15.5))
    {
        side = 0;
        y = by2 - 15.5
        image_angle = 0;
		cant()
    }
}


