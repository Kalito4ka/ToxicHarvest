if (state == "charge") {
    state = "bounce";
	damage_sound();
    move_dir *= -1;
    vspd = -4;
}