event_inherited();

if (state == "fly") {
    sprite_index = spr_fly;
    
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
        speed = 0;
        
        if (spr_hit != noone && sprite_exists(spr_hit)) {
            state = "hit";
            sprite_index = spr_hit;
            image_index = 0;
            image_speed = 1;
            
            // Сбрасываем масштабы
            image_xscale = 1;
            image_yscale = 1;
            
            // Ориентируем спрайт отскока от пола относительно стены
            if (fly_dir == "down") {
                image_angle = 0;   // Летит вниз -> ударяется о пол (стандартное положение)
            } else if (fly_dir == "left") {
                image_angle = -90; // Летит влево -> поворачиваем "пол" на -90 градусов к левой стене
            } else if (fly_dir == "right") {
                image_angle = 90;  // Летит вправо -> поворачиваем "пол" на 90 градусов к правой стене
            }
        } 
        else {
            state = "pop";
            sprite_index = spr_pop;
            image_index = 0;
            image_speed = 1;
            
            image_xscale = 1;
            image_yscale = 1;
            
            if (fly_dir == "down") {
                image_angle = 0;
            } else if (fly_dir == "left") {
                image_angle = -90;
            } else if (fly_dir == "right") {
                image_angle = 90;
            }
        }
    }
}