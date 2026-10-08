if (variable_global_exists("is_dead")) {
	if (global.is_dead && !was_dead) {
		was_dead = true;
        
		if (audio_is_playing(current_bgm_inst)) {
			audio_sound_gain(current_bgm_inst, 0, 500);
		}
	}
    
	if (!global.is_dead && was_dead) {
		was_dead = false;
	}
}