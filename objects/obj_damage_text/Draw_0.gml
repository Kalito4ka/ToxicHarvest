draw_set_font(fnt_damage);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _text_color = c_red;
var _is_crit = (damage >= 10);

if (_is_crit) {
    _text_color = make_color_rgb(255, 215, 0);
}

draw_text_color(x + 1, y + 1, string(damage), c_black, c_black, c_black, c_black, alpha);
draw_text_color(x, y, string(damage), _text_color, _text_color, _text_color, _text_color, alpha);

draw_set_halign(fa_left);
draw_set_valign(fa_top);