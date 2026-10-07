spr_afraid = sp_chik_afraid;
spr_idle   = sp_chik_idle;
spr_hug    = sp_chik_hug;

sprite_index = spr_afraid;
image_speed = 1;

// Состояния: "afraid" -> "idle" -> "hugging" -> "wait_finish"
state = "afraid"; 

afraid_timer = 60; 

finish_timer = 0;
finished = false;

stars_found = 0;

depth = -10000;

squeak_timer = 0;

//звук
has_played_victory = false;