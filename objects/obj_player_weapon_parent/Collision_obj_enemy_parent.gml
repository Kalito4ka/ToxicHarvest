// Не наносим урон, если враг умирает или у него активен hit_cooldown
if (!other.is_dying && other.hit_cooldown <= 0) {
    
    //КД получения урона врагу
    other.hit_cooldown = hit_cooldown_set; 
    
    // нанесения урона у врага
    other.hp -= damage;
    other.damage_sound();
    // Уведомляем врага о получении урона
    with (other) {
        if (variable_instance_exists(id, "on_hit")) {
            on_hit();
        }
    }

    //Создаем текст урона
    var _popup = instance_create_layer(other.x, other.y - 16, "Instances", obj_damage_text);
    if (instance_exists(_popup)) {
        _popup.damage = damage;
    }

    //Пополняем шкалу ульты
    if (instance_exists(obj_player)) {
        obj_player.ult_damage_current += floor(damage * ult_charge_ratio);
        
        if (obj_player.ult_damage_current > obj_player.ult_damage_required) {
            obj_player.ult_damage_current = obj_player.ult_damage_required;
        }
    }

    //Уничтожаем атакующую сущность, если нужно
    if (destroy_on_hit) {
        instance_destroy();
    }
}