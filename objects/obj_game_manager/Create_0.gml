total_levels = 10;
level_open = array_create(total_levels + 1, false);
level_open[1] = true;
level_stars = array_create(total_levels + 1, 0);
global.total_stars_collected = 0;

if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}
history_seen = false;
load_game_progress();