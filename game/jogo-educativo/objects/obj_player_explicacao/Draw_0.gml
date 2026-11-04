/// @description Fundo, vídeo (ou animação), legenda e botões

// Fundo com zoom lento (efeito "Ken Burns") para dar vida à tela
var _zoom = 1 + 0.04 * (tempo / max(1, duracao));
draw_sprite_ext(fundo, 0, -(_zoom - 1) * room_width / 2, -(_zoom - 1) * room_height / 2, _zoom, _zoom, 0, c_white, 1);

// Título da fase
desenhar_texto(room_width / 2, 52, titulo, 2.6 * escala_texto(), room_width - 320, c_white, COR_AZUL_ESCURO, 1);

// Vídeo ou animação de demonstração
if (usando_video) {
	var _v = video_draw();
	if (_v[0] == 0 && surface_exists(_v[1])) {
		var _sw = surface_get_width(_v[1]);
		var _sh = surface_get_height(_v[1]);
		var _s  = min(900 / _sw, 440 / _sh);
		var _dw = _sw * _s, _dh = _sh * _s;
		var _x  = (room_width - _dw) / 2, _y = 95;
		draw_set_colour(COR_AZUL_ESCURO);
		draw_roundrect_ext(_x - 10, _y - 10, _x + _dw + 10, _y + _dh + 10, 20, 20, false);
		draw_set_colour(c_white);
		draw_surface_stretched(_v[1], _x, _y, _dw, _dh);
	} else {
		desenhar_texto(room_width / 2, 300, "Carregando vídeo...", 2, 600, c_white, COR_AZUL_ESCURO, 1);
	}
}
if (!usando_video) {
	demo(tempo);
}

// Legenda sincronizada (entra e sai com fade curto)
if (cue_atual != -1) {
	var _c = cues[cue_atual];
	var _alpha = min(progresso(tempo, _c.ini, _c.ini + 250), 1 - progresso(tempo, _c.fim - 200, _c.fim));
	desenhar_legenda(_c.texto, max(_alpha, 0.15));
}

// Botões
if (!terminou) {
	if (botao_texto(room_width - 120, 52, 190, 64, "Pular", COR_LARANJA)) sair();
} else {
	desenhar_texto(room_width / 2, 585, "Agora é a sua vez!", 2.8 * escala_texto(), 900, COR_AMARELO, COR_AZUL_ESCURO, 1);
	var _pulso = 1 + sin(current_time / 200) * 0.04;
	if (botao_texto(room_width / 2 - 200, 680, 300, 90, "Ver de novo", COR_AZUL_ESCURO)) iniciar();
	if (botao_texto(room_width / 2 + 200, 680, 300 * _pulso, 90 * _pulso, "Começar!", COR_VERDE)) sair();
}
