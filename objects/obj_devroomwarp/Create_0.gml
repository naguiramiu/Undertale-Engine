depth = UI_DEPTH + 1

room_info = rooms_get_info() 

room_area_selected = AREA_RUINS

array_remove_value_ext(room_info,function(i) {return array_contains([rm_setup,rm_titlescreen,rm_gameover,rm_dogcheck,rm_title_story], room_info[i].room_id)})

var room_option = function(_name,_type,_color) constructor {name = _name type = _type color = _color}
room_options = 
[
	new room_option("Other",AREA_NONE,c_white),
	new room_option("Ruins",AREA_RUINS,#C78ECC),
]

filter = false