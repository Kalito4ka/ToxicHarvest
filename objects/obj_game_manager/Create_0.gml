total_levels = 10;
level_open = array_create(total_levels + 1, false);
level_open[1] = true;
level_stars = array_create(total_levels + 1, 0);
global.total_stars_collected = 0;
audio_falloff_set_model(audio_falloff_linear_distance_clamped);
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}
history_seen = false;
load_game_progress();

function update_unlocked_levels() {
    level_open[1] = true;

    var _sum = 0;
    for (var i = 1; i <= total_levels; i++) {
        _sum += level_stars[i];
    }
    global.total_stars_collected = _sum;

    for (var lvl = 2; lvl <= total_levels; lvl++) {
        var _prev_open = level_open[lvl - 1]; // Открыт ли предыдущий уровень?
        
        if (_prev_open) {
            switch (lvl) {
                case 4:
                    if (global.total_stars_collected >= 9) level_open[lvl] = true;
                    break;

                case 8:
                    if (global.total_stars_collected >= 21) level_open[lvl] = true;
                    break;

                case 10:
                    if (global.total_stars_collected >= 27) level_open[lvl] = true;
                    break;

                default:
                    level_open[lvl] = true;
                    break;
            }
        }
    }
}