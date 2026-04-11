draw_reset_all()
if mouse_check_button(mb_left)
{
    mx = mouse_x - camera_get_view_x(view_camera[0])
    my = mouse_y - camera_get_view_y(view_camera[0])
}
if up_key_press my --
if down_key_press my ++
if left_key_press mx -- 
if right_key_press mx ++
if mouse_wheel_up() mz --
if mouse_wheel_down() mz ++
draw_set_font(font_deter_12)
if keyboard_check_pressed(vk_divide) draw_m = !draw_m
if draw_m
{
	draw_text_shadow(0,0,"x: " + string(mx) + " y: " + string(my) + " z: " + string(mz))
	with player
	draw_text_shadow(0,20,"x: " + string(x) + " y: " + string(y))
}