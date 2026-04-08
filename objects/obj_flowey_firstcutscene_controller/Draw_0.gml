#region ui
var char = get_char_by_party_position(0)
draw_set_font(font_mars_18)
draw_set_colour(c_white)
draw_text_transformed(cam_x + 15 + 85,cam_y + 200,"LV " + string(global.stats.lv),0.5,0.5,0)
var hp = max(0,char.hp)
var hp_barwdith_filled = ((char.max_hp * 1.3) / 2) - 1
var hp_barwdith = clamp((hp >= 0 ? (hp_barwdith_filled * (hp / char.max_hp)) : 0), 0,hp_barwdith_filled)

var string_hp = string(hp)
if string_length(string_hp) == 1 
string_hp = "0" + string_hp
draw_text_transformed(20.5 + cam_x + 147.5 + hp_barwdith_filled - 3, cam_y + 200,string_hp + " / " + string(char.max_hp),0.5,0.5,0);
draw_set_color(c_red)
draw_rectangle_wh(cam_x + 137.5 + 17, cam_y + 200,hp_barwdith_filled, 10, false)
draw_set_color(c_yellow)
draw_rectangle_wh(cam_x + 137.5 + 17, cam_y + 200,hp_barwdith, 10, false)
draw_set_color(c_white)
draw_set_font(font_8bit_9)
draw_text_transformed(cam_x + 128.5 + 15,cam_y + 201.5, "P",0.5,0.5,0)
draw_text_transformed(cam_x + 122 + 15, cam_y + 201.5, "H",0.5,0.5,0)
#endregion


screen_cover(,image_alpha)

if !instance_exists(player) exit;	

if draw_chars
	array_foreach(get_party_array_by_depth(),function(me) {	with me event_perform(ev_draw,ev_draw_normal) })
if audio_is_playing(snd_noise) || draw_soul
	draw_sprite_ext(spr_soul,0,ease_out(soul_progress,player.x - 2,cam_x + 158),ease_out(soul_progress,player.y - 12,cam_y + 160),0.5,0.5,0,c_white,image_alpha)
	
