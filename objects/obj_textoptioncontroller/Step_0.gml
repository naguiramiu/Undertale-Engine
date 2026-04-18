var ary = array_length(options)
var prev = option_selected
created = true
switch ary
{
	case 2: 
		if left_key_press || right_key_press option_selected = !option_selected
	break;
	case 3: 
		if left_key_press option_selected = 0
		if right_key_press option_selected = 2
		if down_key_press option_selected = 1 
		if up_key_press option_selected = 0 
	break;
	case 4:
	if !diagonal
	{
		option_selected = scr_updown_modwrap(option_selected,ary,-1,,2)
		option_selected = scr_leftright_modwrap(option_selected,ary,-1,1)
	}
	else
	{
		if down_key_press option_selected = 2
		if up_key_press option_selected = 0	
		if right_key_press option_selected = 1
		if left_key_press option_selected = 3
	}
	break;
}

if prev != option_selected play_sound(snd_menu_move)

if interact_key_press
{
	var er = "Error! Textbox option call not assigned correctly"
	var result = options[option_selected].result
	if result == -1 show_poppup(er + "\n Result " + string(option_selected) + " is -1") else
	try 
	{
		with options[option_selected]
		var o = customevent_get_params("result")
		
		function_call(result,o)
	}
	catch (e)
	{
		show_poppup(er)
		show_debug_message(e)
	}
	instance_destroy()
	destroy_instances(option_instances)	
}