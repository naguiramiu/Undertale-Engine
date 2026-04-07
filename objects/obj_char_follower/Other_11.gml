/// @description Image follow code
/// sets up my specific thing

var num = ((number_in_party * (global.party_distance)) - 1)
// your distance from the player

var current = record[num]
x = current.x 
y = current.y 
front_vector = current.front_vector

player_animate()