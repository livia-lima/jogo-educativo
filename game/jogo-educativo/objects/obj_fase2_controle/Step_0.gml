// Botão voltar (botao_back no canto de cima)
var _sobre_voltar = point_in_rectangle(mouse_x, mouse_y, 15, 15, 72, 67);
if (_sobre_voltar && !hover_voltar) falar("snd_voz_voltar");
hover_voltar = _sobre_voltar;
if (_sobre_voltar && mouse_check_button_pressed(mb_left)) {
    room_goto(rm_start_screen);
}

// Lâmpada de dica (botao_dicas no canto de cima)
var _sobre_dica = point_in_rectangle(mouse_x, mouse_y, 1300, 15, 1352, 71);
if (_sobre_dica && !hover_dica) falar("dica");
hover_dica = _sobre_dica;

// Pergunta (fala o nome do objeto da rodada)
var _sobre_pergunta = point_in_rectangle(mouse_x, mouse_y, 150, 130, 970, 170);
if (_sobre_pergunta && !hover_pergunta) falar(objeto_atual.som);
hover_pergunta = _sobre_pergunta;
