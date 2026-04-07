scr_checkforduplicate()
// an imaginary vector pointing to where you are looking at.
frame_animation_speed = 0.2;
event_inherited()
set_depth()
//speed of all animations
current_frame = 0; 
round_coordinates = true;
max_run_speed = 2 
current_run_speed = 0
// Main speed for the character, dont change unless the player should permanentely move at another speed.
// for local speed changes, there is a multiplier added on top of this later
main_speed = 3
#region speed and correct direction values

xdirection = true
ydirection = true
xspd = 0
yspd = 0
#endregion

#region previous frame variables
prev_meetingwall = false
prev_front_vector = front_vector
#endregion

prev_xspd = xspd 
prev_yspd = yspd