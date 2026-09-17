// для лягушки
if (is_grabbed) {
    hspd = 0;
    vspd = 0;
    // Страховка: если игрок каким-то образом всё же оказался внутри стены
    if (place_meeting(x, y, global.tilemap)) {
        is_grabbed = false;
        // Выталкивание наверх
        while (place_meeting(x, y, global.tilemap)) {
            y--;
        }
    }
    // Освобождение по 3 нажатиям на W
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        escape_presses++;
        
        if (escape_presses >= 3) {
            is_grabbed = false;
            escape_presses = 0;
            
            // Находим язык и заставляем его втягиваться назад без игрока
            var _tongue = instance_find(obj_frog_tongue, 0);
            if (instance_exists(_tongue)) {
                _tongue.state = "retracting";
            }
        }
    }
    
    exit; // Запрещаем обычное управление, пока игрок схвачен
} else {
    escape_presses = 0;
}

var _w_pressed = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
var _w_held = keyboard_check(ord("W")) || keyboard_check(vk_up);
var _a = keyboard_check(ord("A")) || keyboard_check(vk_left);
var _s = keyboard_check(ord("S")) || keyboard_check(vk_down);
var _d = keyboard_check(ord("D")) || keyboard_check(vk_right);
var _shift = keyboard_check(vk_shift);

var _on_tile = place_meeting(x, y + 1, global.tilemap);
var _on_platform = false;

//проверка на платформу
var _platform_check = instance_place(x, y + max(1, vspd + 1), obj_moving_platform_parent);
if (_platform_check != noone && vspd >= 0) {
    // Игрок считается стоящим на платформе, только если его ноги выше крыши платформы
    if (bbox_bottom <= _platform_check.bbox_top + vspd + 2) {
        _on_platform = true;
    }
}
var _on_ground = _on_tile || _on_platform;
var _move_direction = _d - _a;

//неуязвимость
if (invincible_timer > 0){
	invincible_timer -= 1;
}

//смерть
if (global.player_lives <= 0 && !global.is_dead){
	global.player_lives = 0;
	global.is_dead = true;
	depth = -9999;
	alarm[0] = 120;
}

if (global.is_dead){
	hspd = lerp(hspd, 0, 0.05);
	
	vspd += gravity_force;
	
	x += hspd;
	y += vspd;
	
	image_angle += 5 * -image_xscale;
} 
// Жизнь
else {

	if (_move_direction != 0) {
		dash_direction_x = _move_direction;
	}
	// перезарядка рывка
	if (dash_cooldown_timer > 0) {
		dash_cooldown_timer -= 1;
	}
	
	// отскок от удара
	if (invincible_timer > 45) {
		hspd = lerp(hspd, 0, 0.12);
		if (!_on_ground) {
            vspd += gravity_force;
        }
	} else {
		
		// инициация рывка
		if (_shift && dash_timer <= 0 && dash_cooldown_timer <= 0){
			dash_timer = dash_duration;
			dash_cooldown_timer = dash_cooldown;
			vspd = 0;
			image_index = 0;
		}
		// движения и физика
		if (dash_timer > 0) {
			 dash_timer -= 1;
			 hspd = dash_direction_x*dash_speed;
			 vspd = 0;
		} else {	
			
			player_handle_attacks(_on_ground);
			
			var _is_attacking_ground = (sprite_index == sp_player_fight_1 || sprite_index == sp_player_fight_3);

            if (jump_prep_timer > 0) {
                jump_prep_timer -= 1;
                hspd = 0;
        
                if (jump_prep_timer == 0) {
                    vspd = jump_height; // Задаем импульс прыжка (vspd становится отрицательным)
                    coyote_timer = 0;
                }
            } else if (!_is_attacking_ground) {
                if (_move_direction != 0){
                    hspd += _move_direction * accel;
                    hspd = clamp(hspd, -move_speed_walk, move_speed_walk);
                } else {
                    if (hspd > 0) hspd = max(0, hspd - friction_force);
                    if (hspd < 0) hspd = min(0, hspd + friction_force);
                }
            } else {
                hspd = 0; // Во время атаки на земле не двигаемся влево/вправо
            }
	
			//управление таймером койота
			if (_on_ground){
				coyote_timer = coyote_max;
				if (vspd >= 0) {
					vspd = 0;
				}
			} else {
				if (coyote_timer > 0) coyote_timer -= 1;
				//гравитация не работает во время мега атаки
				if (sprite_index == sp_player_fight_2){
					vspd = 0;
					hspd = _move_direction * 1;
				} else {
					vspd += gravity_force;
				}
			}
	
			//прыжок с подготовкой
			if (_w_pressed && coyote_timer > 0 && jump_prep_timer <= 0) {
				jump_prep_timer = 6;
				land_timer = 0;
			}
	
			//высота прыжка
			if (vspd < 0 && !_w_held){
				vspd = max(vspd, jump_height/3);
			}
		}
	}

	// Притягиваем персонажа к платформе ТОЛЬКО если он не прыгает вверх (vspd >= 0)
    if (_on_platform && _platform_check != noone && vspd >= 0 && jump_prep_timer <= 0) {
        y = _platform_check.bbox_top - (bbox_bottom - y);
        vspd = 0;
    } else if (_on_tile) {
        if (vspd >= 0) {
            vspd = 0;
            y = round(y); 
        }
    }

    var _final_hspd = round(hspd);
    var _final_vspd = round(vspd);

    if (_move_direction != 0 && sprite_index != sp_player_fight_1 && sprite_index != sp_player_fight_3){
        image_xscale = _move_direction;
    }
    
    // Передаем платформу в массив столкновений move_and_collide
    var _collision_targets = [global.tilemap, obj_barrier_player];
    
    // Добавляем платформу в коллизии только когда падем на нее сверху
    if (vspd >= 0 && _platform_check != noone && bbox_bottom <= _platform_check.bbox_top + 4) {
        array_push(_collision_targets, obj_moving_platform_parent);
    }

	move_and_collide(_final_hspd, _final_vspd, _collision_targets);
	
	// управление анимациями
	// анимации атаки
	if (sprite_index == sp_player_fight_3) {
		
	    image_speed = 1;
		hspd = 0;
    
	    if (image_index == 4 && instance_number(obj_player_boomerang) == 0 && ult_damage_current >= ult_damage_required) {
	        ult_damage_current = 0; 
	        var _boomerang = instance_create_layer(x, y - 8, "Instances", obj_player_boomerang);
	        _boomerang.parent_player = id;
	    }
    
	    if (image_index >= image_number - 1) {
	        sprite_index = _on_ground ? sp_player_stand : sp_player_jump;
	    }
	}
	else if (sprite_index == sp_player_fight_2 && !_on_ground){
		image_speed = 1;
		
		//хитбокс атаки
		if (floor(image_index) == 3 && instance_number(obj_player_fight_2) == 0) {
            var _heavy_strike = instance_create_layer(x + (image_xscale * 15), y - 4, "Instances", obj_player_fight_2);
            _heavy_strike.image_xscale = image_xscale;
            _heavy_strike.image_yscale = 1.5;
			var _air_chance = random(100);
	        if (_air_chance < 10) {
	            _heavy_strike.damage = 10;
			} else {
	            _heavy_strike.damage = 7;
	        }
        }
		
        if (image_index >= image_number - 2) {
            sprite_index = sp_player_jump;
		}
	}
	else if (sprite_index == sp_player_fight_1 || sprite_index == sp_player_fight_2){
		image_speed = 1;
		hspd = 0;
		
		if (sprite_index == sp_player_fight_1 && floor(image_index) == 3 && instance_number(obj_player_fight_1) == 0) {
            var _strike = instance_create_layer(x + (image_xscale * 10), y, "Instances", obj_player_fight_1);
            _strike.image_xscale = image_xscale;
        }
        
        if (sprite_index == sp_player_fight_2 && floor(image_index) == 3 && instance_number(obj_player_fight_2) == 0) {
            var _heavy_strike = instance_create_layer(x + (image_xscale * 15), y, "Instances", obj_player_fight_2);
            _heavy_strike.image_xscale = image_xscale;
            _heavy_strike.image_yscale = 1.5;
        }
	} // остальные анимации
	else {
		if (dash_timer > 0) {
			sprite_index = sp_player_dash;
			land_timer = 7;
			jump_air_index = 3;
		}
		else if (!_on_ground) {
		    sprite_index = sp_player_jump;
		    image_speed = 0;
		    land_timer = 7;
    
		    if (vspd < 0) {
		        jump_air_index += 0.2; 
		        jump_air_index = clamp(jump_air_index, 3, 7); 
		        image_index = floor(jump_air_index);
		    } else {
		        jump_air_index = 3;
        
		        if (vspd < 2) image_index = 8;
		        else if (vspd < 4) image_index = 9;
		        else if (vspd < 6) image_index = 10;
		        else image_index = 11;
		    }
		} else {
		    jump_air_index = 3;
    
		    if (jump_prep_timer > 0){
		        sprite_index = sp_player_jump;
		        image_speed = 0;
		        if (jump_prep_timer > 4) image_index = 0;
		        else if (jump_prep_timer > 2) image_index = 1;
		        else image_index = 2;
		    } else if (land_timer > 0){
		        sprite_index = sp_player_jump;
		        image_speed = 0;
		        land_timer -= 1;
        
		        if (land_timer > 5) image_index = 12;
                else if (land_timer > 3) image_index = 13;
                else if (land_timer > 1) image_index = 14;
                else image_index = 15;
		    } else {
		        image_speed = 1;
		        if (hspd != 0) {
		            sprite_index = sp_player_walk;
		        } else {
		            sprite_index = sp_player_stand;
		        }
		    }
		}
	}
}
