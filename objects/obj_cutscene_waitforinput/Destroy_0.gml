if do_timer && instance_exists(creator)
with creator
alarm_set_instant(0,other.next_timer)