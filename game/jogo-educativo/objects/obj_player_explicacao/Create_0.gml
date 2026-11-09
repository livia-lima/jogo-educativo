/// @description Tela de explicação: player de vídeo + legenda (Fase 1 e Fase 2)
// Layout conforme o Figma. O mesmo objeto é usado nas duas salas.
// O vídeo é colocado depois em Included Files (datafiles/videos/):
//   videos/fase1_explicacao.mp4 e videos/fase2_explicacao.mp4
// Sem o arquivo, o player aparece parado; o botão "próximo" leva ao jogo.

if (room == rm_fase2_explicacao) {
	fundo         = spr_bg_fase2_explicacao;
	video_arquivo = VIDEO_FASE2;
	cues          = legendas_fase2();
	sala_seguinte = rm_fase2_gameplay;
	player_y      = 76;
} else {
	fundo         = spr_bg_fase1_explicacao;
	video_arquivo = VIDEO_FASE1;
	cues          = legendas_fase1();
	sala_seguinte = rm_fase1_gameplay;
	player_y      = 102;
}

tempo        = 0;      // posição do vídeo (ms)
duracao      = 0;      // duração do vídeo (ms)
tocando      = false;
terminou     = false;
fim_em       = -1;     // momento em que o vídeo acabou (para seguir para o jogo)
usando_video = false;
video_aberto = false;
mudo         = false;
cue_atual    = -1;

fechar_video = function() {
	if (video_aberto) video_close();
	video_aberto = false;
	usando_video = false;
	tocando = false;
};

/// (Re)começa o vídeo do início.
iniciar = function() {
	tempo = 0;
	terminou = false;
	fim_em = -1;
	cue_atual = -1;
	fechar_video();
	if (file_exists(video_arquivo)) {
		video_open(video_arquivo);
		video_enable_loop(false);
		video_set_volume(mudo ? 0 : obter_volume());
		video_aberto = true;
		usando_video = true;
		tocando = true;
	}
};

alternar_pausa = function() {
	if (!usando_video) return;
	if (terminou) { iniciar(); return; }
	if (tocando) video_pause(); else video_resume();
	tocando = !tocando;
};

alternar_mudo = function() {
	mudo = !mudo;
	if (usando_video) video_set_volume(mudo ? 0 : obter_volume());
};

/// Vai para o gameplay da fase.
sair = function() {
	fechar_video();
	room_goto(sala_seguinte);
};

iniciar();
