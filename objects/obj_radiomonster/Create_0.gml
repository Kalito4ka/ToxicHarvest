hp = 150;
hit_cooldown = 0;
is_dying = false;
damage_to_player = 1;

block_size = 16;
sight_distance = 20 * block_size;          
knockback_spd = 12;                         

spr_idle   = sp_radiomonster_idle;
spr_scream = sp_radiomonster_scream;
spr_attack = sp_radiomonster_attack;
spr_damage = sp_radiomonster_damage;
spr_died   = sp_radiomonster_died;

state = "sleep"; // sleep, wait, scream, attack, damage, dead

facing = 1;

boss_scale = 3;
image_xscale = -facing * boss_scale;
image_yscale = facing*boss_scale;

state_timer = 0;                            
target_x = x;                               
shook_phase1 = false;
shook_phase2 = false;
last_frame = -1;

moved_phase1 = false;
moved_phase2 = false;

sprite_index = spr_idle;
image_speed = 1;

has_played_damage = false;
has_played_roar = false;