if (instance_exists(obj_room_transition)) exit;

var _is_open = obj_game_manager.level_open[level_number];

if (_is_open) {
    var _target_room = asset_get_index("rm_level_" + string(level_number));
    
    if (_target_room != -1) {
		audio_play_sound(snd_level_selected, 5, false);
        image_index = 1;
        transition_to_room(_target_room);
    }
}