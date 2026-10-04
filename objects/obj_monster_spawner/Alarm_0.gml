if (is_boss_level && !instance_exists(boss_object)) {
    exit;
}

if (instance_number(monster) < max_monsters) {
    
    var _spawn_x = x + irandom_range(-spawn_radius, spawn_radius);
    var _spawn_y = y + irandom_range(-spawn_radius, spawn_radius);
    
    var _inst = instance_create_layer(_spawn_x, _spawn_y, "Instances", monster);
	if (spawn_fly_dir != undefined) {
        _inst.fly_dir = spawn_fly_dir;
    }
}

alarm[0] = irandom_range(spawn_cooldown_min, spawn_cooldown_max);