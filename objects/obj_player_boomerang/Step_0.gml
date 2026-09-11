damage = irandom_range(3, 15);
if (!returning){
	x += dir * spd;
	
	if (abs(x - start_x) >= max_distance) {
        returning = true;
    }
} else {
	if (instance_exists(parent_player)){
		var _target_x = parent_player.x;
		var _target_y = parent_player.y - 8;
		
		var _return_dir = point_direction(x, y, _target_x, _target_y);
        x += lengthdir_x(spd, _return_dir);
        y += lengthdir_y(spd, _return_dir);
		
		if (place_meeting(x, y, parent_player)) {
            instance_destroy();
        }
	} else {
		instance_destroy();
	}
}