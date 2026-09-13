// Вычисляем базвую позицию, где камера должна находиться (центр на игроке)
var _target_x = x;
var _target_y = y;

if (instance_exists(obj_player)) {
    var _cam_w = camera_get_view_width(view_camera[0]);
    var _cam_h = camera_get_view_height(view_camera[0]);
    
    // Центрируем камеру относительно игрока
    _target_x = obj_player.x - (_cam_w / 2);
    _target_y = obj_player.y - (_cam_h / 2);
    
    // Ограничиваем камеру границами комнаты
    _target_x = clamp(_target_x, 0, room_width - _cam_w);
    _target_y = clamp(_target_y, 0, room_height - _cam_h);
} else {
    _target_x = camera_get_view_x(view_camera[0]);
    _target_y = camera_get_view_y(view_camera[0]);
}

// Рассчитываем оффсет тряски (если есть тряска)
var _shake_offset_x = 0;
var _shake_offset_y = 0;

if (global.shake_amount > 0) {
    _shake_offset_x = random_range(-global.shake_amount, global.shake_amount);
    _shake_offset_y = random_range(-global.shake_amount, global.shake_amount);
    
    // Постепенно гасим тряску
    global.shake_amount = lerp(global.shake_amount, 0, 0.1);
    
    if (global.shake_amount < 0.1) global.shake_amount = 0;
}

// Обновляем положение камеры ВСЕГДА (базовая позиция + тряска)
camera_set_view_pos(view_camera[0], _target_x + _shake_offset_x, _target_y + _shake_offset_y);