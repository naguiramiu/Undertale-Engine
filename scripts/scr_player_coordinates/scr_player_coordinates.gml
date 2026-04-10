
function front_direction_to_string(vec)
{
	switch round(vec)
	{
		case RIGHT: return "right";
		case LEFT: return "left";
		case UP: return "up";
		case DOWN: return "down";
		default:
		return "down";
	}
}

function mouse_check_hovers_rect_wh(x1, y1, w, h,mousex = mouse_x,mousey = mouse_y) {
    return (mousex >= x1 && mousex <= (x1 + w) && mousey >= y1 && mousey <= (y1 + h));
}
function mouse_check_hovers_rect(x1, y1, x2, y2,mousex = mouse_x,mousey = mouse_y) {
    return (mousex >= x1 && mousex <= x2 && mousey >= y1 && mousey <= y2);
}

function custom_warp_player(rm_id,set_coords = true)
{
	var room_spawn = room_get_spawn_coords(rm_id)
	room_goto(rm_id)
	obj_char.x = room_spawn[0]
	obj_char.y = room_spawn[1]
}

function gui_y_to_screen(y)
{
	return ((y - camera_get_view_y(view_camera[0])) * 0.89) * 2
}
function gui_x_to_screen(x)
{
	return ((x - camera_get_view_x(view_camera[0])) * 0.89) * 2
}

function screen_x_to_gui(screen_x)
{
    return ((screen_x - cam_x) * 2)
}
function screen_y_to_gui(screen_y)
{
    return ((screen_y - cam_y) * 2)
}

function scr_teleport_player(to_x,to_y,insta_tp_party = false)
{
	player.x = to_x 
	player.y = to_y 
	// setting the position of the party after warping
	if array_length(global.party_instances) > 1 
	{
		for (var i = 1; i < array_length(global.party_instances); i++) // go through the party and ignore pos 0 (mainchar)
		with global.party_instances[i]
		{
			var reverse_dir = (player.front_vector + 180) % 360;
			for (var p = array_size - 1; p >= 0; p--)
			{
				var this = record[p]
				if insta_tp_party //insta tp party ignores the characters previous x from the other room and places them at a set position from the player
				{
					this.x = player.x + lengthdir_x(p, reverse_dir);
					this.y = player.y + lengthdir_y(p, reverse_dir);
					this.front_vector = player.front_vector
				}
				else // they keep their position, great for warps in the sides of rooms
				{
					this.x += (player.x - player.xprevious);
					this.y += (player.y - player.yprevious);
				}
			}
		}
	}
	
	obj_camera.set_camera_position(true)
	with parent_char set_depth()
}


function player_below_half_y()
{
	return (instance_exists(player) ? ((player.y - cam_y - 20) > cam_y * 0.5) : false)
}

/// @desc Returns true if the target is within a certain distance of an angle cone
/// @param target_x The x of the npc/object
/// @param target_y The y of the npc/object
/// @param max_dist Hhow close the player needs to be (eg 30)
/// @param max_angle the cone of vision (eg 30 degrees)
function player_is_facing_point(_tx,_ty,_max_dist = 30,_max_angle = 45,debug = false) 
{
	if !instance_exists(player) return false;
	var px = player.x   
	var py = player.y - 7
	if debug 
	{
	    var col = draw_get_colour()
	    var is_facing = player_is_facing_point(_tx, _ty, _max_dist, _max_angle, false)
	    draw_set_color(is_facing ? c_green : c_red)
	    draw_circle(_tx, _ty, 4, false)
		draw_set_alpha(0.5)
		draw_primitive_begin(pr_trianglefan)
		draw_vertex(px, py)
		for (var i = -_max_angle; i <= _max_angle; i += 5) 
		    draw_vertex(px + lengthdir_x(_max_dist, (player.front_vector + i)), py + lengthdir_y(_max_dist, (player.front_vector + i)))
		draw_primitive_end()
	    draw_reset_alpha()
	    draw_set_colour(col)
	}
	
    if (point_distance(px, py, _tx, _ty) > _max_dist) return false
    return ((abs(angle_difference(player.front_vector, point_direction(px, py, _tx, _ty)))) <= _max_angle)
}


