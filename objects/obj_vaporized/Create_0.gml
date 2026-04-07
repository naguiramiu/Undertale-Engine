p_pix = part_type_create()

//PARTICLE PARAMETERS, YOU CAN ADD TO THIS IF YOU WANT
// create a 1x1 white pixel sprite, origin top left
part_type_sprite(p_pix, spr_1x1whitepixel, false, false, false)
part_type_life(p_pix, 20, 40)
part_type_alpha2(p_pix, 1, 0)
part_type_speed(p_pix, 0.2, 2, 0, 0)
part_type_direction(p_pix, 80, 100, 0, 0)
part_type_gravity(p_pix, 0.1, 90)
//
depth = target.depth - 1
lay = layer_create(depth,"vapor_" + string_replace_all(string(target.id)," ","_"))
p_sys = part_system_create_layer(lay,false)
surf = -1
current_row = 0
mysprite = -1
width = camera_get_view_width(view_camera[view_current])
height = camera_get_view_height(view_camera[view_current])
buffer = buffer_create(width * height * 4, buffer_fixed, 1)
