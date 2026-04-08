ended = false 

darken = true
depth = BATTLE_DEPTH
set_border(spr_border_simple)
draw_soul = false
cutscene_perform_event = false
draw_chars = true
global.can_move = false 
soul_progress = 0
var cutscene = cutscene_create
(
	cut_playsound(snd_noise,,4),
	cut_playsound(snd_noise,,4),
	cut_set_var(id,"draw_chars",false),
	cut_set_var(id,"draw_soul",true,2),
	cut_playsound(snd_battlefall),
	cut_interpolate_var(id,"soul_progress",0.05,0,1,0),
	cut_perform_function(0,function()
	{
		instance_create(obj_battle_background_dark)
		instance_create_depth(cam_x + 137.5,cam_y + 65,BATTLE_DEPTH - 10, obj_flowey_firstcutscene_enemy)
		
		with instance_create(obj_battlebox)
		{
			width = global.battlebox_width 
			height = global.battlebox_height
			visible = true
		}
		
		with instance_create_depth(cam_x + 158,cam_y + 160,BATTLE_DEPTH,obj_soul)
		instance_create_depth(x,y,depth + 1,obj_guidearrows)
		
	}),
	cut_interpolate_var(id,"image_alpha",0.1,1,0,0),
	cut_set_var(obj_soul,"can_move",true)
	//cut_perform_function(0,instance_destroy,id),
	
)	
cutscene_start(cutscene)
