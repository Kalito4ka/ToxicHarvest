event_inherited();

hp = 30;

// скорости
walk_spd = 1;
charge_spd = 4;
move_dir = 1; // 1 - право -1 -лево
hspd = walk_spd*move_dir;
vspd = 0;

// состояния
state = "walk"; // Возможные состояния: "walk", "agitated", "charge", "bounce", "dead"
state_timer = 0;

// Неуязвимость и мигание
invulnerable = false;
invulnerable_timer = 0;
flash_red = false;

// Тряска при смерти
shake_offset = 0;