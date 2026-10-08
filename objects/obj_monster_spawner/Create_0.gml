spawn_cooldown_min = 3600;
spawn_cooldown_max = 3600;
max_monsters = 1;
spawn_radius = 0;
monster = obj_enemy_slime;

//для токсичного шара
spawn_fly_dir = undefined;

//босс
is_boss_level = true;
boss_object = obj_enemy_repa;
boss_cleared = false;

snd_drop = snd_spawner_drop;
sound_range = 400;

sfx_emitter = audio_emitter_create();
audio_emitter_position(sfx_emitter, x, y, 0);
audio_emitter_falloff(sfx_emitter, 50, sound_range, 1);

play_spawn_sound = function(_spawn_x, _spawn_y) {
    if (audio_exists(snd_drop) && audio_emitter_exists(sfx_emitter)) {
        audio_emitter_position(sfx_emitter, _spawn_x, _spawn_y, 0);
        audio_play_sound_on(sfx_emitter, snd_drop, false, 5);
    }
};

alarm[0] = irandom_range(spawn_cooldown_min, spawn_cooldown_max);