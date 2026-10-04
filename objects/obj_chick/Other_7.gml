if (state == "hugging") {
    image_speed = 0;
    image_index = image_number - 1;
    
    state = "wait_finish";
    finish_timer = game_get_speed(gamespeed_fps) * 3;
}