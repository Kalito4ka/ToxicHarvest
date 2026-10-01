function on_hit(){
    // Враг/бумеранг уже отнял hp в своем коде (other.hp -= damage)
    // Но если босс умер или находится в стане от прошлого удара — ничего не делаем
    if (state == "dead" || state == "damage") exit;

    if (hp <= 0) {
        // Босс погиб
        hp = 0;
        is_dying = true;
        state = "dead";
        sprite_index = spr_died;
        image_index = 0;
        image_speed = 1;
        speed = 0;
    } else {
        // Босс получает урон и отлетает к задней стене
        state = "damage";
        sprite_index = spr_damage;
        image_index = 0;
        image_speed = 1;
    }
}