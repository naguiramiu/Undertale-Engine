var total_count = 4
var ydist = 60

globalmusic_stop(true)
globalmusic_play(mus_dogsong,0,0,true,true)

if instance_exists(obj_border_controller)
set_border(spr_border_simple)
for (var v = 0; v < 2; v ++)
{
	var center_y = room_height / 2
	var _y = (v ? center_y + ydist : center_y - ydist)
	var _dir = (v ? -1 : 1)
	var spacing = 120

	for (var i = 0; i < total_count; i++)
	{
	    var is_bone = ((i % 2) == 0);
	    with instance_create_depth(i * spacing, _y, -100, obj_event_performer)
	    {
			dir = _dir
	        sprite_index = (is_bone ? spr_bone : spr_whitepom)
			bone = is_bone
	        loop_w = spacing * total_count
	        event_draw = function()
	        {
	            x += 4 * dir 
			
				var center_x = room_width / 2;
				var dist = abs(x - center_x);
				var normalized_dist = dist / center_x;
				var cent = 1 - normalized_dist;
				cent = clamp(cent, 0, 1);
				
				x += cent * dir
				
				if dir == -1 
				{
		            if (x < -120) 
		                x += loop_w 
				}
				else 
					if (x > room_width + 120) 
		                x -= loop_w 
				
				if bone 
					 draw_sprite_ext(sprite_index, image_index, x, y + sin((current_time + x) * 0.005) * 5, 3 * -dir, 3, 0, c_white, 1);
				else
				{
					sprite_index = (cent > 0.7 ? spr_whitepom_mouth : spr_whitepom)
					
					var _s_ext = 1 + max(0,cent - 0.5) * 0.1
					var _y_offset = (sprite_height * (_s_ext - 1)) / 2;
					draw_sprite_ext(sprite_index, image_index, x, y - _y_offset, 3 * -dir, 3 * _s_ext, image_angle, c_white, 1);
				}
	        }
		}
	}
}
instance_deactivate_object(parent_char)

event_room_end = globalmusic_stop