event_inherited();

move_spd = 5;
fly_dir = "down";

spr_fly = sp_toxic_ball_default;
spr_hit = sp_toxic_ball_jump;
spr_pop = sp_toxic_ball_pop;

state = "fly";

if (fly_dir == "down") {
    direction = 270;
    speed = move_spd;
    image_angle = 270;
}
else if (fly_dir == "left") {
    direction = 180;
    speed = move_spd;
    image_angle = 180;
}
else if (fly_dir == "right") {
    direction = 0;
    speed = move_spd;
    image_angle = 0;
}

image_xscale = 1;
image_yscale = 1;
sprite_index = spr_fly;
image_speed = 1;