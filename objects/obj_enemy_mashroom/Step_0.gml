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

var _player = instance_find(obj_player, 0);

switch (state) {
    
    case "idle":
        sprite_index = sp_enemy_mashroom_idle;
        image_speed = 1;
        hspd = 0;
        
        if (instance_exists(_player)) {
            if (_player.x != x) {
                var _dir = (_player.x < x) ? -1 : 1;
                image_xscale = _dir * base_scale;
            }
        }
        
        jump_timer--;
        if (jump_timer <= 0) {
            var _dir = 1;
            if (instance_exists(_player) && point_distance(x, y, _player.x, _player.y) <= activation_range) {
                _dir = (_player.x < x) ? -1 : 1;
            } else {
                _dir = choose(-1, 1);
            }
            
            jump_start_y = y; 
            
            var _jump_blocks = random_range(5, 10);
            vspd = -sqrt(2 * grv * (_jump_blocks * 16)); 
            
            hspd = _dir * random_range(2, 3.5);
            image_xscale = _dir * base_scale;
            
            state = "jumping";
            sprite_index = sp_enemy_mashroom_jump;
            image_index = 0;
            image_speed = 1;
            has_slammed = false;
        }
        break;
        
    case "jumping":
        vspd += grv;
        if (vspd > 10) vspd = 10;
        
        var _height_gained = jump_start_y - y;
        
        if (!has_slammed && _height_gained >= (5 * 16) && instance_exists(_player)) {
            var _x_diff = abs(_player.x - x);
            var _y_diff = _player.y - y;
            
            if (_x_diff <= 12 && _y_diff >= (2 * 16) && _y_diff <= player_detection_range) {
                state = "hang";
                hang_timer = 30;
                hspd = 0;
                vspd = 0;
                
                sprite_index = sp_enemy_mashroom_angry;
                image_index = 0;
                image_speed = 0;
                has_slammed = true;
            }
        }
        break;
        
    case "hang":
        hspd = 0;
        vspd = 0;
        sprite_index = sp_enemy_mashroom_angry;
        image_index = 0;
        image_speed = 0;
        
        hang_timer--;
        if (hang_timer <= 0) {
            state = "slamming";
            vspd = 12;
        }
        break;
        
    case "slamming":
        vspd += grv * 2;
        if (vspd > 14) vspd = 14;
        
        sprite_index = sp_enemy_mashroom_angry;
        image_index = 0;
        image_speed = 0;
        break;
        
    case "landed_delay":
        hspd = 0;
        vspd = 0;
        sprite_index = sp_enemy_mashroom_angry;
        image_speed = 1;
        
        if (floor(image_index) >= image_number - 1) {
            state = "idle";
            sprite_index = sp_enemy_mashroom_idle;
            image_index = 0;
            jump_timer = irandom_range(120, 180);
        }
        break;
}

// Движение по X 
if (hspd != 0) {
    if (place_meeting(x + hspd, y, global.tilemap)) {
        while (!place_meeting(x + sign(hspd), y, global.tilemap)) {
            x += sign(hspd);
        }
        hspd = -hspd;
        image_xscale = sign(hspd) * base_scale;
    } else {
        x += hspd;
    }
}

// Движение по Y
if (vspd != 0) {
    if (place_meeting(x, y + vspd, global.tilemap)) {
        while (!place_meeting(x, y + sign(vspd), global.tilemap)) {
            y += sign(vspd);
        }
        
        if (vspd > 0) {
            vspd = 0;
            
            if (state == "jumping") {
                hspd = 0;
                state = "idle";
                sprite_index = sp_enemy_mashroom_idle;
                jump_timer = irandom_range(120, 180);
            }
            else if (state == "slamming") {
                hspd = 0;
                global.shake_amount = 8;
                
                state = "landed_delay";
                sprite_index = sp_enemy_mashroom_angry;
                image_index = 0;
                image_speed = 1;
            }
        } else {
            vspd = 0;
        }
    } else {
        y += vspd;
    }
}