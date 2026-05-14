// acurate time passing

global.information.play_time += delta_time / 1000000

if open_menu_key_press
	if can_open_menu()
		instance_create(obj_mainmenu)
	else if instance_exists(obj_mainmenu)
		obj_mainmenu.event_destroy()
		
if keyboard_check_pressed(vk_f4)
{
	alarm[0] = 1 // 1 frame is the time gamemaker takes to actually switch the fullscreen
	window_set_fullscreen(!window_get_fullscreen())
}

scr_devfunctions()