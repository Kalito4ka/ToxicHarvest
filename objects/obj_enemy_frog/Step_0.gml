if (!is_active) {
    if (instance_exists(obj_player)) {
        if (point_distance(x, y, obj_player.x, obj_player.y) <= activation_range) {
            is_active = true;
        }
    }
    exit;
}
// Смерть
if (hp <= 0 && !is_dying) {
    is_dying = true;
    state = "dead";
    
    if (instance_exists(tongue_inst)) {
        instance_destroy(tongue_inst);
    }
    
    sprite_index = spr_death_animation;
    image_index = 0;
    image_speed = 0;
    image_alpha = 1;
	
	//спавн звезд при смерти
	if (star_drop) {
        for (var i = 0; i < number_of_stars; i++) {
            var _spawned_star = instance_create_layer(x + random_range(-10, 10), y, "Instances", obj_star);
            _spawned_star.vspeed = random_range(-4, -3);
            _spawned_star.gravity = random_range(0.2, 0.7);
        }
    }
    
    var _player = instance_find(obj_player, 0);
    if (instance_exists(_player)) {
        death_hspd = (x < _player.x) ? -1.5 : 1.5;
    } else {
        death_hspd = -image_xscale * 1.5;
    }
    
    death_vspd = -3;
    
    fade_speed = 0.1; 
}

if (is_dying) {
    death_vspd += death_gravity;
    x += death_hspd;
    y += death_vspd;
    
    // Постепенно уменьшаем прозрачность
    image_alpha -= fade_speed;
    
    if (image_alpha <= 0) {
        instance_destroy();
    }
    exit;
}

if (!is_active) exit;

if (hit_cooldown > 0) hit_cooldown--;
if (attack_cooldown_timer > 0) attack_cooldown_timer--;

var _player = instance_find(obj_player, 0);

// Вычисление направления взгляда на игрока
var _facing_dir = (instance_exists(_player) && _player.x < x) ? -1 : 1;

// Фиксация поворота во время всей атаки
if (state == "attack_start" || state == "tongue_out" || state == "pulling") {
    image_xscale = _facing_dir;
}

switch (state) {
    case "idle":
        idle_timer--;
        if (idle_timer <= 0) {
            is_stepping = !is_stepping;
            idle_timer = irandom_range(60, 150);
			image_speed = 1;
            
            if (is_stepping && random(100) < 40) {
                image_xscale = choose(1, -1);
            }
        }
        
        if (is_stepping) {
	        sprite_index = sp_enemy_frog_idle_2;
	    } else {
	        sprite_index = sp_enemy_frog_idle_1;
	    }
        
        if (instance_exists(_player) && attack_cooldown_timer <= 0) {
            if (point_distance(x, y, _player.x, _player.y) <= attack_range) {
                state = "attack_start";
                sprite_index = sp_enemy_frog_fight;
                image_index = 0;
                image_speed = 1;
                image_xscale = _facing_dir;
            }
        }
        break;
        
    case "attack_start":
        if (floor(image_index) >= 9) {
            image_speed = 0;
            image_index = 9;
            
            state = "tongue_out";
            
            var _mouth_x = x + (image_xscale * 12);
            var _mouth_y = y - 8;
            
            tongue_inst = instance_create_layer(_mouth_x, _mouth_y, "Instances", obj_frog_tongue);
            tongue_inst.owner = id;
        }
        break;
        
    case "tongue_out":
    case "pulling":
        image_speed = 0;
        image_index = 9;
        break;
        
    case "finish_attack":
        image_speed = 1;
        if (floor(image_index) >= image_number - 1) {
            state = "idle";
            attack_cooldown_timer = attack_cooldown_duration;
            
            // топтание
            is_stepping = true;
            sprite_index = sp_enemy_frog_idle_2;
            image_index = 0;
            image_speed = 2; // Ускорение в 2 раза
            idle_timer = irandom_range(60, 100); // Длительность ускоренного топтания
        }
        break;
}