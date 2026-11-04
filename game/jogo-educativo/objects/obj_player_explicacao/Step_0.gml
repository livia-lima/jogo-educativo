/// @description Relógio, sincronização de legendas/voz e atalhos

// 1) Relógio: segue o vídeo quando há vídeo; senão, conta o tempo real.
if (!terminou) {
	if (usando_video) {
		tempo = video_get_position();
		var _dur = video_get_duration();
		if (_dur > 0 && tempo >= _dur - 50) terminou = true;
	} else {
		tempo += delta_time / 1000;
		if (tempo >= duracao) {
			tempo = duracao;
			terminou = true;
		}
	}
}

// 2) Legenda ativa + dublagem (no vídeo a voz já vem gravada nele)
var _i = legenda_indice(cues, tempo);
if (_i != cue_atual) {
	cue_atual = _i;
	if (_i != -1 && !cues[_i].tocada) {
		cues[_i].tocada = true;
		if (!usando_video && cues[_i].voz != "") {
			parar_voz();
			voz_atual = tocar_voz(cues[_i].voz);
		}
	}
}

// 3) Teclado: Enter/Espaço pula a explicação ou começa a fase
if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	sair();
}
