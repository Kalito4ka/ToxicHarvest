if (!is_active) {
    if (instance_exists(obj_player)) {
        if (point_distance(x, y, obj_player.x, obj_player.y) <= activation_range) {
            is_active = true;
        }
    }
    exit;
}
if (hp <= 0) {
    
    var _player = instance_find(obj_player, 0);
    if (instance_exists(_player)) {
        death_hspd = (x < _player.x) ? -2 : 2;
    } else {
        death_hspd = -image_xscale * 2;
    }
    death_vspd = -5;
}
if (sprite_index == sprite_attack) {
    
    if (floor(image_index) == 3 && !bullet_spawned) {
        
        instance_create_layer(x, y + 8, "Instances_pumpkin", obj_enemy_pumpkin_bullet);
        
        bullet_spawned = true;
    }
}

if (star_drop) {
	if (hp <= 0) {
		for (var i = 0; i < number_of_stars; i++) {
		    var _spawned_star = instance_create_layer(x + random_range(-10, 10), y, "Instances", obj_star);
			 _spawned_star.vspeed = random_range(-4, -3);
			_spawned_star.gravity = 2;
		}
		star_drop = false;
		instance_destroy();
	}
}