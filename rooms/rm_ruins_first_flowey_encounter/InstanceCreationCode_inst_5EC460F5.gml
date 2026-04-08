

cutscene = 
[
	cut_perform_function(0,globalmusic_play,[mus_flowey,0]),
	cut_textbox_talker(global.talker.flowey_default),
	//cut_textbox("* Howdy!{.&}* I'm {col:y}FLOWEY{/col}.{&.}* {col:y}FLOWEY{/col} the {col:y}FLOWER{/col}!"),
	//cut_textbox("* Hmmm..."),
	//cut_textbox("* You're new to the UNDERGROUND, aren'tcha?"),
	//cut_textbox("* Golly, you must be so confused."),
	//cut_textbox("* Someone out to teach you how things work around here!"),
	//cut_textbox("* I guess little old me will have to do."),
	//cut_textbox("* Ready?{.&}* Here we go!."),
	cut_perform_function(0,instance_create,[obj_flowey_firstcutscene_controller,{lay: layer}])

]