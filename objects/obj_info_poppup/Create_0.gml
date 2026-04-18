y = 0
depth = UI_DEPTH - instance_number(obj_info_poppup)

draw_me = function(vis = true)
{
	draw_reset_all()
	draw_set_alpha(image_alpha)
	draw_set_font(font_deter_12)
	var padding = 5
	var max_w = 200
	var scale = 0.5
	var sw = (string_width_ext(text, 16, max_w) * scale)
	var sh = (string_height_ext(text, 16, max_w) * scale)
	box_width = sw + (padding * 2)
	box_height = sh + (padding * 2)
	var menu_x = cam_x + 320 - box_width
	if vis
	{
		draw_menu(menu_x + x, y + cam_y, box_width - 1, box_height, 1)
		draw_text_ext_transformed((x + cam_x + 320 - padding) - sw, y + cam_y + padding, text, 16, max_w, scale, scale, 0)
	}
	draw_reset_alpha()
}

draw_me(false)

if (instance_number(obj_info_poppup) > 1)
{
	for (var i = 0; i < instance_number(obj_info_poppup); i++) 
	{
		var inst = instance_find(obj_info_poppup,i)
		if inst == id break;
		y += inst.box_height + 2.5
	}
}

alarm[0] = round(50 + string_length(text) / 2)
fade = false 
x = box_width
lerp_var_ext(id,"x",0.1,box_width,0,ease_out)