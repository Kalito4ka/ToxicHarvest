if (gravity > 0){
	if (vspeed >= 0){
		vspeed = 0;
		gravity = 0;
		start_y = y;		
	}
} else {	
	hover_timer += hover_speed;
	y = start_y + (sin(hover_timer) * hover_range);
}