event_inherited();

// Характеристики
hp = 50;
walk_spd = 0.7;
charge_spd = 4;
bounce_spd = 3;
grv = 0.3;
move_dir = choose(-1, 1);
spr_death_animation = sp_repa_died_2;

// Состояния: "idle", "agitated", "charge", "bounce", "rest", "dead"
state = "idle"; 
state_timer = room_speed * 2; // Таймер для случайной ходьбы/стояния
is_walking_idle = false;      // Флаг: сейчас стоит или идет

// Радиус видимости
sight_range = 140; 

// Дистанция отскока
bounce_target_dist = sight_range;
bounce_start_x = x;

// Эффекты урона
invulnerable = false;
invulnerable_timer = 0;
hit_cooldown = 5 * game_get_speed(gamespeed_fps);
flash_red = false;
