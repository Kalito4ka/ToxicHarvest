spawn_cooldown_min = 360;
spawn_cooldown_max = 3600;
max_monsters = 10;
spawn_radius = 0;
monster = obj_enemy_slime;

//для токсичного шара
spawn_fly_dir = undefined;

//босс
is_boss_level = true;
boss_object = obj_enemy_repa;
boss_cleared = false;

alarm[0] = irandom_range(spawn_cooldown_min, spawn_cooldown_max);