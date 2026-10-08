function player_handle_attacks(_is_grounded){
    // кулдауны атак
    if (attack_small_cooldown_timer > 0) attack_small_cooldown_timer -= 1;
    if (attack_heavy_cooldown_timer > 0) attack_heavy_cooldown_timer -= 1;

    var _key_attack = keyboard_check_pressed(ord("E"));
    var _key_ultimate = keyboard_check_pressed(vk_space);
    
    // Ультимейт на Space
    if (_key_ultimate && ult_damage_current >= ult_damage_required) {
        if (sprite_index != sp_player_fight_1 && sprite_index != sp_player_fight_2 && sprite_index != sp_player_fight_3) {
            audio_play_sound(snd_player_attack_3, 5, false);
            if (!_is_grounded) {
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
    
    // Все атаки на E
    if (_key_attack) {
        // Наземная обычная атака
        if (_is_grounded && attack_small_cooldown_timer <= 0) {
            audio_play_sound(snd_player_attack_1, 5, false);
            attack_small_cooldown_timer = 20; 
            sprite_index = sp_player_fight_1; 
            image_index = 0;
        } 
        // Воздушная / Мега атака
        else if (!_is_grounded && attack_heavy_cooldown_timer <= 0) {
            audio_play_sound(snd_player_attack_2, 5, false);
            attack_heavy_cooldown_timer = 60;
            sprite_index = sp_player_fight_2; 
            image_index = 0;
            vspd = 0;
        }
    }
}
