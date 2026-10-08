spawn_cooldown_min = 360;
spawn_cooldown_max = 720;
max_monsters = 10;
spawn_radius = 0;
monster = obj_toxic_ball;

//босс
is_boss_level = false;
boss_object = obj_enemy_repa;
boss_cleared = false;

alarm[0] = irandom_range(spawn_cooldown_min, spawn_cooldown_max);