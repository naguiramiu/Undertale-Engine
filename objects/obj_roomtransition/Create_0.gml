depth = UI_DEPTH - 200
alpha = 0

player_x_before_warp = player.x 
player_y_before_warp = player.y 

works = true 
let_player_move = true
with all if variable_instance_exists(id,"event_room_warp_start") event_room_warp_start()
triggered_can_move = false

global.can_move = false
lerp_var_ext(obj_camera,"screen_darken",0.1,0,1,,,
{
	room_to_go: target_room,
	event_destroy: function()	
	{
		room_goto(room_to_go)
		with obj_roomtransition event_user(0)
		set_later(5,global,"can_move",true)
		lerp_var_ext(obj_camera,"screen_darken",0.1,1,0,,,
		{
			persistent: true,
			event_destroy: function()
			{
				instance_destroy(obj_roomtransition)
			}
		}) 
	},
	persistent: true
})