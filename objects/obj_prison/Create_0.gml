block_size = 16;
shake_offset_x = 0;
shake_timer = 0;

state = "idle"; 

alarm[0] = game_get_speed(gamespeed_fps) * 15;

spr_idle = sp_prison;
spr_help = sp_prison_help;
spr_freedom = sp_prison_freedom;

is_dropped = false;

// звук
played_help_sound = false;
played_fall_sound = false;
played_fallen_sound = false;