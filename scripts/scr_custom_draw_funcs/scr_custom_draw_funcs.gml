function draw_text_color_ext(x,y,text,color = c_white,xscale = 1,yscale = 1,angle = 0)
{
	var col = draw_get_colour()
	draw_set_colour(color)
	draw_text_transformed(x,y,text,xscale,yscale,angle)
	draw_set_colour(col)
}

function draw_sprite_outline_ext(sprite = sprite_index,subimg = image_index,_x = x,_y = y,outline_color = c_white, outline_alpha = 1, xscale = image_xscale,yscale = image_yscale,rot = image_angle,colour = image_blend,alpha = image_alpha)
{
	var tex = sprite_get_texture(sprite, subimg)
	shader_set(sh_outline)
    shader_set_uniform_f(shader_get_uniform(sh_outline, "u_texel_size"), texture_get_texel_width(tex), texture_get_texel_height(tex))
    shader_set_uniform_f_array(shader_get_uniform(sh_outline, "u_outline_color"), [color_get_red(outline_color) / 255,color_get_green(outline_color) / 255,color_get_blue(outline_color) / 255,outline_alpha])
    draw_sprite_ext(sprite,subimg,_x,_y,xscale,yscale,rot,colour,alpha)
	shader_reset()
}

function draw_text_shadow(x,y,text,color = c_white)
{
	var col = draw_get_color()
	draw_set_color(c_black)
	draw_text(x + 1, y + 1, text)
	draw_set_color(color)
	draw_text(x,y,text)
	draw_set_color(col)
}
function draw_text_shadow_ext(x,y,text,color = c_white,scale = 1, angle = 0)
{
	var col = draw_get_color()
	draw_set_color(c_black)
	draw_text_transformed(x + scale, y + scale, text,scale,scale,angle)
	draw_set_color(color)
	draw_text_transformed(x,y,text,scale,scale,angle)
	draw_set_color(col)
}

function draw_text_hyphen(x,y,text,col)
{	
	var current_x = 0
	for (var i = 1; i <= string_length(text); i++)
	{
		var char = string_char_at(text,i)
		if char == "_"
		{
			var prev = draw_get_colour()
			draw_set_colour(c_black)
			draw_line_width(x + current_x,y + 9,-3 + x + 2 + current_x + string_width("A"),y + 9,1.5)	
			draw_set_colour(col)
			draw_line_width(x + current_x - 1,y + 8,-3 + x + 2 + current_x + string_width("A") - 1,y + 8,1.5)	
			draw_set_colour(prev)
			current_x += 2
		}
		else
		draw_text_shadow(x + current_x,y + (char == "_" ? myy : 0),char,col)
		current_x += string_width(char)
	}
}

function draw_text_outline_color(_x, _y, _text, _scale = 1, _thickness = 1, _outline_col = c_black, _text_col = c_white)
{
    var _old_col = draw_get_color();
    draw_set_color(_outline_col);
    
    for (var i = -_thickness; i <= _thickness; i++) 
    {
        for (var j = -_thickness; j <= _thickness; j++) 
        {
            if (i == 0 && j == 0) continue;
            
            if (i != 0 && j != 0) continue;
            
            draw_text_transformed(_x + i * _scale, _y + j * _scale, _text, _scale, _scale, 0);
        }
    }
    
    draw_set_color(_text_col);
    draw_text_transformed(_x, _y, _text, _scale, _scale, 0);
    
    draw_set_color(_old_col);
}


function draw_text_linesep(_x,_y,text,sep,size = 1)
 {
	 for (var tt = 0; tt < array_length(text); tt++)
		 draw_text_transformed(_x,_y + (sep * tt),text[tt],size,size,0)
 }
 
function draw_text_transformed_shadow(x,y,text,xscale = 2,yscale = 2,angle = 0,shadow_color = c_black)
{
	var col = draw_get_color()
	draw_set_colour(shadow_color)
	draw_text_transformed(x + xscale, y + yscale, text,xscale,yscale,angle)
	draw_set_colour(col)
	draw_text_transformed(x, y, text,xscale,yscale,angle)
}

function draw_text_shake(x,y,text,strength = 0.5,size = 1,color = draw_get_colour())
{
	var prev = draw_get_colour()
	draw_set_colour(color)
	var cx = x
	for (var i = 1; i <= string_length(text); i++)
	{
		var char = string_char_at(text,i)
		draw_text_transformed(cx + random_range(-strength,strength),y + random_range(-strength,strength),char,size,size,0)
		cx += string_width(char) * size
	}	
	draw_set_colour(prev)
}

function draw_text_jitter(_x,_y,text,jitter = 0.5)
{
	var text_x = _x
	for (var i = 1; i < string_length(text) + 1; i++)
	{
		var ran = !irandom(100)
		var char = string_char_at(text,i)
		var xoffset = ran ? random_range(-jitter,jitter) : 0
		var yoffset = ran ? random_range(-jitter,jitter) : 0
		draw_text(text_x + xoffset,_y + yoffset,char)
		text_x += string_width(char) + 1 + (char == " ") * 4
	}
}

function draw_sprite_ext_optional(sprite = sprite_index,subimg = image_index,_x = x,_y = y,xscale = image_xscale,yscale = image_yscale,rot = image_angle,colour = image_blend,alpha = image_alpha)
{
	draw_sprite_ext(sprite,subimg,_x,_y,xscale,yscale,rot,colour,alpha)
}
function scr_draw_sprite_centered(sprite = sprite_index,subimg = image_index,_x = x,_y = y,xscale = image_xscale,yscale = image_yscale,rot = image_angle,colour = image_blend,alpha = image_alpha)
{
	var orx = sprite_get_xoffset(sprite)
	var ory = sprite_get_yoffset(sprite)
	var spr_width = sprite_get_width(sprite)
	var spr_height = sprite_get_height(sprite)
	sprite_set_offset(sprite,spr_width / 2,spr_height / 2)
	draw_sprite_ext(sprite,subimg,_x,_y,xscale,yscale,rot,colour,alpha)
	sprite_set_offset(sprite,orx,ory)
}

function draw_rectangle_border_width(x1, y1, x2, y2, width) 
{
   var xx = [x1, x2, x2, x1, x1]
   var yy = [y1, y1, y2, y2, y1]
   draw_primitive_begin(pr_trianglestrip)
    for (var i = 0; i < 5; i++) 
	{
        draw_vertex(xx[i], yy[i]);
        draw_vertex((xx[i] == x1) ? xx[i] + width : xx[i] - width, (yy[i] == y1) ? yy[i] + width : yy[i] - width);
    }
    draw_primitive_end()
}

function draw_rectangle_center_rotated(_x, _y, _width, _height, _angle, _outline = false, _border_size = 0) 
{
    var _hw = _width / 2
    var _hh = _height / 2
    var _qx = [-_hw,  _hw,  _hw, -_hw, -_hw]
    var _qy = [-_hh, -_hh,  _hh,  _hh, -_hh]
    
    draw_primitive_begin(pr_trianglestrip)
    
    for (var i = 0; i < 5; i++) 
    {
        var _dist_o = point_distance(0, 0, _qx[i], _qy[i])
        var _dir_o  = point_direction(0, 0, _qx[i], _qy[i]) + _angle
        
        draw_vertex(_x + lengthdir_x(_dist_o, _dir_o), _y + lengthdir_y(_dist_o, _dir_o))
        var _ix, _iy
        if (_outline) 
		{
            _ix = (_qx[i] < 0) ? _qx[i] + _border_size : _qx[i] - _border_size
            _iy = (_qy[i] < 0) ? _qy[i] + _border_size : _qy[i] - _border_size
        } else 
		{
            _ix = 0
            _iy = 0
        }
        
        var _dist_i = point_distance(0, 0, _ix, _iy)
        var _dir_i  = point_direction(0, 0, _ix, _iy) + _angle
        
        draw_vertex(_x + lengthdir_x(_dist_i, _dir_i), _y + lengthdir_y(_dist_i, _dir_i))
    }
    
    draw_primitive_end()
}


function draw_circle_alpha_gradient(_x, _y, _r, _col, _alpha_inner, _alpha_outer) 
{
    var _steps = draw_get_circle_precision();
    var _angle_step = 360 / _steps;
	_x ++ 
	_y ++
    draw_primitive_begin(pr_trianglefan);
    draw_vertex_color(_x, _y, _col, _alpha_inner);
    for (var i = 0; i <= _steps; i++) 
	{
        var _angle = i * _angle_step;
        var _vx = _x + lengthdir_x(_r, _angle);
        var _vy = _y + lengthdir_y(_r, _angle);
        draw_vertex_color(_vx, _vy, _col, _alpha_outer);
    }
    draw_primitive_end();
}


function draw_rectangle_wh(x,y,w,h,o = 0)
{
	draw_rectangle(x,y,x+w,y+h,o)		
}
function start_mask()
{
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(false,false,false,true)
	draw_set_alpha(0)
	draw_set_colour(c_white)
	draw_rectangle(0,0,display_get_width(),display_get_height(),0)
	draw_set_alpha(1)
}
function end_mask()
{
	gpu_set_blendenable(true)
	gpu_set_colorwriteenable(true,true,true,true)
}
function draw_masked_start(reverse = false)
{
	if !reverse
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha)
	else
	gpu_set_blendmode_ext(bm_inv_dest_alpha,bm_dest_alpha)
	gpu_set_alphatestenable(true)
}
function draw_masked_end()
{
	gpu_set_alphatestenable(false)
	gpu_set_blendmode(bm_normal)
}

function draw_menu(x,y,w,h,line_size = 2,color = c_white)
{
	var col = draw_get_color()
	draw_set_color(color)
	draw_rectangle_border_width(x,y,x + w + 1,y + h + 1,line_size)
	draw_set_color(c_black)
	draw_rectangle(x + line_size, y + line_size, x + w - line_size, y + h - line_size,0)
	draw_set_color(col)
}



function draw_menu_linealpha(x,y,w,h,line_size = 2,color = c_white,line_alpha = draw_get_alpha())
{
	var col = draw_get_color()
	draw_set_color(color)
	var prev = draw_get_alpha()
	draw_set_alpha(line_alpha)
	draw_rectangle_border_width(x,y,x + w + 1,y + h + 1,line_size)
	draw_set_alpha(prev)
	draw_set_color(c_black)
	draw_rectangle(x + line_size, y + line_size, x + w - line_size, y + h - line_size,0)
	draw_set_color(col)
}


function draw_menu_ext(x,y,w,h,line_size = 2,color = c_white,alpha = 1)
{
	draw_sprite_stretched_ext(spr_menu_nineslice,0,x,y,w,h,color,alpha)
}

function draw_in_battlebox_start()
{
	with obj_battlebox
	{
		shader_set(sh_battlebox_clip)
		shader_set_u_simple("u_rect_center", [x - 0.1, y])
		shader_set_u_simple("u_rect_size", [width - 5, height - 5])
		shader_set_u_simple("u_rect_angle", degtorad(-image_angle))	
	}
	
}
function draw_in_battlebox_end()
{
	shader_reset()
}

function draw_mainsurface_border()
{
	var gui_w = display_get_gui_width();
	var gui_h = display_get_gui_height();
	var mult = gui_h / surface_get_height(application_surface);
	var final_mult = mult * 0.89;
	var draw_w = surface_get_width(application_surface) * final_mult;
	var draw_h = surface_get_height(application_surface) * final_mult;
	draw_surface_stretched(application_surface, (gui_w - draw_w) / 2, (gui_h - draw_h) / 2, draw_w, draw_h);
}

function draw_rectangle_on_gui_centered(rect_w,rect_h)
{
		var mid_x = 320 / 0.89
		var mid_y = 540 / 2
		draw_rectangle(mid_x - (rect_w), mid_y - (rect_h), mid_x + (rect_w), mid_y + (rect_h), false);
}

function draw_reset_color()
{
	draw_set_colour(c_white)
}

function draw_reset_alpha()
{
	draw_set_alpha(1)
}
function draw_reset_all()
{
	draw_reset_align()
	draw_reset_alpha()
	draw_reset_color()
}
function draw_reset_halign()
{
	draw_set_halign(fa_left)	
}

function draw_reset_valign()
{
	draw_set_valign(fa_top)	
}

function draw_reset_align()
{
	draw_reset_halign()
	draw_reset_valign()
}

function draw_set_halign_center()
{
	draw_set_halign(fa_center)	
}

function draw_set_valign_center()
{
	draw_set_valign(fa_middle)
}

function draw_set_align_center()
{
	draw_set_halign_center()
	draw_set_valign_center()
}

function draw_square_rotated(_x, _y, _size, _angle, _outline = false) 
{
    var _radius = (_size / 2) * 1.4142;
	_x ++
	_y ++
    var _c1x = _x + lengthdir_x(_radius, _angle + 45);
    var _c1y = _y + lengthdir_y(_radius, _angle + 45);
    var _c2x = _x + lengthdir_x(_radius, _angle + 135);
    var _c2y = _y + lengthdir_y(_radius, _angle + 135);
    var _c3x = _x + lengthdir_x(_radius, _angle + 225);
    var _c3y = _y + lengthdir_y(_radius, _angle + 225);
    var _c4x = _x + lengthdir_x(_radius, _angle + 315);
    var _c4y = _y + lengthdir_y(_radius, _angle + 315);
    if (_outline) 
	{
        draw_primitive_begin(pr_linestrip);
        draw_vertex(_c1x, _c1y);
        draw_vertex(_c2x, _c2y);
        draw_vertex(_c3x, _c3y);
        draw_vertex(_c4x, _c4y);
        draw_vertex(_c1x, _c1y);
        draw_primitive_end();
    } else 
	{
        draw_primitive_begin(pr_trianglefan);
        draw_vertex(_c1x, _c1y);
        draw_vertex(_c2x, _c2y);
        draw_vertex(_c3x, _c3y);
        draw_vertex(_c4x, _c4y);
        draw_primitive_end();
    }
}

function screen_cover(color = c_black,alpha = draw_get_alpha())
{
	var al = draw_get_alpha()
	draw_set_alpha(alpha)
	var col = draw_get_color()
	draw_set_color(color)
	if event_number == ev_gui
		draw_rectangle_on_gui_centered(surface_get_width(application_surface) / 0.89,surface_get_height(application_surface) / 0.89)
	else with obj_camera
	draw_rectangle(camera_x_offset,camera_y_offset,room_width * 2,room_height * 2,0)
	draw_set_color(col)
	draw_set_alpha(al)
}
function scr_textbox_draw_speechbubble(drawn_x,drawn_y)
{
	var prev_color = draw_get_colour()
	draw_set_colour(c_white)
	var spacing = 7
	var bubble_x = start_x + drawn_x - spacing
	var bubble_y = current_y + drawn_y - spacing
	var mid_x = bubble_x + max_width / 2
	var mid_y = bubble_y + max_height / 2
	var len = min( point_distance(mid_x,mid_y,point_x,point_y) / 1.75, min(max_width, max_height) * 1.67)
	var dir = point_direction(mid_x, mid_y, point_x, point_y);
	var _point_x = mid_x + lengthdir_x(len, dir);
	var _point_y = mid_y + lengthdir_y(len, dir);
	mid_x = mid_x + lengthdir_x(10, dir);
	mid_y = mid_y + lengthdir_y(10, dir);
	draw_triangle_with_custom_width(_point_x, _point_y ,mid_x , mid_y, len / 2);
	draw_roundrect_ext(bubble_x - 1,bubble_y + 0.5,bubble_x + max_width + 4,bubble_y + ((spacing * 2) + max_height - 8) - 0.5,20,15,0)
	draw_set_colour(prev_color)	
}

function draw_triangle_with_custom_width(tip_x, tip_y, center_x, center_y, base_distance, outline = false) {
   
    var angle = point_direction(center_x, center_y, tip_x, tip_y);
    var base_angle1 = angle + 90; 
    var base_angle2 = angle - 90; 
    var base_x1 = center_x + lengthdir_x(base_distance / 2, base_angle1);
    var base_y1 = center_y + lengthdir_y(base_distance / 2, base_angle1);
    var base_x2 = center_x + lengthdir_x(base_distance / 2, base_angle2);
    var base_y2 = center_y + lengthdir_y(base_distance / 2, base_angle2);
    draw_triangle(tip_x, tip_y, base_x1, base_y1, base_x2, base_y2, outline);
}

function get_mouse_pos()
{
	if global.settings.border_type != e_bordertype.not_enabled
	{
		if global.settings.fullscreen || global.settings.show_border_windowed
		return 
		{
			x: -20 + ((mouse_x - cam_x) / 0.89) + cam_x,	
			y: -14 + ((mouse_y - cam_y) / 0.89) + cam_y
		}
	}
	return 
	{
		x: mouse_x, 
		y: mouse_y
	}
	
}