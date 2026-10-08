if (invincible_timer <= 0 && !global.is_dead){
	global.player_lives -= other.damage_amount;
	audio_play_sound(snd_player_damage, 8, false);
	invincible_timer = invincible_duration;
	
	vspd = -3;
	hspd = -image_xscale * 2;
}