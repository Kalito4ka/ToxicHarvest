var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (_gui_w == 0) {
    _gui_w = window_get_width();
    _gui_h = window_get_height();
}

draw_set_color(c_black);
draw_set_alpha(1);
draw_rectangle(0, 0, _gui_w, _gui_h, false);

draw_sprite_ext(sp_history, current_frame, _gui_w / 2, _gui_h / 2, 1, 1, 0, c_white, 1);

if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(-10, -10, _gui_w + 10, _gui_h + 10, false);
}

draw_set_alpha(1);
draw_set_color(c_white);