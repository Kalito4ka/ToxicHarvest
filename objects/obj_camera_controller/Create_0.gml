depth = -9000;
global.shake_amount = 0;

default_cam_w = camera_get_view_width(view_camera[0]);
default_cam_h = camera_get_view_height(view_camera[0]);

// Переменные для динамического зума
target_cam_w = default_cam_w;
target_cam_h = default_cam_h;
zoom_speed = 0.05;