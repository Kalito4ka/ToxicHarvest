event_inherited();

max_distance = 10 * 16;
start_x = x;
spd = 5;
returning = false;

if (!variable_instance_exists(id, "parent_player")) {
    parent_player = obj_player; 
}

dir = parent_player.image_xscale;

damage = irandom_range(3, 15);

hit_cooldown_set = 20;
ult_charge_ratio = 0.5; // Бумеранг дает 50% к ульте
destroy_on_hit = false; // Не уничтожается при первом ударе

