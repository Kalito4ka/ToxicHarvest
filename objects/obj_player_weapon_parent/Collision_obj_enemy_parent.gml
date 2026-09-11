// Не наносим урон, если враг умирает или у него активен hit_cooldown
if (!other.is_dying && other.hit_cooldown <= 0) {
    
    // 1. Устанавливаем КД получения урона врагу
    other.hit_cooldown = hit_cooldown_set; 
    
    // 2. Вызываем функцию/метод нанесения урона у врага (если есть) или вычитаем HP напрямую
    other.hp -= damage;
    
    // Уведомляем врага о получении урона (нужно для визуальных эффектов репы)
    with (other) {
        if (variable_instance_exists(id, "on_hit")) {
            on_hit();
        }
    }

    // 3. Создаем текст урона
    var _popup = instance_create_layer(other.x, other.y - 16, "Instances", obj_damage_text);
    if (instance_exists(_popup)) {
        _popup.damage = damage;
    }

    // 4. Пополняем шкалу суперспособности (ульты)
    if (instance_exists(obj_player)) {
        obj_player.ult_damage_current += floor(damage * ult_charge_ratio);
        
        if (obj_player.ult_damage_current > obj_player.ult_damage_required) {
            obj_player.ult_damage_current = obj_player.ult_damage_required;
        }
    }

    // 5. Уничтожаем атакующую сущность, если нужно
    if (destroy_on_hit) {
        instance_destroy();
    }
}