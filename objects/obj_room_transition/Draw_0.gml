if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    
    var _cam = view_camera[0];
    var _cam_x = camera_get_view_x(_cam);
    var _cam_y = camera_get_view_y(_cam);
    var _cam_w = camera_get_view_width(_cam);
    var _cam_h = camera_get_view_height(_cam);
    
    var _margin = 2000; 
    
    if (_cam_w > 0) {
        draw_rectangle(_cam_x - _margin, _cam_y - _margin, _cam_x + _cam_w + _margin, _cam_y + _cam_h + _margin, false);
    } else {
        draw_rectangle(-_margin, -_margin, room_width + _margin, room_height + _margin, false);
    }
    
    draw_set_alpha(1);
    draw_set_color(c_white);
}