event_inherited();
spr_death_animation = sp_slime_death;
snd_death = snd_slime_death;
snd_attack = snd_slime_jump;
hspd = 0;
vspd = 0;
grv = 0.3;

jump_timer = irandom_range(90, 360);
is_jumping = false;