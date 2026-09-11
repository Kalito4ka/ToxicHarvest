event_inherited();

if (is_dying) exit;

if (invulnerable) {
	invulnerable_timer--;
	//переливание каждые пять кадров
	if (invulnerable_timer mod 5 == 0) {
        flash_red = !flash_red;
    }
	
	if (invulnerable_timer <= 0) {
        invulnerable = false;
        flash_red = false;
        sprite_index = sp_repa_walk;
    }
}

// Обработка состояний
switch (state){
	case "walk":
		sprite_index = sp_repa_walk;
        image_speed = 1;
        hspd = move_dir * walk_spd;
		
		if (place_meeting(x + hspd, y, obj_wall)) {
            move_dir *= -1;
            hspd = move_dir * walk_spd;
        }
		
		// Проверка обнаружения игрока (в поле зрения по оси Y и на расстоянии)
        if (instance_exists(obj_player)) {
            var _dist = distance_to_object(obj_player);
            // Если игрок рядом и репа смотрит в его сторону
            if (_dist < 200 && sign(obj_player.x - x) == move_dir) {
                state = "agitated";
                state_timer = room_speed * 3; // 3 секунды (180 кадров при 60 FPS)
            }
        }
        break;
		
	case "agitated":
        hspd = 0;
        sprite_index = sp_repa_walk;
        image_speed = 3; // Ускорение анимации в 3 раза
        
        state_timer--;
        if (state_timer <= 0) {
            state = "charge";
        }
        break;
        
    case "charge":
        sprite_index = sp_repa_walk;
        image_speed = 3;
        hspd = move_dir * charge_spd;
        
        // Врезание в стену или игрока
        if (place_meeting(x + hspd, y, obj_wall) || place_meeting(x + hspd, y, obj_player)) {
            state = "bounce";
            state_timer = 15; // Длительность отскока в кадрах
            move_dir *= -1;   // Меняем направление на противоположное
        }
        break;
        
    case "bounce":
        sprite_index = sp_repa_default;
        image_speed = 1;
        hspd = move_dir * (charge_spd * 0.7); // Отскок назад
        
        state_timer--;
        if (state_timer <= 0) {
            state = "walk";
        }
        break;
        
    case "dead":
        hspd = 0;
        vspd = 0;
        state_timer--;
        
        // Смещение спрайта влево-вправо для эффекта тряски
        shake_offset = choose(-2, 2);
        
        if (state_timer <= 0) {
            // Переход ко второму спрайту смерти и уничтожение
            sprite_index = sp_repa_died_2;
            instance_destroy();
        }
        break;
}

if (state != "dead") {
    if (!place_meeting(x + hspd, y, obj_wall)) {
        x += hspd;
    }
}

if (hspd != 0) {
    image_xscale = sign(hspd);
}

if (hp <= 0 && state != "dead") {
    state = "dead";
    sprite_index = sp_repa_died_1;
    state_timer = room_speed * 1; // Тряска длится 1 секунду
}