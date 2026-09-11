event_inherited();
spr_death_animation = sp_ghost_death;
spd = 0.5;
dir = 1;
wave_timer = 0;
wave_speed = 0.05;
wave_amplitude = 0.3;

alarm[1] = game_get_speed(gamespeed_fps) * irandom_range(100, 200);
shoot_range = 120;
can_shoot = true;
shoot_cooldown = 3 * game_get_speed(gamespeed_fps);