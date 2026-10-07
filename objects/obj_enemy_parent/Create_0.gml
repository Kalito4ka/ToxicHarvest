spr_death_animation = noone;
snd_death = noone;
snd_attack = noone;
snd_damage = snd_monster_damage;
is_dying = false;
hit_cooldown = 0;
star_drop = false;
number_of_stars = 0;

hspd = 0;
vspd = 0;

//активация монстров
is_active = false;
activation_range = 250;
sound_range = 350;

//звук
sfx_emitter = audio_emitter_create();
audio_emitter_position(sfx_emitter, x, y, 0);
audio_emitter_falloff(sfx_emitter, 50, sound_range, 1);


damage_sound = function() {
    if (variable_instance_exists(id, "snd_damage") && audio_exists(snd_damage)) {
        audio_emitter_position(sfx_emitter, x, y, 0);
        audio_play_sound_on(sfx_emitter, snd_damage, false, 5);
    }
};

death_sound = function() {
    if (snd_death != noone) {
        audio_emitter_position(sfx_emitter, x, y, 0);
        audio_play_sound_on(sfx_emitter, snd_death, false, 5);
    }
};

attack_sound = function(){
	if (snd_attack != noone){
		audio_emitter_position(sfx_emitter, x, y, 0);
	    audio_play_sound_on(sfx_emitter, snd_attack, false, 5);
	}
}