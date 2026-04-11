/// @description Unavailable menus
unavailable_menus = []
if global.stats.inventory[0] == ITEM_EMPTY
array_push(unavailable_menus,1) // 1 is sell