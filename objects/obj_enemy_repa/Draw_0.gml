var _draw_x = x;

// Смещение по X, если идет тряска при смерти
if (state == "dead") {
    _draw_x += shake_offset;
}

// Переливание красным при неуязвимости
if (invulnerable && flash_red) {
    gpu_set_fog(true, c_red, 0, 1);
    draw_sprite_ext(sprite_index, image_index, _draw_x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
    gpu_set_fog(false, c_white, 0, 1);
} else {
    draw_sprite_ext(sprite_index, image_index, _draw_x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}