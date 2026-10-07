event_inherited();

hp = 30;
damage_to_player = 1;
spr_death_animation = sp_enemy_frog_died;

// Дистанция атаки
attack_range = 250;

// Состояния: "idle", "attack_start", "tongue_out", "pulling", "finish_attack"
state = "idle";

// Кулдаун после атаки
attack_cooldown_timer = 0;
attack_cooldown_duration = 180;

// Таймеры покоя и поворота
idle_timer = irandom_range(60, 150);
is_stepping = false;

tongue_inst = noone;

// Переменные отскока при смерти
death_vspd = -5;
death_hspd = 0;
death_gravity = 0.25;

snd_attack = snd_frog_step;
snd_frog = snd_frog_attack;
