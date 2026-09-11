if (other.hit_cooldown <= 0){
	other.hit_cooldown = 15;
	other.hp -= damage;

	var _popup = instance_create_layer(other.x, other.y - 16, "Instances", obj_damage_text);

	_popup.damage = damage;

	if (instance_exists(obj_player)) {
	    obj_player.ult_damage_current += damage;
    
	    if (obj_player.ult_damage_current > obj_player.ult_damage_required) {
	        obj_player.ult_damage_current = obj_player.ult_damage_required;
	    }
	}

	instance_destroy();
}