var _msg = event_data[? "message"];

switch (_msg) {
    case "monster_attack":
        audio_play_sound(snd_radiomonster_attack, 5, false);
        break;

    case "monster_damage":
        if (!has_played_damage) {
            audio_play_sound(snd_radiomonster_damage, 5, false);
            has_played_damage = true;
        }
        break;

    case "monster_death_1":
        audio_play_sound(snd_radiomonster_death, 5, false);
        break;

    case "monster_death_2":
        audio_play_sound(snd_radiomonster_death_2, 5, false);
        break;

    case "monster_roar":
        if (!has_played_roar) {
            audio_play_sound(snd_radiomonster_roar, 5, false);
            has_played_roar = true;
        }
        break;
}