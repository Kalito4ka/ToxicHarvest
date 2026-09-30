// Когда заканчивается анимация удара об стену -> переходим ко взрыву
if (state == "hit") {
    state = "pop";
    
    if (spr_pop != noone && sprite_exists(spr_pop)) {
        sprite_index = spr_pop;
        image_index = 0;
        image_speed = 1;
    } else {
        instance_destroy(); // Если взрыва нет — сразу удаляем
    }
}
// Когда заканчивается анимация взрыва -> уничтожаем объект
else if (state == "pop") {
    instance_destroy();
}