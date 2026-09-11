// 1. ЕСЛИ ПУЛЯ УЖЕ ВЗРЫВАЕТСЯ (проверяем правильный спрайт)
if (sprite_index == sp_ballet_repa_boom) {
    speed = 0;
    vspeed = 0;
    if (image_index >= image_number - 1) {
        instance_destroy();
    }
    exit; // Выходим из скрипта, чтобы взрывающаяся пуля больше ничего не делала
}

if (is_exploding) exit;

// 2. ФАЗА ВЗЛЕТА ВВЕРХ
if (!is_flying) {
    if (y <= start_y - 64) {
        vspeed = 0;
        is_flying = true;
    }
} 
// 3. ФАЗА НАВЕДЕНИЯ И ПОЛЕТА В ИГРОКА
else {
    if (instance_exists(obj_player)) {
        target_angle = point_direction(x, y, obj_player.x, obj_player.y);
        image_angle += angle_difference(target_angle, image_angle) * 0.1;
    }
    
    direction = image_angle;
    speed = 4;
}

// 4. ПРОВЕРКА СТОЛКНОВЕНИЯ С ТАЙЛАМИ ИЛИ ИГРОКОМ
if (place_meeting(x, y, global.tilemap) || place_meeting(x, y, obj_player)) {
    speed = 0;
    vspeed = 0;
    sprite_index = sp_ballet_repa_boom; // Заменили sp_bullet_explosion на твой sp_ballet_repa_boom
    image_index = 0;
    image_speed = 1;
}