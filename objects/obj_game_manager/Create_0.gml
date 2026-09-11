total_levels = 5;
level_open = array_create(total_levels + 1, false);
level_open[1] = true;
level_stars = array_create(total_levels + 1, 0);
global.total_stars_collected = 0;