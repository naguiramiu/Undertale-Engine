/// @description Sort actions
function battle_sort_actions()
{
	array_remove_value_ext(actions,
	function(pos){return (actions[pos] == -1)})
	
	array_sort(actions,function(a,b)
	{
	    if (a.priority != b.priority) 
	        return a.priority - b.priority; 
	    return a.done_by < b.done_by ? 1 : -1;
	})
	controler_can_move = false
	battle_next_action()
}