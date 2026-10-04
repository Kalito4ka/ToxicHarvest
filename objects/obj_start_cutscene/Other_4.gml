var _room_name = room_get_name(room);
if (_room_name == "rm_level_1") {
    if (!obj_game_manager.history_seen) {
        if (!instance_exists(obj_cutscene_history)) {
            instance_create_depth(0, 0, -200000, obj_cutscene_history);
        }
    }
}