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
	
	if string_starts_with(color_name,"c_") color_name = string_copy(color_name,3,string_length(color_name))
    switch string_lower((color_name)) {
        case "white": case "w": return c_white;
        case "black": case "k": return c_black;
        case "gray": case "gr": return c_gray;
        case "silver": return c_silver;
        case "red": case "r": return c_red;
        case "maroon": return c_maroon;
        case "yellow": case "y": return c_yellow;
        case "olive": return c_olive;
        case "lime": case "l": return c_lime;
        case "green": case "g": return c_green;
        case "aqua": case "a": return c_aqua;
        case "teal": case "t": return c_teal;
        case "blue": case "b": return c_blue;
        case "navy": return c_navy;
        case "fuchsia": case "p": return c_fuchsia;
        case "purple": return c_purple;
        case "orange": case "o": return c_orange;
        default: return c_white;
    }
}