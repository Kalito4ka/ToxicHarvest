if (!instance_exists(owner) || owner.is_dying) {
    var _player = instance_find(obj_player, 0);
    if (instance_exists(_player) && _player.is_grabbed) {
        _player.is_grabbed = false;
    }
    instance_destroy();
    exit;
}

// Привязываем основание языка ко рту лягушки
x = owner.x;
y = owner.y - 8;

var _player = instance_find(obj_player, 0);

switch (state) {
    case "extending":
        if (instance_exists(_player)) {
            var _dir = point_direction(x, y, _player.x, _player.y - 10);
            
            var _next_target_x = target_x + lengthdir_x(reach_speed, _dir);
            var _next_target_y = target_y + lengthdir_y(reach_speed, _dir);
            
            // Проверка столкновения кончика языка со стенами
            if (position_meeting(_next_target_x, _next_target_y, global.tilemap) || position_meeting(_next_target_x, _next_target_y, obj_barrier_player)) {
                state = "retracting";
            } 
            else {
                target_x = _next_target_x;
                target_y = _next_target_y;
                
                // Захват игрока
                if (!global.is_dead && (position_meeting(target_x, target_y, _player) || point_distance(target_x, target_y, _player.x, _player.y - 10) < 16)) {
                    state = "pulling";
                    owner.state = "pulling";
                    _player.is_grabbed = true;
                }
                
                if (point_distance(x, y, target_x, target_y) >= max_length) {
                    state = "retracting";
                }
            }
        } else {
            state = "retracting";
        }
        break;
        
    case "pulling":
        if (instance_exists(_player) && _player.is_grabbed) {
            var _dir_to_mouth = point_direction(target_x, target_y, x, y);
            
            var _pull_hspd = lengthdir_x(pull_speed, _dir_to_mouth);
            var _pull_vspd = lengthdir_y(pull_speed, _dir_to_mouth);
            
            // ВЫЗОВ ФУНКЦИИ В КОНТЕКСТЕ ИГРОКА
            var _collisions = [];
            with (_player) {
                _collisions = move_and_collide(_pull_hspd, _pull_vspd, [global.tilemap, obj_barrier_player]);
            }
            
            target_x = _player.x;
            target_y = _player.y - 10;
            
            // если игрок при притягивании упёрся в стену
            if (array_length(_collisions) > 0) {
                _player.is_grabbed = false;
                _player.escape_presses = 0;
                
                if (_player.invincible_timer <= 0 && !global.is_dead) {
					//закоментила урон игроку, не знаю будет или не будет
					//global.player_lives -= owner.damage_to_player;
                    //_player.invincible_timer = _player.invincible_duration;
                    
                    _player.vspd = -3.5;
                    _player.hspd = (x > _player.x) ? -4 : 4; 
                }
                
                state = "retracting";
            } 
            // Если игрок дотянут до лягушки
            else if (point_distance(x, y, target_x, target_y) <= 16) {
                _player.is_grabbed = false;
                _player.escape_presses = 0;
                
                if (_player.invincible_timer <= 0 && !global.is_dead) {
                    global.player_lives -= owner.damage_to_player;
                    _player.invincible_timer = _player.invincible_duration;
					//звук для игрока
					audio_play_sound(snd_player_damage, 8, false);
                    
                    _player.vspd = -3.5;
                    _player.hspd = (_player.x < x) ? -4 : 4;
                }
                
                owner.state = "finish_attack";
                instance_destroy();
            }
        } else {
            state = "retracting";
        }
        break;
        
    case "retracting":
        if (instance_exists(_player) && _player.is_grabbed) {
            _player.is_grabbed = false;
            _player.escape_presses = 0;
        }
        
        var _dir_to_mouth = point_direction(target_x, target_y, x, y);
        target_x += lengthdir_x(reach_speed, _dir_to_mouth);
        target_y += lengthdir_y(reach_speed, _dir_to_mouth);
        
        if (point_distance(x, y, target_x, target_y) <= reach_speed) {
            if (instance_exists(owner)) {
                owner.state = "finish_attack";
            }
            instance_destroy();
        }
        break;
}