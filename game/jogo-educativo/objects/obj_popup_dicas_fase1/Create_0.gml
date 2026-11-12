
/// obj_popup_dicas_fase1 - CREATE

// Coloca o popup acima dos outros objetos
depth = -10000;

// Video da dica: o mesmo tutorial da explicacao da fase em que o popup abriu.
// (Usado na Fase 1 e na Fase 2.)
arquivo_video = (room == rm_fase2_gameplay)
    ? "videos/fase2_explicacao.mp4"
    : "videos/fase1_explicacao.mp4";

video_aberto = false;

// Para a narracao que estiver tocando (ex.: "dica"): o video tem a propria voz
if (variable_global_exists("voz_narracao") && global.voz_narracao != -1) audio_stop_sound(global.voz_narracao);

if (file_exists(arquivo_video)) {
    video_open(arquivo_video);
    video_enable_loop(false);
    video_set_volume(obter_volume());
    video_aberto = true;
} else {
    show_debug_message(
        "AVISO: video nao encontrado: " + arquivo_video
    );
}
