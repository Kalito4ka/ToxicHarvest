// Окончание крика -> переход к атаке
if (state == "scream") {
    state = "attack";
    sprite_index = spr_attack;
    image_index = 0;
    image_speed = 1;
    
    // Сбрасываем флаги движения для атаки
    moved_phase1 = false;
    moved_phase2 = false;
    target_x = x;
}

// Окончание атаки
else if (state == "attack") {
    state = "wait";
    state_timer = game_get_speed(gamespeed_fps) * 1;
    sprite_index = spr_idle;
}

else if (state == "dead") {
    instance_destroy();
}

if (state == "scream") {
    state = "attack";
    sprite_index = spr_attack;
    image_index = 0;
    image_speed = 1;

    moved_phase1 = false;
    moved_phase2 = false;
    last_frame = -1;
}