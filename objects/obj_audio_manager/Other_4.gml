music_stopped = false;

var _target_bgm = -1;

switch (room) {
    case rm_splash:
    case rm_menu:
        _target_bgm = snd_fon_menu;
        break;
        
    case rm_level_1:
    case rm_level_2:
    case rm_level_3:
        _target_bgm = snd_fon_farm;
        break;
        
    case rm_level_4:
        _target_bgm = snd_fon_farm_boss;
        break;
        
    case rm_level_5:
    case rm_level_6:
    case rm_level_7:
        _target_bgm = snd_fon_darkwood;
        break;
        
    case rm_level_8:
        _target_bgm = snd_fon_darkwood_boss;
        break;
        
    case rm_level_9:
        _target_bgm = snd_fon_toxicwood;
        break;
        
    case rm_level_10:
        _target_bgm = snd_fon_toxicwood_boss;
        break;
}

if (_target_bgm != current_bgm || was_dead) {
    
    if (audio_is_playing(current_bgm_inst)) {
        audio_stop_sound(current_bgm_inst);
    }
    
    current_bgm = _target_bgm;
    
    if (current_bgm != -1) {
        current_bgm_inst = audio_play_sound(current_bgm, 10, true);
        
        audio_sound_gain(current_bgm_inst, 0, 0);
        audio_sound_gain(current_bgm_inst, 1, 500);
    }
}

was_dead = false;