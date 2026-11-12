
/// obj_popup_dicas_fase1 - CREATE

// Coloca o popup acima dos outros objetos
depth = -10000;

// Video utilizado na explicacao da Fase 1
arquivo_video = "videos/fase1_explicacao.mp4";

video_aberto = false;

if (file_exists(arquivo_video)) {
    video_open(arquivo_video);
    video_aberto = true;
} else {
    show_debug_message(
        "AVISO: video nao encontrado: " + arquivo_video
    );
}
