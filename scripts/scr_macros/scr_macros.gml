#region direction vectors. set your players direction this way.
#macro RIGHT 0
#macro UP 90
#macro LEFT 180
#macro DOWN 270
#endregion

#region purely debug macros
	#macro player obj_mainchar
	#macro cam_x obj_camera.x
	#macro cam_y obj_camera.y
	#macro mzz obj_debug.mz 
	#macro myy obj_debug.my
	#macro mxx obj_debug.mx
#endregion

#macro UI_DEPTH -10000
#macro BATTLE_DEPTH (UI_DEPTH + 3000)
#macro ENCRYPT_SAVEDATA true
#macro ENABLE_RUNNING true
#macro NUMBER_OF_SAVEFILES 1
#macro DEFAULT_MISSING_TEXT "@@missing text@@"

#macro USING_CONTROLLER (global.controller != -1)

#macro AREA_RUINS "area_ruins"
#macro AREA_NONE "area_none"
#macro AREA_DEV  "area_dev"

#macro SPARE_ALL_MONSTERS false

