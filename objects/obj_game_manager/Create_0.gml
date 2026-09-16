total_levels = 10;
level_open = array_create(total_levels + 1, false);
level_open[1] = true;
level_stars = array_create(total_levels + 1, 0);
global.total_stars_collected = 0;

if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

// Завершение уровня и обновление прогресса
function complete_level(_level_num, _stars_earned) {
    // Обновляем рекорд по звездам (если получили больше, чем было)
    if (_stars_earned > level_stars[_level_num]) {
        level_stars[_level_num] = _stars_earned;
        
        // Пересчитываем общее количество звезд по всем уровням
        recalculate_total_stars();
    }
    
    // Разблокируем следующий уровень
    var _next_level = _level_num + 1;
    if (_next_level <= total_levels) {
        level_open[_next_level] = true;
    }
}

//Вспомогательный пересчет всех звезд
function recalculate_total_stars() {
    var _sum = 0;
    for (var i = 1; i <= total_levels; i++) {
        _sum += level_stars[i];
    }
    global.total_stars_collected = _sum;
}