if (instance_exists(obj_player)) {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (_dist <= trigger_distance) {
        image_alpha = min(image_alpha + fade_speed, 1);
    } else {
        image_alpha = max(image_alpha - fade_speed, 0);
    }
}