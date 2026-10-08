if (variable_instance_exists(id, "finished") && finished) exit;
finished = true; 

var _room_name = room_get_name(room);
var _digits = string_digits(_room_name);

if (_digits != "") {
    var _current_level = real(_digits);
    var _stars_on_this_level = stars_found;

    if (_stars_on_this_level > obj_game_manager.level_stars[_current_level]) {
        obj_game_manager.level_stars[_current_level] = _stars_on_this_level;
    }

    with (obj_game_manager) {
        update_unlocked_levels();
    }

    save_game_progress();
}

audio_play_sound(snd_level_win, 5, false);
transition_to_room(rm_menu);