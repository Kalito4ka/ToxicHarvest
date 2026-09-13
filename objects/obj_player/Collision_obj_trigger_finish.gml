// Защита от многократного срабатывания триггера за один запуск
if (variable_instance_exists(id, "finished") && finished) exit;
finished = true; 

// Автоматическое получение номера уровня из названия комнаты
var _room_name = room_get_name(room);
var _digits = string_digits(_room_name);

if (_digits != "") {
    var _current_level = real(_digits);
    var _stars_on_this_level = stars_found;

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
		
	    // Особое условие для 5-го уровня
	    if (_next_level == 5) {
	        if (global.total_stars_collected >= 12) {
	            obj_game_manager.level_open[_next_level] = true;
	        }
	    } else {
	        // Для всех остальных уровней разблокировка обычная
	        obj_game_manager.level_open[_next_level] = true;
	    }
	}
}

room_goto(rm_menu);