var _msg = event_data[? "message"];

switch (_msg) {
    case "ball_jump":
        jump_sound();
        break;
        
    case "ball_pop":
        pop_sound();
        break;
}