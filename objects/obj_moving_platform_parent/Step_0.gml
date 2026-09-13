var _prev_x = x;
var _prev_y = y;

pos_offset += move_speed * 0.03;

// Рассчитываем смещение по направлению
var _current_offset = sin(pos_offset) * move_distance;
x = start_x + lengthdir_x(_current_offset, move_direction);
y = start_y + lengthdir_y(_current_offset, move_direction);
// фактическая скорость
hspd = x - _prev_x;
vspd = y - _prev_y;

//перенос игрока
if (instance_exists(obj_player)) {
    // Проверяем, стоит ли игрок
    var _player_on_top = place_meeting(x, y - 4, obj_player);
    
    if (_player_on_top) {
        with (obj_player) {
            // Двигаем игрока вместе с платформой
            if (!place_meeting(x + other.hspd, y, global.tilemap)) {
                x += other.hspd;
            }
            if (!place_meeting(x, y + other.vspd, global.tilemap)) {
                y += other.vspd;
            }
        }
    }
}