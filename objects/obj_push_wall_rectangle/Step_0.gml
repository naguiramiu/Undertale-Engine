// this collision will push the player

while (place_meeting(x, y, player))
{
    var dir = point_direction(x, y, player.x, player.y)
    player.x += lengthdir_x(1, dir)
    player.y += lengthdir_y(1, dir)
    if (x == player.x && y == player.y)
        player.y ++
}