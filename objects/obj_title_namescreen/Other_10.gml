lan = get_lan(lan_text_title,"namescreen")

var menu = function(_name,_event) constructor 
{
	name = get_lan(lan_text_title,"namescreen",_name) event = _event
}

bottom_menu = 
[
	new menu("quit",
	function()
	{
		in_instructions = true
		instructions_selection = 0
	}),
	new menu("backspace",
	function()
	{
		name = string_copy(name,1,string_length(name) - 1)	
	}),
	new menu("done",function()
	{
		if !string_length(name)
		{
			play_sound(snd_cantselect)
			exit;
		}
		name_chosen = true 
		lerp_var_ext(id,"name_lerp",0.01,0,1) 
		var check = scr_namecheck(name)
		
		top_text = string_linebreaks(check.response)
		name_allows_entry = check.allow
	})
]
