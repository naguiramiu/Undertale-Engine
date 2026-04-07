function color_to_rgb_array(col)
{
	return [color_get_red(col) / 255,color_get_green(col) / 255,color_get_blue(col) / 255]
}    

function multiply_start(fullcolor = true)
{
	gpu_set_blendmode_ext_sepalpha(bm_zero, bm_src_colour, bm_src_alpha, bm_inv_src_alpha);
	shader_set(fullcolor ? sh_multiply_fullcolor : sh_multiply)
}

function multiply_end()
{
	shader_reset()
	gpu_set_blendmode(bm_normal)
}

function hex_to_color(hex_str)
{
    hex_str = string_replace(hex_str, "#", "");
    var red_str = string_copy(hex_str, 1, 2);
    var green_str = string_copy(hex_str, 3, 2);
    var blue_str = string_copy(hex_str, 5, 2);
    var red = hex_to_dec(red_str);
    var green = hex_to_dec(green_str);
    var blue = hex_to_dec(blue_str);
   return make_color_rgb(red, green, blue);
}
function hex_to_dec(hex) 
{
    return real("0x" + hex);
}

function string_to_color(color_name)
{
	
	if !string_starts_with(color_name,"c_") color_name = "c_" + color_name
    switch (color_name) {
        case "c_white": return c_white;
        case "c_black": return c_black;
        case "c_gray": return c_gray;
        case "c_silver": return c_silver;
        case "c_red": return c_red;
        case "c_maroon": return c_maroon;
        case "c_yellow": return c_yellow;
        case "c_olive": return c_olive;
        case "c_lime": return c_lime;
        case "c_green": return c_green;
        case "c_aqua": return c_aqua;
        case "c_teal": return c_teal;
        case "c_blue": return c_blue;
        case "c_navy": return c_navy;
        case "c_fuchsia": return c_fuchsia;
        case "c_purple": return c_purple;
        case "c_orange": return c_orange;
        default: return c_white;
    }
}