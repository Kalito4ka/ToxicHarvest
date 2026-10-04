fade_alpha += fade_speed * fade_state;

// фаза 1 экран полностью затемнился
if (fade_state == 1 && fade_alpha >= 1) {
    fade_alpha = 1;
    fade_state = -1;
    
    if (room_exists(target_room)) {
        room_goto(target_room);
    }
}

// фаза 2 экран полностью осветлился
if (fade_state == -1 && fade_alpha <= 0) {
    instance_destroy();
}