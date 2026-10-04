fade_alpha += fade_speed * fade_state;

fade_alpha = clamp(fade_alpha, 0, 1);

// показ кадра
if (fade_state == -1 && fade_alpha <= 0) {
    slide_timer++;
    
    var _skip = mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
    
    if (slide_timer >= slide_duration || _skip) {
        fade_state = 1;
    }
}

if (fade_state == 1 && fade_alpha >= 1) {
    current_frame++;
    
    if (current_frame >= max_frames) {
        if (instance_exists(obj_game_manager)) {
            obj_game_manager.history_seen = true;
        }
                
        instance_destroy();
    } else {
        slide_timer = 0;
        fade_state = -1;
        
        play_slide_sound(current_frame);
    }
}