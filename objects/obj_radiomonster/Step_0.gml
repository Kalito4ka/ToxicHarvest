// Уменьшаем КД урона
if (hit_cooldown > 0) {
    hit_cooldown--;
}

switch (state) {

    case "sleep":
        sprite_index = spr_idle;
        image_xscale = facing * boss_scale;
        
        if (instance_exists(obj_player)) {
            var _dist = point_distance(x, y, obj_player.x, obj_player.y);
            if (_dist <= sight_distance) {
                state = "scream";
                sprite_index = spr_scream;
                image_index = 0;
                image_speed = 1;
            }
        }
        break;

    case "wait":
        sprite_index = spr_idle;
        
        if (instance_exists(obj_player)) {
            facing = (obj_player.x >= x) ? 1 : -1;
        }
        image_xscale = facing * boss_scale;
        
        state_timer--;
        if (state_timer <= 0) {
            state = "scream";
            sprite_index = spr_scream;
            image_index = 0;
            image_speed = 1;
			
			has_played_roar = false;
        }
        break;

    case "scream":
        sprite_index = spr_scream;
        
        if (instance_exists(obj_player)) {
            facing = (obj_player.x >= x) ? 1 : -1;
        }
        image_xscale = facing * boss_scale;
        break;

    case "attack":
        sprite_index = spr_attack;
        image_xscale = facing * boss_scale;
        
        var _current_frame = floor(image_index);
        
        // 1 удар 0-2 кадр
        if (_current_frame >= 0 && _current_frame <= 2) {
            if (!moved_phase1) {
                target_x = x + (facing * 3 * block_size);
                moved_phase1 = true;
            }
            //тряска земли
            if (_current_frame == 2 && global.shake_amount < 8) {
                global.shake_amount = 8;
            }
        } 
        // 2 удар 10-12 кадр
        else if (_current_frame >= 10 && _current_frame <= 12) {
            if (!moved_phase2) {
                target_x = x + (facing * 2 * block_size);
                moved_phase2 = true;
            }
            
            // тряска земли
            if (_current_frame == 12 && global.shake_amount < 6) {
                global.shake_amount = 6;
            }
        }
        
        // плавное движение к цели
        if (x != target_x) {
            var _move_spd = 3;
            var _next_x = approach(x, target_x, _move_spd);
            
            // Проверка стены
            if (!place_meeting(_next_x, y, global.tilemap)) {
                x = _next_x;
            } else {
                var _dir = sign(target_x - x);
                while (!place_meeting(x + _dir, y, global.tilemap)) {
                    x += _dir;
                }
                target_x = x;
            }
        }
        break;

    case "damage":
        sprite_index = spr_damage;
        image_xscale = facing * boss_scale;
        
        // Отлёт к задней стене
        var _back_dir = -facing; 
        
        if (!place_meeting(x + (_back_dir * knockback_spd), y, global.tilemap)) {
            x += _back_dir * knockback_spd;
        } else {
            while (!place_meeting(x + _back_dir, y, global.tilemap)) {
                x += _back_dir;
            }
            
            state = "wait";
            state_timer = game_get_speed(gamespeed_fps) * 1;
            sprite_index = spr_idle;
			has_played_damage = false;
        }
        break;

    case "dead":
        sprite_index = spr_died;
        image_xscale = facing * boss_scale;
        speed = 0;
		stop_boss_music(1500);
        break;
}