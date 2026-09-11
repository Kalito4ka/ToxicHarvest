if (hp <= 0 && !is_dying) {
    is_dying = true;
    hspd = 0;
	vspd = 0;
    
    if (spr_death_animation != noone) {
        sprite_index = spr_death_animation;
        image_index = 0;
        image_speed = 1;
    } else {
        instance_destroy();
    }
}

if (hit_cooldown > 0) {
    hit_cooldown -= 1;
}

if (is_dying) {
    hspd = 0;
    vspd = 0;
	exit;
}