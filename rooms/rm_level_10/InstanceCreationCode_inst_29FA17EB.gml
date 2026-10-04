spawn_cooldown_min = 120;
spawn_cooldown_max = 360;
max_monsters = 10;
spawn_radius = 0;
monster = obj_toxic_ball;

//босс
is_boss_level = true;
boss_object = obj_radiomonster;
boss_cleared = false;

alarm[0] = irandom_range(spawn_cooldown_min, spawn_cooldown_max);