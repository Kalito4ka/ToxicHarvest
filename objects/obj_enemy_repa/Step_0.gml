if (!is_active) {
    if (instance_exists(obj_player)) {
        if (point_distance(x, y, obj_player.x, obj_player.y) <= activation_range) {
            is_active = true;
        }
    }
    exit;
}

event_inherited();

if (is_dying) exit;

// гравитация
vspd += grv;
if (vspd > 8) vspd = 8;
// Вспомогательная функция старта отскока
var _do_bounce = function() {
    state = "bounce";
	sprite_index = sp_repa_invulnerable;
    move_dir *= -1; // Отлетаем в противоположную бегу сторону
    vspd = -2.5;      // Импульс прыжка вверх
};

// логика состояний
switch (state) {
    
    case "idle":
        // Проверяем игрока
        if (instance_exists(obj_player)) {
            var _dist = point_distance(x, y, obj_player.x, obj_player.y);
            if (_dist <= sight_range && abs(y - obj_player.y) < 32) {
                state = "agitated";
                state_timer = room_speed * 2;
                break;
            }
        }

        //Обычная ходьба
        state_timer--;
        if (state_timer <= 0) {
            is_walking_idle = !is_walking_idle;
            state_timer = room_speed * irandom_range(2, 4);
            if (is_walking_idle) move_dir = choose(-1, 1);
        }

        if (is_walking_idle) {
            sprite_index = sp_repa_walk;
            image_speed = 1;
            hspd = move_dir * walk_spd;

            // Разворот от барьера в idle
            if (place_meeting(x + hspd, y, obj_barrier_monsters)) {
                move_dir *= -1;
                hspd = move_dir * walk_spd;
            }
        } else {
            sprite_index = sp_repa_default;
            image_speed = 1;
            hspd = 0;
        }
        break;
        
    case "agitated":
        hspd = 0;
        sprite_index = sp_repa_walk;
        image_speed = 3;
        
        // Постоянно поворачиваемся к игроку, пока топчемся
        if (instance_exists(obj_player)) {
            var _dir_to_p = sign(obj_player.x - x);
            if (_dir_to_p != 0) move_dir = _dir_to_p;
        }
        
        state_timer--;
        if (state_timer <= 0) {
            state = "charge"; // Старт бега
        }
        break;
        
    case "charge":
        sprite_index = sp_repa_walk;
        image_speed = 3;
        hspd = move_dir * charge_spd;

        // столкновения 
		// со стенами наперед чтобы не застрять
        if (place_meeting(x + hspd, y, obj_barrier_monsters) || place_meeting(x + hspd, y, global.tilemap)) {
	        _do_bounce();
	    }
		
		//с игроком столкновение по факту
		if (place_meeting(x, y, obj_player)) {
	        _do_bounce();
	    }
        break;
        
    case "bounce":
        sprite_index = sp_repa_invulnerable;
        image_speed = 1;
        hspd = move_dir * bounce_spd;
        
        // Приземлились на землю после отлета — уходим в отдых
        if (vspd >= 0 && place_meeting(x, y + 1, global.tilemap)) {
            state = "rest";
            state_timer = room_speed * 2;
        }
        break;
        
    case "rest":
        hspd = 0;
        sprite_index = sp_repa_invulnerable;
        image_speed = 1;
        
        state_timer--;
        if (state_timer <= 0) {
            state = "idle";
            is_walking_idle = false;
            state_timer = room_speed * 2;
        }
        break;
        
    case "dead":
        hspd = 0;
        vspd = 0;
        state_timer--;
        if (state_timer <= 0) {
            sprite_index = sp_repa_died_2;
            instance_destroy();
        }
        break;
}

if (state != "dead") {
    
    // Горизонтальное смещение
    if (!place_meeting(x + hspd, y, global.tilemap)) {
        x += hspd;
    } else {
        // Если уперлись в Тайлы Стены во время бега
        if (state == "charge") {
            _do_bounce();
        } else if (state == "idle") {
            move_dir *= -1;
        } else if (state == "bounce") {
            hspd = 0;
        }
    }

    var _vert_collisions = move_and_collide(0, vspd, global.tilemap);
    if (array_length(_vert_collisions) > 0) {
        if (vspd >= 0 && place_meeting(x, y + 1, global.tilemap)) {
            vspd = 0;
        }
    }
}

// поворот
if (hspd != 0) {
    image_xscale = sign(hspd);
} else if (state == "agitated") {
    image_xscale = move_dir;
}

// смерть
if (hp <= 0 && state != "dead") {
    state = "dead";
    state_timer = room_speed * 1;
}