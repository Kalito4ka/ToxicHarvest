fade_alpha += fade_speed * fade_state;

// фаза 1 экран полностью затемнился
if (fade_state == 1 && fade_alpha >= 1) {
    fade_alpha = 1;
    fade_state = -1;
    
    if (target_room != noone && room_exists(target_room)) {
        var _next = target_room;
        target_room = noone;
        room_goto(_next);
    }
}

// фаза 2 экран полностью осветлился
if (fade_state == -1 && fade_alpha <= 0) {
    instance_destroy();
}