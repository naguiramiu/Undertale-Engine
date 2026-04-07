#region KEYMAP
	#macro left_key_hold (key_check(keyboard_check,vk_left))
	#macro right_key_hold (key_check(keyboard_check,vk_right))
	#macro down_key_hold (key_check(keyboard_check,vk_down))
	#macro up_key_hold (key_check(keyboard_check,vk_up))
	#macro left_key_press (key_check(keyboard_check_pressed,vk_left))
	#macro right_key_press (key_check(keyboard_check_pressed,vk_right))
	#macro down_key_press (key_check(keyboard_check_pressed,vk_down))
	#macro up_key_press (key_check(keyboard_check_pressed,vk_up))
	#macro interact_key_hold (key_check(keyboard_check,vk_enter))
	#macro interact_key_press (key_check(keyboard_check_pressed,vk_enter))
	#macro back_key_hold (key_check(keyboard_check,vk_backspace))
	#macro back_key_press (key_check(keyboard_check_pressed,vk_backspace))
	#macro open_menu_key_press (key_check(keyboard_check_pressed,vk_control))
	#macro open_menu_key_hold (key_check(keyboard_check,vk_control)) 
	#macro space_key_press (keyboard_check_pressed(vk_space)) 
	#macro space_key_hold (keyboard_check(vk_space)) 
	#macro escape_key_hold (key_check(keyboard_check,vk_escape)) 
	#macro escape_key_press (key_check(keyboard_check_pressed,vk_escape)) 
#endregion

function key_check(check_func,key)
{
	if USING_CONTROLLER
		if scr_gamepad_key_inputs(key,scr_keyboardfunctogamepad(check_func),global.controller) return true;
	
	switch key 
	{
		case vk_left:
			return (check_func(vk_left) || check_func(ord(global.settings.keys.key_left)));
		case vk_right:
			return (check_func(vk_right) || check_func(ord(global.settings.keys.key_right)));
		case vk_down:
			return (check_func(vk_down) || check_func(ord(global.settings.keys.key_down)));
		case vk_up:
			return (check_func(vk_up) || check_func(ord(global.settings.keys.key_up)));
		case vk_enter:
			return (check_func(vk_enter) || check_func(ord(global.settings.keys.key_confirm)));
		case vk_backspace:
			return (check_func(vk_shift) || check_func(vk_backspace) || check_func(ord(global.settings.keys.key_back)));
		case vk_control:
			return (check_func(vk_control) || check_func(vk_alt) || check_func(ord(global.settings.keys.key_menu)));
		case vk_escape:
			return (check_func(vk_escape));
	}	
}

