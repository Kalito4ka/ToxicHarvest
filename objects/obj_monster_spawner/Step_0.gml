if (is_boss_level && !boss_cleared) {
    
    if (!instance_exists(boss_object)) {
        boss_cleared = true;
        
        with (obj_enemy_parent) {
            if (variable_instance_exists(id, "hp")) {
                hp -= 9999;
            } else {
                instance_destroy(); 
            }
        }
    }
}