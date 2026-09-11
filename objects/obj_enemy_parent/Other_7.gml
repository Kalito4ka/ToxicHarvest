if (sprite_index == spr_death_animation) {
	if (star_drop) {
		var _spawned_star = instance_create_layer(x, y, "Instances", obj_star);
		_spawned_star.vspeed = -4;
		_spawned_star.gravity = 0.2;
	}
    instance_destroy();
}