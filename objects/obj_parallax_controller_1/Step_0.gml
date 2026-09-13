var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);




layer_x("Background_fog", _cam_x*0.95);
layer_y("Background_fog", _cam_y*0.95);

layer_x("Background_mountains", _cam_x*0.7);

layer_x("Background_clouds", _cam_x * 0.65);
layer_y("Background_clouds", _cam_y);

layer_x("Background_hills", _cam_x*0.5);


