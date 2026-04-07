if !visible exit;

draw_self()

if !instance_exists(my_dialogue) && can_open_textbox() && 
place_meeting(x,y,player)
{
	draw_set_halign(fa_center)	
	draw_text_transformed_shadow(player.x,player.y - 10,"PRESS Z",1,1,0)
	draw_set_halign(fa_left)
}