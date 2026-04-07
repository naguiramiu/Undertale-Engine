if place_meeting(x,y,player)
{ 
	instance_create_depth(x,y,depth,obj_cutsceneplayer,{cutscene: cutscene});
	instance_destroy();
}