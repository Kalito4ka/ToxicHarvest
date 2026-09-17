// Базовые настройки скоростей 
move_speed_walk = 1.5;
accel = 0.4;
friction_force = 0.3;

jump_height = -4;
gravity_force = 0.2;

// Переменные движения
hspd = 0;
vspd = 0;

// рывок
dash_speed = 3;
dash_duration = 10;
dash_timer = 0;
dash_cooldown = 45;
dash_cooldown_timer = 0;
dash_direction_x = 1;

coyote_max = 3;
coyote_timer = 0;

//анимация
jump_air_index = 3;
jump_prep_timer = 0;
land_timer = 0;

// жизни

invincible_timer = 0;
invincible_duration = 90;

// атаки
attack_small_cooldown_timer = 0;
attack_heavy_cooldown_timer = 0;

ult_damage_current = 0;
ult_damage_required = 15;

// собранные звезды
stars_found = 0;

// для врага лягушки
is_grabbed = false;
escape_presses = 0;