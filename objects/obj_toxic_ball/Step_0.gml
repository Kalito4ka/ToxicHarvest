event_inherited();

if (audio_emitter_exists(sfx_emitter)) {
    audio_emitter_position(sfx_emitter, x, y, 0);
}

//анимация взрыва
if (state != "pop" && place_meeting(x, y, obj_player)) {
    speed = 0;
    state = "pop";
    
    if (spr_pop != noone && sprite_exists(spr_pop)) {
        sprite_index = spr_pop;
        image_index = 0;
        image_speed = 1;
    } else {
        instance_destroy();
    }
}

if (state == "fly") {
    sprite_index = spr_fly;
    
    if (fly_dir == "down") {
        direction = 270;
        image_angle = 270;
    } 
    else if (fly_dir == "left") {
        direction = 180;
        image_angle = 180;
    } 
    else if (fly_dir == "right") {
        direction = 0;
        image_angle = 0;
    }
    
    speed = move_spd;
    
    var _hit_wall = false;
    
    if (fly_dir == "down" && place_meeting(x, y + move_spd, global.tilemap)) {
        _hit_wall = true;
    } 
    else if (fly_dir == "left" && place_meeting(x - move_spd, y, global.tilemap)) {
        _hit_wall = true;
    }
    else if (fly_dir == "right" && place_meeting(x + move_spd, y, global.tilemap)) {
        _hit_wall = true;
    }

    if (_hit_wall) {
        var _dx = 0;
        var _dy = 0;
        
        if (fly_dir == "down") _dy = 1;
        else if (fly_dir == "left") _dx = -1;
        else if (fly_dir == "right") _dx = 1;

        while (!place_meeting(x + _dx, y + _dy, global.tilemap)) {
            x += _dx;
            y += _dy;
        }

        speed = 0;
        
        if (spr_hit != noone && sprite_exists(spr_hit)) {
            state = "hit";
            sprite_index = spr_hit;
            image_index = 0;
            image_speed = 1;
            
            image_xscale = 1;
            image_yscale = 1;
            
            if (fly_dir == "down") {
                image_angle = 270;
            } else if (fly_dir == "left") {
                image_angle = 180;
            } else if (fly_dir == "right") {
                image_angle = 0;
            }
        } 
        else {
            state = "pop";
            sprite_index = spr_pop;
            image_index = 0;
            image_speed = 1;
            
            image_xscale = 1;
            image_yscale = 1;
            
            if (fly_dir == "down") image_angle = 270;
            else if (fly_dir == "left") image_angle = 180;
            else if (fly_dir == "right") image_angle = 0;
        }
    }
}
else if (state == "hit" || state == "pop") {
    speed = 0; 
    
    if (fly_dir == "down") image_angle = 270;
    else if (fly_dir == "left") image_angle = 180;
    else if (fly_dir == "right") image_angle = 0;
}