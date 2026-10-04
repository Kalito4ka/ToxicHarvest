if (state == "idle") {
    state = "help";
    sprite_index = spr_help;
    shake_timer = 60;
}

alarm[0] = game_get_speed(gamespeed_fps) * 5;