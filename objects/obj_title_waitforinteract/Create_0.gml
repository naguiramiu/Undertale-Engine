instance_to_create = obj_title_namescreen

// it assumes you have no file so it send you to the name screen
// it loops through the files to see if any of them are loaded,
// so, if you have 1 file it takes you to title main else fileselect

if array_any(scr_array_fill_savefiledata(),function(val){ return val.loaded; })
instance_to_create = NUMBER_OF_SAVEFILES > 1 ? obj_fileselect : obj_title_main

cutscene_perform_event = false
waited = false
depth = UI_DEPTH + 1

var cutscene = cutscene_create
(
	cut_playsound(snd_intronoise),
	cut_wait(5),
	[set_later,120,obj_title_waitforinteract,"waited",true],
	cut_waitforinput(e_waitforinput_type.interact_key),
	cut_wait(1),
	cut_perform_function(0,instance_destroy,obj_title_waitforinteract),
	[instance_create,instance_to_create],
)
obj_camera.screen_darken = false
cutscene_start(cutscene,,false)


// if you dont press interact in 10 seconds it takes you back to the story
do_later(450,function()
{
	if instance_exists(obj_title_waitforinteract)	
		room_goto(rm_title_story)
})

keyboard_lastchars = string_repeat(" ",16)
ball_triggered = false