function player_handle_attacks(_is_grounded){
	// кулдауны атак
	if (attack_small_cooldown_timer > 0) attack_small_cooldown_timer -= 1;
	if (attack_heavy_cooldown_timer > 0) attack_heavy_cooldown_timer -= 1;

	var _key_attack_small = keyboard_check_pressed(ord("E"));
	var _key_attack_heavy = keyboard_check_pressed(ord("Q"));
	var _key_ultimate = keyboard_check_pressed(vk_space);
	var _is_player_grounded = place_meeting(x, y + 1, global.tilemap);
	
	// ульта
	if (_key_ultimate && ult_damage_current >= ult_damage_required) {
	    if (sprite_index != sp_player_fight_1 && sprite_index != sp_player_fight_2 && sprite_index != sp_player_fight_3) {
        
	        if (! _is_player_grounded) {
	            ult_damage_current = 0;
            
	            var _boomerang = instance_create_layer(x, y - 8, "Instances", obj_player_boomerang);
	            _boomerang.parent_player = id;
	        } 
	        else {
	            sprite_index = sp_player_fight_3;
	            image_index = 0;
	            image_speed = 1;
	            hspd = 0;
	        }
	    }
	}
	
	//мини атака - работает только на земле
	if (_key_attack_small && attack_small_cooldown_timer <= 0 && _is_grounded) {
        attack_small_cooldown_timer = 20; 
        sprite_index = sp_player_fight_1; 
        image_index = 0;
    }
	//мега атака - работает и на земле и в воздухе
	if (_key_attack_heavy && attack_heavy_cooldown_timer <= 0) {
        attack_heavy_cooldown_timer = 60;
        sprite_index = sp_player_fight_2; 
        image_index = 0;
		vspd = 0;
    }
}

