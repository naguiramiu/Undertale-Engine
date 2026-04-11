/// @description Flavor text
var dial = variable_clone(global.flavor_text)
if is_array(dial) dial = dial[irandom(array_length(dial) -1)]
flavor_text_instance = create_battle_textbox(dial,{can_advance: false, visible: false})

