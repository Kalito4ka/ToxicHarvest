max_distance = 10 * 16;
start_x = x;
spd = 5;
returning = false;

if (!variable_instance_exists(id, "parent_player")) {
    parent_player = obj_player; 
}

dir = parent_player.image_xscale;

damage = irandom_range(3, 15);


