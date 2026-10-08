if (!global.is_dead && invincible_timer <= 0) {
    global.player_lives -= other.damage; 
	audio_play_sound(snd_player_damage, 8, false);
    invincible_timer = invincible_duration; 
	vspd = -2.5;
	if (x < other.x){
		hspd = -5;
	} else {
		hspd = 5;
	}
}
