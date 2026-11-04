/// @description Eventos do vídeo (Async - Social)
var _tipo = async_load[? "type"];

if (_tipo == "video_end") {
	terminou = true;
} else if (_tipo == "video_error") {
	// Não conseguiu tocar o vídeo: usa a animação de demonstração
	show_debug_message("Explicação: erro ao abrir " + video_arquivo + " — usando animação.");
	fechar_video();
	tempo = 0;
	terminou = false;
	cue_atual = -1;
	legendas_reiniciar(cues);
}
