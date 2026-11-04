/// @description Posição do vídeo, legenda, controles do player e atalhos
var _px = PLAYER_X, _py = player_y, _pw = PLAYER_W, _ph = PLAYER_H;
var _by = _py + _ph - PLAYER_BARRA_H / 2;   // linha central da barra de controles

// Relógio segue o vídeo
if (usando_video) {
	duracao = video_get_duration();
	if (!terminou) {
		tempo = video_get_position();
		if (duracao > 0 && tempo >= duracao - 50) terminou = true;
	}
}
if (terminou && fim_em < 0) fim_em = current_time;
if (fim_em >= 0 && current_time - fim_em > 1200) sair();   // vídeo acabou: segue para o jogo

cue_atual = usando_video ? legenda_indice(cues, tempo) : -1;

// Controles (posições do Figma)
if (clicou_em(_px, _py, _px + _pw, _by - PLAYER_BARRA_H / 2)) alternar_pausa();   // clique no vídeo
if (clicou_em(_px + 6, _by - 20, _px + 38, _by + 20)) alternar_pausa();          // play/pausa
if (clicou_em(_px + 39, _by - 20, _px + 70, _by + 20) && usando_video) iniciar(); // voltar ao início
if (clicou_em(_px + 74, _by - 20, _px + 106, _by + 20)) sair();                   // próximo: vai para o jogo
if (clicou_em(_px + 700, _by - 20, _px + 780, _by + 20)) alternar_mudo();         // volume
if (clicou_em(_px + 784, _by - 20, _px + 814, _by + 20)) window_set_fullscreen(!window_get_fullscreen());

// Clique na barra de progresso: pula para aquele ponto
var _bx1 = _px + 155, _bx2 = _px + 630;
if (usando_video && duracao > 0 && clicou_em(_bx1, _by - 12, _bx2, _by + 12)) {
	video_seek_to(duracao * clamp((mouse_x - _bx1) / (_bx2 - _bx1), 0, 1));
	terminou = false;
	fim_em = -1;
}

// Atalhos: Espaço pausa/continua, Enter pula para o jogo
if (keyboard_check_pressed(vk_space)) alternar_pausa();
if (keyboard_check_pressed(vk_enter)) sair();
