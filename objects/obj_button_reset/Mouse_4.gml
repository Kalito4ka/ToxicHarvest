if (instance_exists(obj_room_transition)) exit;

if (show_question("Вы уверены, что хотите сбросить весь прогресс?")) {
    reset_game_progress();
    transition_to_room(rm_splash);
}