cutscene = 
[
	cut_set_var(inst_ruinspuzzle0_toriel,"move",UP,0),
	cut_wait(20),
	cut_interpolate_var(inst_ruinspuzzle0_toriel,"image_alpha",0.5,1,0),
	cut_perform_function(0,instance_destroy,inst_ruinspuzzle0_toriel)
]