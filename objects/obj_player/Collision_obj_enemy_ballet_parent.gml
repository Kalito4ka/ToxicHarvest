if (!global.is_dead && invincible_timer <= 0) {
    global.player_lives -= other.damage; 
    invincible_timer = invincible_duration; 
	vspd = -2.5;
	if (x < other.x){
		hspd = -5;
	} else {
		hspd = 5;
	}
}
