if (room == rm_fase1_falha) {
    destino_tentar = rm_fase1_gameplay;
} else {
    destino_tentar = rm_fase2_gameplay;
}
// Área de clique dos botões (as imagens ficam na camada tela_falha da room)
bx = room_width / 2;
bw = 340;  bh = 90;
b1y = 420;   // Tentar de novo
b2y = 530;   // Voltar ao menu

// Fonte pixel (PressStart2P, dos Included Files) - criada uma vez só no jogo
if (!variable_global_exists("fonte_pixel")) {
    global.fonte_pixel = -1;
    if (file_exists("fonts/PressStart2P.ttf")) global.fonte_pixel = font_add("fonts/PressStart2P.ttf", 16, false, false, 32, 255);
}

// Áudios de voz (tocam quando o mouse passa em cima)
voz_atual = -1;
hover_titulo = false;
hover_b1 = false;
hover_b2 = false;
falar = function(_nome) {
    var _s = asset_get_index(_nome);
    if (_s == -1 || !audio_exists(_s)) return;
    if (voz_atual != -1) audio_stop_sound(voz_atual);
    voz_atual = audio_play_sound(_s, 1, false);
};
