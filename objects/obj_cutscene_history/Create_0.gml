depth = -10000;
current_frame = 0;
max_frames = 4;

// Параметры затемнения / осветления
fade_alpha = 1;
fade_state = -1;
fade_speed = 0.02;

slide_timer = 0;
slide_duration = 180;

// Функция для проигрывания звуков в будущем
play_slide_sound = function(_frame) {
    switch (_frame) {
        case 0:
            // audio_play_sound(snd_history_1, 1, false);
            break;
        case 1:
            // audio_play_sound(snd_history_2, 1, false);
            break;
        case 2:
            // audio_play_sound(snd_history_3, 1, false);
            break;
        case 3:
            // audio_play_sound(snd_history_4, 1, false);
            break;
    }
};

// Запускаем звук для первого кадра
play_slide_sound(current_frame);