depth = UI_DEPTH - 200

with (all) 
	if variable_instance_exists(id,"event_room_warp_start")	
		event_room_warp_start()
		
global.can_move = false;

cutscene_start
(
	cutscene_create
	(
		cut_interpolate_var(obj_camera,"screen_darken",0.1,0,1),
		cut_perform_function(0,function()
		{
			with (obj_parent_roomtransition)
			{
				room_goto(target_room)
				if (works && instance_exists(player))
					room_transition_warp(target_room,mywarp,horizontal_dir,vertical_dir,insta_tp_party)
			}
		}),
		cut_interpolate_var(obj_camera,"screen_darken",0.1,1,0,5,,true),
		cut_can_move(let_player_move),
		cut_perform_function(0,instance_destroy,obj_parent_roomtransition)
	),,
	true
)

