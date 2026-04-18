/// @description Dev
draw_set_font(font_deter_12)
if !instance_exists(obj_battlecontroler)
{
	if (wall_hitboxes) 
	{
		with (obj_col_parent)	
		 draw_sprite_ext_optional(,,,,,,,,1)
	}

	if (other_hitboxes) 
	{
		with all
		if object_get_parent(object_index) != obj_col_parent && !array_contains([obj_camera,obj_maincontroller,obj_debug,obj_border_controller,obj_globalmusicplayer,obj_devmenu_debug],object_index)
		{
			if sprite_index != -1 
			{
				if string_pos("dev",sprite_get_name(sprite_index))
				draw_sprite_ext_optional(,,,,,,,,1)
				else 
				draw_sprite_stretched(spr_colorborder,0,x - sprite_xoffset,y - sprite_yoffset,sprite_width,sprite_height)
			}
		}
	}
}	

debug_overlay = is_debug_overlay_open()

if (show_information)
{
	var tt = 
	{
		fps_capped: string(fps),
		can_move: global.can_move,
		party: + string(global.stats.party)
	}
		
	if instance_exists(player)
	{ 
		tt.player_positions = "X: " + string(player.x) + " Y: " + string(player.y) + " Dir: " + front_direction_to_string(get_current_direction(player.front_vector)) + " Dir angle: " + string(player.front_vector)
		tt.player_speeds = "XSPD: " + string(player.xspd) + "YSPD: "+ string(player.yspd) + "Main speed: " + string(player.main_speed)
	}
		
	if instance_exists(obj_battlecontroler)
	{
		draw_set_halign(fa_right)
		var cx = 315
		for (var i = array_length(global.monsters) - 1; i >= 0; i--)
		{
			var val = global.monsters[i]
			var t = json_stringify(
			{
				name: val.name,
				hp: val.hp,
				max_hp: val.max_hp,
				can_be_spared: val.can_be_spared,
				can_be_selected: val.can_be_selected,
				attack: val.attack,
				defense: val.defense,
			}, true)
			draw_text_shadow_ext(cx,0,t,c_white,0.5,0)
			cx -= string_width(t) / 2
		}
	}
		
	draw_set_halign(fa_right)
	draw_set_valign(fa_bottom)
	draw_text_shadow_ext(cam_x + 315,225 + cam_y,json_stringify(tt,true),c_white,0.5,0)
	draw_reset_all()
		
}

if instance_exists(obj_devroomwarp)
exit

if (self_visible)
{
	mouse_cursor = cr_default
	outside = true
	interact = mouse_left_press
	right_interact = mouse_right_press
	back_key = back_key_press
	var h = variable_struct_get(current_menu,"max_height")
	
	draw_me(true,false,,,h)
	draw_me(,,,,h)
	
	if current_menu.func != -1 
		function_call(current_menu.func,current_menu.func_params)
	window_set_cursor(mouse_cursor)
	
	if back_key || (outside && interact)
	{
		if array_length(prev_menu) == 0
		self_visible = false
		else 
		if array_length(prev_menu) == 1
		{
			event_perform(ev_create,0)
			prev_menu = []
		}
		else 
			current_menu = array_pop(prev_menu)
		window_set_cursor(cr_default)	
	}
}

