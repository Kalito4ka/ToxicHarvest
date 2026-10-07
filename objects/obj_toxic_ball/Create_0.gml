event_inherited();

move_spd = 3;
fly_dir = "down";

spr_fly = sp_toxic_ball_default;
spr_hit = sp_toxic_ball_jump;
spr_pop = sp_toxic_ball_pop;

snd_pop = snd_ball_pop;
snd_jump = snd_ball_jump;

sound_range = 350;

sfx_emitter = audio_emitter_create();
audio_emitter_position(sfx_emitter, x, y, 0);
audio_emitter_falloff(sfx_emitter, 50, sound_range, 1);

played_jump = false;
played_pop = false;

pop_sound = function() {
    if (!played_pop && audio_exists(snd_pop)) {
        audio_emitter_position(sfx_emitter, x, y, 0);
        audio_play_sound_on(sfx_emitter, snd_pop, false, 5);
        played_pop = true;
    }
};

jump_sound = function() {
    if (!played_jump && audio_exists(snd_jump)) {
        audio_emitter_position(sfx_emitter, x, y, 0);
        audio_play_sound_on(sfx_emitter, snd_jump, false, 5);
        played_jump = true;
    }
};

state = "fly";

image_xscale = 1;
image_yscale = 1;
sprite_index = spr_fly;
image_speed = 1;