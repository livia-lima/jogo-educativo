/// @description Eventos do vídeo (Async - Social)
var _tipo = async_load[? "type"];

if (_tipo == "video_end") {
	terminou = true;
	tocando = false;
} else if (_tipo == "video_error") {
	show_debug_message("Explicação: erro ao abrir " + video_arquivo);
	fechar_video();
}
