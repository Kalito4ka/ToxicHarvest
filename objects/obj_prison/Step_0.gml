// тряска 
if (shake_timer > 0) {
    shake_timer--;
    shake_offset_x = choose(-1, 1);
    if (shake_timer <= 0) {
        shake_offset_x = 0;
        if (state == "help") {
            state = "idle";
            sprite_index = spr_idle;
        }
    }
} else {
    shake_offset_x = 0;
}

// проверка смерти и игрока рядом
if (!is_dropped && instance_exists(obj_radiomonster) == false && instance_exists(obj_player)) {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);
    if (_dist <= 5 * block_size) {
        is_dropped = true;
        state = "falling";
        shake_timer = 180;
    }
}

// падение вниз
if (state == "falling" && shake_timer <= 0) {
    var _fall_spd = 6;
    if (!place_meeting(x, y + _fall_spd, global.tilemap)) {
        y += _fall_spd;
    } else {
        while (!place_meeting(x, y + 1, global.tilemap)) {
            y += 1;
        }
        state = "grounded";
    }
}

// открытие клетки и спавн ципленка
if (state == "grounded") {
    var _hit = instance_place(x, y, obj_player_weapon_parent);
    if (_hit != noone) {
        state = "opened";
        sprite_index = spr_freedom;
        shake_timer = 60;
        
        var _chick = instance_create_layer(x, y, "Instances", obj_chick);
    }
}