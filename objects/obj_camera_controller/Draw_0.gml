var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);

// отрисовка сердечек
var _start_x = 10;
var _start_y = 10;
var _spacing = 24;

for (var i = 0; i < 5; i++) {
    var _sub_image = 0;
    
    if (i >= global.player_lives){
        _sub_image = 1;
    }
    
    draw_sprite(sp_interface_heart, _sub_image, _cam_x + _start_x + (i*_spacing), _cam_y + _start_y);
}
//накопление ульты
if (instance_exists(obj_player)){
	var _ult_percent = (obj_player.ult_damage_current / obj_player.ult_damage_required)*100;
	_ult_percent = clamp(_ult_percent, 0, 100);
	var _bar_width = 117;
    var _bar_height = 8;
    var _offset_y = 28;
	
	var _x1 = _cam_x + _start_x;
    var _y1 = _cam_y + _start_y + _offset_y;
    var _x2 = _x1 + _bar_width;
    var _y2 = _y1 + _bar_height;
	
	var _border_color = (_ult_percent >= 100) ? c_yellow : $3C3C3C;
	
    // рамка
    draw_set_color(_border_color);
    draw_rectangle(_x1 - 1, _y1 - 1, _x2 + 1, _y2 + 1, false);
    draw_set_color($D5D5D5);
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    
    if (_ult_percent > 0) {
        var _current_x2 = _x1 + (_bar_width * (_ult_percent / 100));
        
        var _col_left, _col_right;
        
		//ульт зол
        if (_ult_percent >= 100) {
            var _pulse = (sin(current_time * 0.01) + 1) / 2;
            
            var _gold_base = make_color_rgb(255, 215, 0);
            var _gold_glow = make_color_rgb(255, 255, 150);
            
            _col_left = merge_color(_gold_base, _gold_glow, _pulse);
            _col_right = merge_color(_gold_glow, _gold_base, _pulse);
        } else {
            _col_left = c_yellow;
            _col_right = c_orange;
        }
        
        draw_rectangle_color(_x1, _y1, _current_x2, _y2, _col_left, _col_right, _col_right, _col_left, false);
    }
}

if (instance_exists(obj_player)) {
    var _star_spacing = 24;
    var _right_margin = 15;
    var _star_y = _cam_y + 15;
    
    var _stars_count = obj_player.stars_found; 
    
    for (var s = 0; s < _stars_count; s++) {
        var _star_x = (_cam_x + _cam_w) - _right_margin - (s * _star_spacing);
        
        draw_sprite(sp_star, 0, _star_x, _star_y);
    }
}