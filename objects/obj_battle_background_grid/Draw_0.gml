draw_reset_alpha()
draw_set_colour(c_black)
draw_rectangle(-10,-10,room_width * 2,room_height * 2,0)
draw_set_colour(c_white)
draw_set_color(#22B14C)

var line_x = cam_x - 0.5
var line_y = cam_y - 0.5

for (var l = 0; l < 3; l ++)
{
	var line_distance_y = 117 / 2
	if l = 2 line_distance_y = 117.5 / 2
	draw_line(line_x + 7,line_y + 4.5 + (l * line_distance_y),line_x + 311,line_y + 4.5 + (l * line_distance_y))
}
var distx = [ 7.50,57.50,108.60,158.25,209.90,261.45,311.40 ]
for (var w = 0; w < 7; w ++)
{
	var line_distance_x = distx[w]
	draw_line(line_x +line_distance_x,line_y + 4.5,line_x + line_distance_x,line_y + 122)
}
draw_set_colour(c_white)