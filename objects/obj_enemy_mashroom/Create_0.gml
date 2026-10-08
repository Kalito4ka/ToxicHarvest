event_inherited();

hp = 150;
spr_death_animation = sp_enemy_mashroom_died;

hspd = 0;
vspd = 0;
grv = 0.35;

state = "idle";
jump_timer = irandom_range(180, 360);
hang_timer = 0;

player_detection_range = 120; 
has_slammed = false; 

jump_start_y = y;

base_scale = (image_xscale != 1) ? abs(image_xscale) : 1.5; 

image_xscale = base_scale;
image_yscale = base_scale;

// звуки

sound_range = 700;
snd_death = snd_mashroom_death;
snd_damage = snd_mashroom_damage;
snd_attack = snd_mashroom_jump;