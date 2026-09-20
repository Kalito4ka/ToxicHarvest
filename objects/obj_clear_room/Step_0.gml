if (!is_cleared) {
    if (!instance_exists(boss_to_watch)) {
        
        is_cleared = true;
        
        with (obj_enemy_parent) {
            if (variable_instance_exists(id, "hp")) {
                hp -= 9999;
            }
            if (variable_instance_exists(id, "spawn_delay")) {
                spawn_delay = 0;
            }
        }
        
        instance_destroy();
    }
}