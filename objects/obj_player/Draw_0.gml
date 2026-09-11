var _color = c_white;
var _alpha = 1.0;

if (invincible_timer > 0){
	if ((invincible_timer div 4) % 2 == 0){
		_color = c_red;
		_alpha = 0.6;
	}
}

if (global.is_dead) {
    _color = c_white;
    _alpha = 1.0;
}

draw_sprite_ext(
    sprite_index,
    image_index,
    round(x),
    round(y),
    image_xscale,
    image_yscale,
    image_angle,
    _color,
    _alpha
);