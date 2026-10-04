var _is_open = obj_game_manager.level_open[level_number];

if (_is_open) {
    draw_self();
    
    var _stars_got = obj_game_manager.level_stars[level_number];
    
    if (_stars_got > 0) {
        var _radius = 70;
        var _rot_speed = 1.5;
        
        var _base_angle = (current_time * 0.05) * _rot_speed;
        var _angle_step = 360 / _stars_got;
        
        var _wave_speed = 0.007;
        var _wave_range = 5;
        
        // Спрайты для 10 уровня
        var _lvl10_sprites = [sp_player_stand, sp_heart, sp_chik_idle];
        
        for (var i = 0; i < _stars_got; i++) {
            var _current_angle = _base_angle + (i * _angle_step);
            
            var _star_x = x + lengthdir_x(_radius, _current_angle);
            var _star_y = y + lengthdir_y(_radius, _current_angle);
            
            var _wave = sin((current_time * _wave_speed) + (i * 2)) * _wave_range;
            _star_y += _wave;
            
            var _sprite_to_draw = sp_star;
            if (level_number == 10) {
                _sprite_to_draw = _lvl10_sprites[i % array_length(_lvl10_sprites)];
            }
            
            draw_sprite_ext(_sprite_to_draw, 0, _star_x, _star_y, 3, 3, 0, c_white, 1);
        }
    }
} else {
    draw_sprite(sp_button_locked, 0, x, y);
    
    // Определяем требуемое количество звезд для заблокированного уровня
    var _required_stars = 0;
    switch (level_number) {
        case 5:
            _required_stars = 12;
            break;
            
        case 8:
            _required_stars = 21;
            break;
            
        case 10:
            _required_stars = 27;
            break;
    }
    
    // Если требование по звездам задано — выводим плашку под кнопкой
    if (_required_stars > 0) {
        draw_set_color(c_yellow);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        
        draw_text(x+2, y + 30, string(global.total_stars_collected) + " / " + string(_required_stars) + " ★");
        
        draw_set_color(c_white);
        draw_set_halign(fa_left);
    }
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);