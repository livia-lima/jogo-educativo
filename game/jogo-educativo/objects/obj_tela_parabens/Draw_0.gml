/// @description Fundo, quadro de parabéns, placar, confetes, botões e legenda
draw_sprite(spr_bg_parabens, 0, 0, 0);

// Quadro com o título (entra "pulando")
var _p = suavizar_volta(progresso(tempo, t_titulo, t_titulo + 700));
if (_p > 0) {
	var _s = 0.75 * _p;
	var _fx = room_width / 2, _fy = 170;
	draw_sprite_ext(spr_frame_parabens, 0, _fx, _fy, _s, _s, 0, c_white, 1);
	desenhar_texto(_fx, _fy - 42 * _p, titulo, 3.6 * _p * escala_texto(), 960 * _p, COR_AMARELO, COR_AZUL_ESCURO, 1);

	// Pontuação contando; dá um "pulso" quando chega ao valor final
	if (tempo >= t_contagem_ini) {
		var _pulso = 1;
		if (tempo >= t_contagem_fim) {
			_pulso = 1 + 0.15 * (1 - progresso(tempo, t_contagem_fim, t_contagem_fim + 400));
		}
		desenhar_texto(_fx, _fy + 46, "Sua pontuação foi: " + string(pontos_mostrados), 2.6 * _pulso * escala_texto(), 960, c_white, COR_AZUL_ESCURO, 1);
	}
}

// Confetes
for (var _c = 0; _c < array_length(confetes); _c++) {
	var _cf = confetes[_c];
	var _dx = lengthdir_x(_cf.w / 2, _cf.ang), _dy = lengthdir_y(_cf.w / 2, _cf.ang);
	var _hx = lengthdir_x(_cf.h / 2, _cf.ang + 90), _hy = lengthdir_y(_cf.h / 2, _cf.ang + 90);
	draw_set_colour(_cf.cor);
	draw_triangle(_cf.x - _dx - _hx, _cf.y - _dy - _hy, _cf.x + _dx - _hx, _cf.y + _dy - _hy, _cf.x + _dx + _hx, _cf.y + _dy + _hy, false);
	draw_triangle(_cf.x - _dx - _hx, _cf.y - _dy - _hy, _cf.x + _dx + _hx, _cf.y + _dy + _hy, _cf.x - _dx + _hx, _cf.y - _dy + _hy, false);
}
draw_set_colour(c_white);

// Botões (aparecem com pulo; crescem quando o mouse está em cima)
var _pb = suavizar_volta(progresso(tempo, t_botoes, t_botoes + 450));
if (_pb > 0) {
	for (var _b = 0; _b < array_length(botoes); _b++) {
		var _bt = botoes[_b];
		var _sb = _pb * (_bt.sobre ? 1.08 : 1);
		draw_sprite_ext(_bt.spr, 0, _bt.x, _bt.y, _sb, _sb, 0, c_white, 1);
	}
}

// Legenda sincronizada com a dublagem
if (cue_atual != -1) {
	var _cue = cues[cue_atual];
	var _alpha = min(progresso(tempo, _cue.ini, _cue.ini + 250), 1 - progresso(tempo, _cue.fim - 200, _cue.fim));
	desenhar_legenda(_cue.texto, max(_alpha, 0.15));
}
