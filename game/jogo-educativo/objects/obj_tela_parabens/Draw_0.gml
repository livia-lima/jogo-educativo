/// @description Fundo, confetes, quadro com placar e botões (layout do Figma)
draw_sprite(spr_bg_parabens, 0, 0, 0);

// Confetes (atrás do quadro e dos botões)
for (var _c = 0; _c < array_length(confetes); _c++) {
	var _cf = confetes[_c];
	var _dx = lengthdir_x(_cf.w / 2, _cf.ang), _dy = lengthdir_y(_cf.w / 2, _cf.ang);
	var _hx = lengthdir_x(_cf.h / 2, _cf.ang + 90), _hy = lengthdir_y(_cf.h / 2, _cf.ang + 90);
	draw_set_colour(_cf.cor);
	draw_triangle(_cf.x - _dx - _hx, _cf.y - _dy - _hy, _cf.x + _dx - _hx, _cf.y + _dy - _hy, _cf.x + _dx + _hx, _cf.y + _dy + _hy, false);
	draw_triangle(_cf.x - _dx - _hx, _cf.y - _dy - _hy, _cf.x + _dx + _hx, _cf.y + _dy + _hy, _cf.x - _dx + _hx, _cf.y - _dy + _hy, false);
}
draw_set_colour(c_white);

// Quadro (entra "pulando") com "Parabéns!" e a pontuação
var _p = suavizar_volta(progresso(tempo, t_titulo, t_titulo + 700));
if (_p > 0) {
	draw_sprite_ext(spr_frame_parabens, 0, 736, 145, 0.852 * _p, 0.852 * _p, 0, c_white, 1);

	// Largura útil dentro do quadro, já com a escala de entrada (_p): tira a borda
	// (80 px de cada lado) e a diferença entre o centro do quadro (x 736) e o do
	// título (x 683), para o texto não encostar na borda esquerda.
	var _larg_quadro = (sprite_get_width(spr_frame_parabens) * 0.852 - 160 - 2 * (736 - 683)) * _p;

	// Título: tamanho da acessibilidade, mas nunca maior que o quadro
	var _ft = fonte(FONTE_PIXELIFY, 72);
	var _esc_t = min(_p * min(escala_texto(), 1.15), _larg_quadro / max(1, largura_texto(titulo, _ft, 1)));
	texto_sombra(683, 92, titulo, _ft, _esc_t, COR_LARANJA, COR_AZUL_ESCURO, 4);

	if (tempo >= t_contagem_ini) {
		var _pulso = 1;
		if (tempo >= t_contagem_fim) _pulso = 1 + 0.12 * (1 - progresso(tempo, t_contagem_fim, t_contagem_fim + 400));
		var _f = fonte(FONTE_PIXELIFY, 60);
		var _rotulo = "Sua pontuação foi: ";
		var _num = string(pontos_mostrados);
		// Mede com a pontuação final (+12% do pulso) para o tamanho não mudar durante a contagem
		var _w_max = largura_texto(_rotulo, _f, 1) + largura_texto(string(pontos_final), _f, 1) * 1.12;
		var _esc = min(_p * min(escala_texto(), 1.15), _larg_quadro / max(1, _w_max));
		var _w1 = largura_texto(_rotulo, _f, _esc);
		var _w2 = largura_texto(_num, _f, _esc * _pulso);
		var _x0 = 712 - (_w1 + _w2) / 2;
		texto_sombra(_x0, 191, _rotulo, _f, _esc, COR_LARANJA, COR_AZUL_ESCURO, 4, fa_left);
		texto_sombra(_x0 + _w1, 191, _num, _f, _esc * _pulso, COR_VERMELHO, COR_AZUL_ESCURO, 4, fa_left);
		// Sublinhado vermelho embaixo do número
		var _uy = 191 + 40 * _esc;
		draw_set_colour(COR_VERMELHO);
		draw_rectangle(_x0 + _w1, _uy, _x0 + _w1 + _w2, _uy + 3, false);
		draw_set_colour(c_white);
	}
}

// Botões (aparecem com pulo; crescem quando o mouse está em cima)
var _pb = suavizar_volta(progresso(tempo, t_botoes, t_botoes + 450));
if (_pb > 0) {
	for (var _b = 0; _b < array_length(botoes); _b++) {
		var _bt = botoes[_b];
		var _sb = escala_botao * _pb * (_bt.sobre ? 1.08 : 1);
		draw_sprite_ext(_bt.spr, 0, _bt.x, _bt.y, _sb, _sb, 0, c_white, 1);
	}
}
