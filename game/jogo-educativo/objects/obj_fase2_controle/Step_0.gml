// Popup de dica aberto: pausa a fase (o popup fecha no X ou Esc)
if (instance_exists(obj_popup_dicas_fase1)) exit;

// Botão voltar (botao_back no canto de cima)
var _sobre_voltar = point_in_rectangle(mouse_x, mouse_y, 25, 15, 139, 136);   // mesmo tamanho do Voltar da Fase 1
if (_sobre_voltar && !hover_voltar) falar("snd_voz_voltar");
hover_voltar = _sobre_voltar;
if (_sobre_voltar && mouse_check_button_pressed(mb_left)) {
    room_goto(rm_start_screen);
}

// Lâmpada de dica (botao_dicas no canto de cima)
var _sobre_dica = point_in_rectangle(mouse_x, mouse_y, 1231, 15, 1346, 137); // mesmo tamanho da Dica da Fase 1
if (_sobre_dica && !hover_dica) falar("dica");
hover_dica = _sobre_dica;
if (_sobre_dica && mouse_check_button_pressed(mb_left)) {
    if (voz_atual != -1) audio_stop_sound(voz_atual); // o video tem a propria narracao
    instance_create_layer(0, 0, "Instances", obj_popup_dicas_fase1);
    exit;
}

// Pergunta (fala o nome do objeto da rodada)
var _sobre_pergunta = point_in_rectangle(mouse_x, mouse_y, 150, 130, 970, 170);
if (_sobre_pergunta && !hover_pergunta) falar(objeto_atual.som);
hover_pergunta = _sobre_pergunta;
