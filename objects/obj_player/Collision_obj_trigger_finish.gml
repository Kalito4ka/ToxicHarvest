var _room_name = room_get_name(room);
var _current_level = real(string_digits(_room_name));
var _stars_on_this_level = stars_found;

if (_stars_on_this_level > obj_game_manager.level_stars[_current_level]) {
	obj_game_manager.level_stars[_current_level] = _stars_on_this_level;
}

var _sum = 0;
for (var i = 1; i <= obj_game_manager.total_levels; i++){
	_sum += obj_game_manager.level_stars[i];
}
global.total_stars_collected = _sum;

var _next_level = _current_level + 1;
if (_next_level <= obj_game_manager.total_levels){
	obj_game_manager.level_open[_next_level] = true;
}
room_goto(rm_menu);