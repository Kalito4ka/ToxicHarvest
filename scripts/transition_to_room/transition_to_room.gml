function transition_to_room(_room) {
    if (instance_exists(obj_room_transition)) return;
    
    var _inst = instance_create_depth(0, 0, -999999, obj_room_transition);
    _inst.target_room = _room;
}