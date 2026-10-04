function save_game_progress() {
    if (!instance_exists(obj_game_manager)) return;

    var _save_data = {
        level_open: obj_game_manager.level_open,
        level_stars: obj_game_manager.level_stars,
        total_stars: global.total_stars_collected,
        history_seen: obj_game_manager.history_seen
    };
    
    var _string = json_stringify(_save_data);
    
    var _file = file_text_open_write("save_data.json");
    if (_file != -1) {
        file_text_write_string(_file, _string);
        file_text_close(_file);
        show_debug_message("Прогресс успешно сохранен.");
    }
}

function load_game_progress() {
    if (!file_exists("save_data.json")) return;
    if (!instance_exists(obj_game_manager)) return;
    
    var _file = file_text_open_read("save_data.json");
    if (_file != -1) {
        var _string = file_text_read_string(_file);
        file_text_close(_file);
        
        var _save_data = json_parse(_string);
        
        if (is_struct(_save_data)) {
            if (variable_struct_exists(_save_data, "level_open")) {
                obj_game_manager.level_open = _save_data.level_open;
            }
            if (variable_struct_exists(_save_data, "level_stars")) {
                obj_game_manager.level_stars = _save_data.level_stars;
            }
            if (variable_struct_exists(_save_data, "total_stars")) {
                global.total_stars_collected = _save_data.total_stars;
            }
            if (variable_struct_exists(_save_data, "history_seen")) {
                obj_game_manager.history_seen = _save_data.history_seen;
            }
            
            show_debug_message("Прогресс загружен.");
        }
    }
}

function reset_game_progress() {
    if (file_exists("save_data.json")) {
        file_delete("save_data.json");
    }
    
    if (instance_exists(obj_game_manager)) {
        var _max_levels = array_length(obj_game_manager.level_open);
        for (var i = 0; i < _max_levels; i++) {
            obj_game_manager.level_open[i] = (i <= 1); // Уровень 0 и 1 по умолчанию открыты
            obj_game_manager.level_stars[i] = 0;
        }
        
        obj_game_manager.history_seen = false;
    }
    
    global.total_stars_collected = 0;
    
    show_debug_message("Прогресс сброшен.");
}