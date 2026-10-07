if (state == "idle") {
    state = "help";
    sprite_index = spr_help;
    shake_timer = 60;
	
	if (!played_help_sound) {
        audio_play_sound(snd_prison_help, 5, false);
        played_help_sound = true;
    }
}

alarm[0] = game_get_speed(gamespeed_fps) * 15;