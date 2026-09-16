if (!is_active) {
    if (instance_exists(obj_player)) {
        if (point_distance(x, y, obj_player.x, obj_player.y) <= activation_range) {
            is_active = true;
        }
    }
    exit;
}
event_inherited();
if (sprite_index == sprite_attack) {
    
    if (floor(image_index) == 3 && !bullet_spawned) {
        
        instance_create_layer(x, y + 8, "Instances_pumpkin", obj_enemy_pumpkin_bullet);
        
        bullet_spawned = true;
    }
}