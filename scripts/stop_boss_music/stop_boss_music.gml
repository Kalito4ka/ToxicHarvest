function stop_boss_music(_fade_time) {
    if (instance_exists(obj_audio_manager)) {
        with (obj_audio_manager) {
            if (audio_is_playing(current_bgm_inst) && !music_stopped) {
                var _time = is_undefined(_fade_time) ? 1500 : _fade_time;
                audio_sound_gain(current_bgm_inst, 0, _time);
                music_stopped = true;
            }
        }
    }
}