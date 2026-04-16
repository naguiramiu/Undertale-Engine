cutscene = 
[
	cut_set_var(inst_ruinspuzzle0_toriel,"movement","walk"),
	cut_set_var(inst_ruinspuzzle0_toriel,"animate_walking",true),
	cut_move_instance(inst_ruinspuzzle0_toriel,"y",-3,-100,0,true),
	cut_wait(12),
	cut_interpolate_var(inst_ruinspuzzle0_toriel,"image_alpha",0.4,1,0),
	cut_perform_function(0,instance_destroy,inst_ruinspuzzle0_toriel)
]