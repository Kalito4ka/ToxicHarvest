event_inherited();

if (!is_ready) {
    image_alpha += 0.1;
    if (image_alpha >= 1) {
        image_alpha = 1;
        is_ready = true;
    }
}