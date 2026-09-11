if (!is_active) {
    if (instance_exists(obj_player)) {
        if (point_distance(x, y, obj_player.x, obj_player.y) <= activation_range) {
            is_active = true;
        }
    }
    exit;
}
event_inherited();
vspd += grv;
if (vspd > 8) vspd = 8;

if (!is_jumping){
    jump_timer -= 1;
    
    if (jump_timer <= 0){
		// проверка можно прыгать или нет
        var _dir = choose(-1, 1);
        var _jump_dist = 64;
		
		//проверка на границы комнаты
		var _slime_buffer = (bbox_right - bbox_left) / 2;
        
		if (_dir == -1 && x + (_dir * _jump_dist) <= _slime_buffer) {
            _dir = 1;
		}
		else if (_dir == 1 && x + (_dir * _jump_dist) >= room_width - _slime_buffer) {
            _dir = -1;
		}
		
        var _target_x = x + (_dir * _jump_dist);
        
        var _check_y = y; 
        
        var _can_jump = false;
        var _scanning = true;
        
        var _max_drop_height = y + (16 * 7); 

        while (_scanning && _check_y <= _max_drop_height) {
            
			//барьеры
			if (place_meeting(_target_x, _check_y, obj_barrier_monsters)) {
		        _can_jump = false;
		        _scanning = false;
		    }
            // опасный блок
            else if (place_meeting(_target_x, _check_y, obj_dangerous_block)) {
			    _can_jump = false;
			    _scanning = false;
			}
            // блок земли
            else if (tilemap_get_at_pixel(global.tilemap, _target_x, _check_y) != 0) {
                _can_jump = true;
                _scanning = false;
            }
            else {
                _check_y += 16; 
            }
        }
        
        if (_can_jump){
            hspd = _dir * 2;
            vspd = -6; 
            is_jumping = true;
            image_xscale = _dir;
        } else {
            jump_timer = 30; 
        }
    }
}

var _x_before = x;
var _y_before = y;

var _collisions = move_and_collide(hspd, vspd, global.tilemap);

if (array_length(_collisions) > 0) {
    
    if (vspd >= 0 && place_meeting(x, y + 1, global.tilemap)) {
        vspd = 0;
        if (is_jumping) {
            hspd = 0;
            is_jumping = false;
            jump_timer = irandom_range(90, 180);
        }
    }
    
    if (hspd != 0 && place_meeting(x + sign(hspd), y, global.tilemap)) {
        hspd = -hspd;
        image_xscale = sign(hspd);
    }
}