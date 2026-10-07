// Проверяем КД получения урона и состояние босса
if (!is_dying && hit_cooldown <= 0 && state != "damage") {
    
    var _is_boomerang = (other.object_index == obj_player_boomerang);
    
    if (_is_boomerang) {
        hit_cooldown = other.hit_cooldown_set; 
        
        hp -= other.damage;
		has_played_damage = false;
        
        var _popup = instance_create_layer(x, y - 16, "Instances", obj_damage_text);
        if (instance_exists(_popup)) {
            _popup.damage = other.damage;
        }
        
        if (instance_exists(obj_player)) {
            obj_player.ult_damage_current += floor(other.damage * other.ult_charge_ratio);
            if (obj_player.ult_damage_current > obj_player.ult_damage_required) {
                obj_player.ult_damage_current = obj_player.ult_damage_required;
            }
        }
        
        on_hit();
        
        
    } else {
        hit_cooldown = other.hit_cooldown_set; 
        
        var _popup = instance_create_layer(x, y - 16, "Instances", obj_damage_text);
        if (instance_exists(_popup)) {
            _popup.damage = 0;
        }
        
        if (variable_instance_exists(other, "destroy_on_hit") && other.destroy_on_hit) {
            with (other) instance_destroy();
        }
    }
}