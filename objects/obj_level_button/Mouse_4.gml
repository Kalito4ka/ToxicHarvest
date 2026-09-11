var _is_open = obj_game_manager.level_open[level_number];

if (_is_open) {
	var _target_room = asset_get_index("rm_level_" + string(level_number));
	image_index = 1;
	if (_target_room != -1){
		room_goto(_target_room);
	}
}