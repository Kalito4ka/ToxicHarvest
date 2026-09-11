var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

//логика облаков
cloud_timer += 0.02;
cloud_auto_x -= 0.2;

var _wave_y = sin(cloud_timer) * 10;

layer_x("Background_clouds", (_cam_x * 0.95) + cloud_auto_x);
layer_y("Background_clouds", (_cam_y * 0.95) + _wave_y);

layer_x("Background_fog", _cam_x*0.7);
layer_y("Background_fog", _cam_y*0.7);

layer_x("Background_mountains", _cam_x*0.6);


layer_x("Background_hills", _cam_x*0.5);


