if (invincible_timer <= 0 && !global.is_dead && !other.is_dying){
	global.player_lives -= other.damage_to_player;
	audio_play_sound(snd_player_damage, 8, false);
	invincible_timer = invincible_duration;
	vspd = -3.5;
	if (x < other.x){
		hspd = -4;
	} else {
		hspd = 4;
	}
}