if (state == "afraid") {
    if (instance_exists(obj_player)) {
        image_xscale = (obj_player.x >= x) ? 1 : -1;
    }
    
	afraid_timer--;
    if (afraid_timer <= 0) {
        state = "idle";
        sprite_index = spr_idle;
    }
}

// покой
if (state == "idle") {
    if (instance_exists(obj_player)) {
        image_xscale = (obj_player.x >= x) ? 1 : -1;
        
        if (place_meeting(x, y, obj_player)) {
            state = "hugging";
            sprite_index = spr_hug;
            image_index = 0;
            image_speed = 1;
            
            if (obj_player.x < x) {
                image_xscale = -1; 
            } else {
                image_xscale = 1;
            }
            
            if (instance_exists(obj_camera_controller)) {
                obj_camera_controller.target_cam_w = obj_camera_controller.default_cam_w * 0.5;
                obj_camera_controller.target_cam_h = obj_camera_controller.default_cam_h * 0.5;
            }
            
            with (obj_player) {
                visible = false;
                x = other.x;
            }
        }
    }
}

// завершение уровня
if (state == "wait_finish") {
    finish_timer--;
    if (finish_timer <= 0) {
        
        if (variable_instance_exists(id, "finished") && finished) exit;
        finished = true; 

        var _room_name = room_get_name(room);
        var _digits = string_digits(_room_name);

        if (_digits != "") {
            var _current_level = real(_digits);
            var _stars_on_this_level = 3;

            if (_stars_on_this_level > obj_game_manager.level_stars[_current_level]) {
                obj_game_manager.level_stars[_current_level] = _stars_on_this_level;
            }

            var _sum = 0;
            for (var i = 1; i <= obj_game_manager.total_levels; i++) {
                _sum += obj_game_manager.level_stars[i];
            }
            global.total_stars_collected = _sum;

            var _next_level = _current_level + 1;
            if (_next_level <= obj_game_manager.total_levels) {
                obj_game_manager.level_open[_next_level] = true;
            }
        }
		save_game_progress();
        transition_to_room(rm_menu);
    }
}