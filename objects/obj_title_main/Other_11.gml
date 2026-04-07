/// @description Area background 

var area = file.saved_room_info_struct.area_id

area_draw_event = -1 

// if you want to do something like ut yellow where each area has a unique background, do it here
switch area 
{
	case AREA_RUINS:
		area_draw_event = function()
		{
			draw_sprite(spr_ruins_lightground_0,0,70,180)
			draw_sprite(spr_ruins_door_small,0,109,-35)
		}
	break;
	
}