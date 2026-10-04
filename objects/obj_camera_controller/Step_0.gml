// Плавное изменение размера камеры
var _current_w = camera_get_view_width(view_camera[0]);
var _current_h = camera_get_view_height(view_camera[0]);

var _new_w = lerp(_current_w, target_cam_w, zoom_speed);
var _new_h = lerp(_current_h, target_cam_h, zoom_speed);

camera_set_view_size(view_camera[0], _new_w, _new_h);

// Вычисление базовой позиции
var _target_x = x;
var _target_y = y;

// Приоритет слежки: если есть цыплёнок в режиме обнимашек — следим за ним, иначе за игроком
var _follow_target = noone;

if (instance_exists(obj_chick) && (obj_chick.state == "hugging" || obj_chick.state == "wait_finish")) {
    _follow_target = obj_chick;
} else if (instance_exists(obj_player)) {
    _follow_target = obj_player;
}

if (_follow_target != noone) {
    // Центрируем камеру относительно текущей цели
    _target_x = _follow_target.x - (_new_w / 2);
    _target_y = _follow_target.y - (_new_h / 2);
    
    // Ограничиваем камеру границами комнаты
    _target_x = clamp(_target_x, 0, room_width - _new_w);
    _target_y = clamp(_target_y, 0, room_height - _new_h);
} else {
    _target_x = camera_get_view_x(view_camera[0]);
    _target_y = camera_get_view_y(view_camera[0]);
}

// Рассчитываем оффсет тряски
var _shake_offset_x = 0;
var _shake_offset_y = 0;

if (global.shake_amount > 0) {
    _shake_offset_x = random_range(-global.shake_amount, global.shake_amount);
    _shake_offset_y = random_range(-global.shake_amount, global.shake_amount);
    
    global.shake_amount = lerp(global.shake_amount, 0, 0.1);
    if (global.shake_amount < 0.1) global.shake_amount = 0;
}

// Обновляем положение камеры 
camera_set_view_pos(view_camera[0], _target_x + _shake_offset_x, _target_y + _shake_offset_y);