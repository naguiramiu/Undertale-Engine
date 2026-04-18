/// @description Follow player code
// sets up the giant array containing htese things

var lerpspeed = 0.7

for (var i = follower_remember_size -1; i > 0; i--)
{
	var prev = record[i - 1]
	var this = record[i]
	
	if point_distance(this.x,this.y,prev.x,prev.y) < 10
		{
			this.x = prev.x 
			this.y = prev.y
		}
		else
		{
			this.x = lerp(this.x,prev.x,lerpspeed)
			this.y = lerp(this.y,prev.y,lerpspeed)
		}
	this.front_vector = prev.front_vector
}

var current = record[0]
current.front_vector = player.front_vector
current.x = player.x
current.y  = player.y