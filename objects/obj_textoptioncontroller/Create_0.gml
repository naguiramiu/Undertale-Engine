txtbox_optioncoords = function(number_of_options,i,diagonal = false)
{
	var x_left = 72
	var menu_center_x = 144 + x_left
	var menu_bottom_y = 80
	
	switch number_of_options
	{
		case 2:	
			return [226 + lengthdir_x(120,(!i ? LEFT : RIGHT)), menu_bottom_y -57]
		case 3: 
			if i != 1 
				return [126 + 200 * (i == 2), menu_bottom_y - 50]
			return [menu_center_x, menu_bottom_y - 15]
	case 4:
	 
		var tri = (i + 3) % 4
		if diagonal	
			return [menu_center_x + lengthdir_x(180,tri * -90),menu_bottom_y - 57 + lengthdir_y(40,tri * -90)]
		menu_bottom_y -= 45
			return [x_left + 48 + 246 * (i % 2),menu_bottom_y + 35 * (i div 2)]
	}
	return [menu_center_x,menu_bottom_y - 20]
}
option_selected = 0
option_instances = []
created = false 
for (var i = 0; i < array_length(options); i++)
{
	if !is_struct(options[i])
		options[i] = textbox_option(options[i],-1)
	
	
	var option = options[i]
	var coords = txtbox_optioncoords(array_length(options),i,diagonal) 
	
	
	with instance_create_depth(0,0,depth,obj_textbox,
	{
		depth: other.creator.depth - 1,
		dialogue: option.text,
		draw_bg: false,
		is_option: true,
		do_get_details: true,
		x: option.x + coords[0] / 2,
		y: option.y + coords[1] / 2,
		event_pagewritten: function()
		{
			obj_textoptioncontroller.new_option()
		},
		option_num: i,
	})
	{
		other.option_instances[i] = id
		write = (i == 0)
		
	}
}
array_push(option_instances,creator)

current = 0 
new_option = function()
{
	current ++ 
	if current < array_length(option_instances)
	option_instances[current].write = true 
}
