var _s_ext = 1 + sin(current_time * 0.005) * 0.1; 
var _y_offset = (sprite_height * (_s_ext - 1)) / 2;
draw_sprite_ext(sprite_index, image_index, x, y - _y_offset, image_xscale, image_yscale * _s_ext, image_angle, image_blend, image_alpha);
