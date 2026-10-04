spawn_cooldown_min = 1200;
spawn_cooldown_max = 1800;
max_monsters = 2;
spawn_radius = 0;
monster = obj_enemy_ghost;

//босс
is_boss_level = true;
boss_object = obj_radiomonster;
boss_cleared = false;

alarm[0] = irandom_range(spawn_cooldown_min, spawn_cooldown_max);