if (!activated && instance_exists(obj_player)) {
    if (place_meeting(x, y, obj_player)) {
        activated = true;
		audio_play_sound(snd_fireflyes_touch, 5, false);
    }
}

if (activated) {
    image_alpha -= fade_speed;
    
    if (image_alpha <= 0) {
        instance_destroy();
    }
}