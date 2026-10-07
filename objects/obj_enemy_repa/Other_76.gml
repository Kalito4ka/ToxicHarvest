if (event_data[? "message"] == "repa_step") {
    if (state == "idle") {
        audio_play_sound(snd_step, 5, false);
    } else if (state == "charge" || state == "agitated") {
        global.shake_amount = 3;
        attack_sound();
    }
}

if (event_data[? "message"] == "repa_boom"){
	audio_sound_gain(snd_death, 5.0, 0);
}