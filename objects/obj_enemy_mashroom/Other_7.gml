if (sprite_index == spr_death_animation) {
	if (star_drop) {
		for (var i = 0; i < number_of_stars; i++) {
		    var _spawned_star = instance_create_layer(x + random_range(-10, 10), y, "Instances", obj_star);
			 _spawned_star.vspeed = random_range(-4, -3);
			_spawned_star.gravity = random_range(0.2, 0.7);
		}
	}
	stop_boss_music(1500);
	instance_destroy();
}