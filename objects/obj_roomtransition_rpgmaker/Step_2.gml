if !surface_exists(room_surf) && surface_exists(application_surface)
{
	var _w = surface_get_width(application_surface)
	var _h = surface_get_height(application_surface)
	room_surf = surface_create(_w, _h)
	var _buff = buffer_create(_w * _h * 4, buffer_fixed, 1)
	buffer_get_surface(_buff, application_surface, 0)
	buffer_set_surface(_buff, room_surf, 0)
	buffer_delete(_buff)
}

if !started
{
	room_goto(target_room)
	if (works && instance_exists(player))
		room_transition_warp(target_room,mywarp,horizontal_dir,vertical_dir,insta_tp_party)
				
	alarm[0] = 5
	
	lerp_var_ext(obj_parent_roomtransition,"image_alpha",0.05,1,0,,,
	{
		event_destroy: instance_destroy,
		event_destroy_params: obj_parent_roomtransition,
		persistent: true
	})
	
	started =  true
}