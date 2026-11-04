/// @description Player de vídeo/animação com legendas (Fase 1 e Fase 2 Explicação)
// O mesmo objeto é usado nas duas salas; a configuração muda conforme a sala.
// Se o arquivo de vídeo existir em Included Files (datafiles/videos/), ele é tocado.
// Se não existir (ou der erro), entra a animação de demonstração (fallback).

if (room == rm_fase2_explicacao) {
	fundo         = spr_bg_fase2_explicacao;
	video_arquivo = VIDEO_FASE2;
	cues          = legendas_fase2();
	demo          = demo_fase2;
	sala_seguinte = rm_fase2_gameplay;
	titulo        = "Fase 2: Contando objetos";
} else {
	fundo         = spr_bg_fase1_explicacao;
	video_arquivo = VIDEO_FASE1;
	cues          = legendas_fase1();
	demo          = demo_fase1;
	sala_seguinte = rm_fase1_gameplay;
	titulo        = "Fase 1: Palavra e imagem";
}

duracao      = legendas_duracao(cues);
tempo        = 0;     // relógio da explicação, em ms (posição do vídeo ou timer próprio)
terminou     = false;
usando_video = false;
video_aberto = false;
voz_atual    = -1;
cue_atual    = -1;

parar_voz = function() {
	if (voz_atual != -1 && audio_is_playing(voz_atual)) audio_stop_sound(voz_atual);
	voz_atual = -1;
};

fechar_video = function() {
	if (video_aberto) video_close();
	video_aberto = false;
	usando_video = false;
};

/// (Re)começa a explicação do início.
iniciar = function() {
	tempo     = 0;
	terminou  = false;
	cue_atual = -1;
	legendas_reiniciar(cues);
	parar_voz();
	fechar_video();
	if (file_exists(video_arquivo)) {
		video_open(video_arquivo);
		video_enable_loop(false);
		video_set_volume(obter_volume());
		video_aberto = true;
		usando_video = true;
	}
};

/// Vai para o gameplay da fase.
sair = function() {
	parar_voz();
	fechar_video();
	room_goto(sala_seguinte);
};

iniciar();
