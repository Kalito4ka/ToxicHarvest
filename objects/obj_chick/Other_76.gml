var _msg = event_data[? "message"];

switch (_msg) {
    case "chik_squek":
        audio_play_sound(snd_chik_sqek, 5, false);
		break;
	case "chik_victory":
		if (!has_played_victory){
			audio_play_sound(snd_victory, 5, false);
			has_played_victory = true;
		}
		break;
}
