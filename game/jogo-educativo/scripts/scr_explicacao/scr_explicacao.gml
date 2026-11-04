/// Funções compartilhadas das telas de Explicação (Fase 1 e Fase 2) e da tela Parabéns.
/// Responsável: João Vitor
///
/// Legendas: cada "deixa" (cue) tem início e fim em milissegundos, o texto
/// e, opcionalmente, o nome de um som de voz (dublagem) tocado quando ela começa.
/// O mesmo relógio (ms) controla legenda, voz e animação, então tudo fica sincronizado.

#macro VIDEO_FASE1 "videos/fase1_explicacao.mp4"
#macro VIDEO_FASE2 "videos/fase2_explicacao.mp4"
#macro FONTE_JOGO_ARQUIVO "fonts/fonte_jogo.ttf"

// Paleta (Coolors do README)
#macro COR_VERDE_ESCURO make_colour_rgb(30, 96, 145)
#macro COR_VERDE make_colour_rgb(82, 182, 154)
#macro COR_VERDE_CLARO make_colour_rgb(217, 237, 146)
#macro COR_LARANJA make_colour_rgb(243, 114, 44)
#macro COR_AMARELO make_colour_rgb(249, 199, 79)
#macro COR_VERMELHO make_colour_rgb(249, 65, 68)
#macro COR_AZUL_ESCURO make_colour_rgb(24, 78, 119)

/// Cria uma deixa de legenda.
function legenda(_ini, _fim, _texto, _voz = "") {
	return { ini: _ini, fim: _fim, texto: _texto, voz: _voz, tocada: false };
}

/// Roteiro da tela 6 — Fase 1 Explicação (palavra x imagem).
function legendas_fase1() {
	return [
		legenda(    0,  4000, "Vamos jogar! Nesta fase você liga a PALAVRA à IMAGEM certa."),
		legenda( 4000,  8500, "Pegue a palavra e arraste até a figura que combina com ela."),
		legenda( 8500, 12000, "Bicicleta! Você acertou e ganhou uma moeda!", "snd_voz_bicicleta"),
		legenda(12000, 16000, "Errou? Tudo bem! A palavra volta e você tenta de novo."),
		legenda(16000, 19500, "Precisa de ajuda? Toque no botão de dica.", "snd_voz_dica"),
	];
}

/// Roteiro da tela 9 — Fase 2 Explicação (contagem x número).
function legendas_fase2() {
	return [
		legenda(    0,  4000, "Agora é hora de CONTAR!"),
		legenda( 4000,  8000, "Olhe a cena e conte quantos objetos aparecem."),
		legenda( 8000,  9000, "Um...", "snd_voz_um"),
		legenda( 9000, 10000, "Dois...", "snd_voz_dois"),
		legenda(10000, 11500, "Três!", "snd_voz_tres"),
		legenda(11500, 15500, "Depois, toque no número certo. Aqui são 3 bicicletas!"),
		legenda(15500, 19500, "Toque em um objeto para ouvir a contagem em voz alta."),
	];
}

/// Retorna o índice da deixa ativa no tempo _t (ms) ou -1.
function legenda_indice(_cues, _t) {
	for (var _i = 0; _i < array_length(_cues); _i++) {
		if (_t >= _cues[_i].ini && _t < _cues[_i].fim) return _i;
	}
	return -1;
}

/// Duração total (ms) de um roteiro.
function legendas_duracao(_cues) {
	var _n = array_length(_cues);
	return (_n > 0) ? _cues[_n - 1].fim : 0;
}

/// Marca todas as deixas como não tocadas (para "ver de novo").
function legendas_reiniciar(_cues) {
	for (var _i = 0; _i < array_length(_cues); _i++) _cues[_i].tocada = false;
}

// ---------------------------------------------------------------- Áudio

function obter_volume() {
	return variable_global_exists("volume_jogo") ? global.volume_jogo : 1;
}

/// Toca um som de voz pelo nome do recurso. Se o som não existir, não faz nada.
function tocar_voz(_nome) {
	if (_nome == "") return -1;
	var _snd = asset_get_index(_nome);
	if (_snd == -1 || asset_get_type(_nome) != asset_sound) return -1;
	return audio_play_sound(_snd, 10, false, obter_volume());
}

// ---------------------------------------------------------------- Texto

/// Fonte com acentos carregada de Included Files (datafiles/fonts/fonte_jogo.ttf).
/// Sem o arquivo, usa a fonte padrão (sem acentos) e o texto é "desacentuado".
function fonte_jogo() {
	if (!variable_global_exists("fonte_jogo_id")) {
		global.fonte_jogo_id = -1;
		if (file_exists(FONTE_JOGO_ARQUIVO)) {
			global.fonte_jogo_id = font_add(FONTE_JOGO_ARQUIVO, 14, true, false, 32, 255);
		}
	}
	return global.fonte_jogo_id;
}

/// A fonte padrão do GameMaker só tem ASCII: troca letras acentuadas.
function texto_seguro(_s) {
	if (fonte_jogo() != -1) return _s;
	var _de   = "áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ";
	var _para = "aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC";
	for (var _i = 1; _i <= string_length(_de); _i++) {
		_s = string_replace_all(_s, string_char_at(_de, _i), string_char_at(_para, _i));
	}
	return _s;
}

/// Multiplicador de fonte escolhido no menu de acessibilidade (1.0 a 2.0).
function escala_texto() {
	return variable_global_exists("escala_fonte") ? global.escala_fonte : 1;
}

/// Desenha texto centralizado, com contorno (alto contraste) e quebra de linha.
function desenhar_texto(_x, _y, _txt, _escala, _largura, _cor, _contorno, _alpha) {
	var _f = fonte_jogo();
	if (_f != -1) draw_set_font(_f);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	_txt = texto_seguro(_txt);
	var _sep = string_height("Ag") * 1.15;
	var _w = _largura / _escala;
	var _o = max(2, round(_escala * 1.2));
	draw_set_alpha(_alpha);
	draw_set_colour(_contorno);
	for (var _dx = -1; _dx <= 1; _dx++) {
		for (var _dy = -1; _dy <= 1; _dy++) {
			if (_dx != 0 || _dy != 0) {
				draw_text_ext_transformed(_x + _dx * _o, _y + _dy * _o, _txt, _sep, _w, _escala, _escala, 0);
			}
		}
	}
	draw_set_colour(_cor);
	draw_text_ext_transformed(_x, _y, _txt, _sep, _w, _escala, _escala, 0);
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

/// Caixa de legenda na parte de baixo da tela.
function desenhar_legenda(_texto, _alpha) {
	if (_texto == "") return;
	var _w = sprite_get_width(spr_caixa_legenda);
	var _h = sprite_get_height(spr_caixa_legenda);
	var _x = (room_width - _w) / 2;
	var _y = room_height - _h - 10;
	draw_sprite_ext(spr_caixa_legenda, 0, _x, _y, 1, 1, 0, c_white, _alpha * 0.95);
	desenhar_texto(room_width / 2, _y + _h / 2, _texto, 2.2 * escala_texto(), _w - 120, c_black, c_white, _alpha);
}

// ---------------------------------------------------------------- Botões

function mouse_sobre(_x, _y, _w, _h) {
	return point_in_rectangle(mouse_x, mouse_y, _x - _w / 2, _y - _h / 2, _x + _w / 2, _y + _h / 2);
}

/// Botão desenhado por código (centro em _x,_y). Retorna true se foi clicado.
function botao_texto(_x, _y, _w, _h, _texto, _cor) {
	var _sobre = mouse_sobre(_x, _y, _w, _h);
	var _s = _sobre ? 1.06 : 1;
	var _bw = _w * _s / 2, _bh = _h * _s / 2;
	draw_set_colour(COR_AZUL_ESCURO);
	draw_roundrect_ext(_x - _bw - 4, _y - _bh - 4, _x + _bw + 4, _y + _bh + 6, 24, 24, false);
	draw_set_colour(_sobre ? merge_colour(_cor, c_white, 0.2) : _cor);
	draw_roundrect_ext(_x - _bw, _y - _bh, _x + _bw, _y + _bh, 20, 20, false);
	draw_set_colour(c_white);
	desenhar_texto(_x, _y, _texto, 2 * _s, _w, c_white, COR_AZUL_ESCURO, 1);
	return _sobre && mouse_check_button_pressed(mb_left);
}

// ---------------------------------------------------------------- Animação

function suavizar(_t) {
	_t = clamp(_t, 0, 1);
	return (_t < 0.5) ? 2 * _t * _t : 1 - power(-2 * _t + 2, 2) / 2;
}

/// Easing com leve "passada" do alvo (efeito de pulo ao aparecer).
function suavizar_volta(_t) {
	_t = clamp(_t, 0, 1);
	var _c1 = 1.70158;
	var _c3 = _c1 + 1;
	return 1 + _c3 * power(_t - 1, 3) + _c1 * power(_t - 1, 2);
}

/// Progresso 0..1 de _t dentro do intervalo [_ini, _fim].
function progresso(_t, _ini, _fim) {
	return clamp((_t - _ini) / max(1, _fim - _ini), 0, 1);
}

/// Ponteiro (seta) usado nas demonstrações.
function desenhar_ponteiro(_x, _y) {
	draw_set_colour(c_black);
	draw_triangle(_x - 3, _y - 4, _x - 3, _y + 40, _x + 30, _y + 28, false);
	draw_set_colour(c_white);
	draw_triangle(_x, _y, _x, _y + 32, _x + 23, _y + 24, false);
}

/// Bicicleta simples desenhada com formas (usada nas demonstrações).
function desenhar_bicicleta(_x, _y, _s, _cor) {
	draw_set_colour(c_black);
	draw_circle(_x - 26 * _s, _y + 10 * _s, 16 * _s, true);
	draw_circle(_x + 26 * _s, _y + 10 * _s, 16 * _s, true);
	draw_circle(_x - 26 * _s, _y + 10 * _s, 15 * _s, true);
	draw_circle(_x + 26 * _s, _y + 10 * _s, 15 * _s, true);
	draw_set_colour(_cor);
	draw_line_width(_x - 26 * _s, _y + 10 * _s, _x - 4 * _s, _y - 12 * _s, 4 * _s);
	draw_line_width(_x - 4 * _s, _y - 12 * _s, _x + 20 * _s, _y - 12 * _s, 4 * _s);
	draw_line_width(_x + 20 * _s, _y - 12 * _s, _x + 26 * _s, _y + 10 * _s, 4 * _s);
	draw_line_width(_x - 26 * _s, _y + 10 * _s, _x, _y + 10 * _s, 4 * _s);
	draw_line_width(_x, _y + 10 * _s, _x - 4 * _s, _y - 12 * _s, 4 * _s);
	draw_line_width(_x, _y + 10 * _s, _x + 20 * _s, _y - 12 * _s, 4 * _s);
	draw_set_colour(c_black);
	draw_line_width(_x - 10 * _s, _y - 18 * _s, _x + 2 * _s, _y - 18 * _s, 4 * _s);
	draw_line_width(_x + 16 * _s, _y - 22 * _s, _x + 26 * _s, _y - 22 * _s, 4 * _s);
	draw_set_colour(c_white);
}

/// Cartão de palavra (Fase 1).
function desenhar_cartao(_x, _y, _texto, _cor_borda) {
	draw_set_colour(_cor_borda);
	draw_roundrect_ext(_x - 112, _y - 34, _x + 112, _y + 34, 16, 16, false);
	draw_set_colour(c_white);
	draw_roundrect_ext(_x - 106, _y - 28, _x + 106, _y + 28, 12, 12, false);
	desenhar_texto(_x, _y, _texto, 2, 210, c_black, c_white, 1);
}

/// Demonstração animada da Fase 1 (usada quando não há vídeo).
function demo_fase1(_t) {
	var _cx = room_width / 2, _cy = 300;
	var _a = progresso(_t, 0, 600);
	var _px = _cx - 360, _py = _cy - 170;
	draw_set_alpha(0.92 * _a);
	draw_set_colour(c_white);
	draw_roundrect_ext(_px, _py, _px + 720, _py + 340, 30, 30, false);
	draw_set_alpha(1);
	if (_a < 1) return;

	// Coluna de imagens (esquerda) e de palavras (direita)
	var _img_x = _cx - 180, _img_y = _cy;
	var _alvo_ok = (_t >= 7500);
	draw_set_colour(_alvo_ok ? COR_VERDE : COR_VERDE_CLARO);
	draw_roundrect_ext(_img_x - 110, _img_y - 110, _img_x + 110, _img_y + 110, 20, 20, false);
	desenhar_bicicleta(_img_x, _img_y - 20, 1.6, COR_LARANJA);

	var _bob = sin(current_time / 300) * 4;
	var _c1_ini_x = _cx + 200, _c1_ini_y = _cy - 70;
	var _c2_ini_x = _cx + 200, _c2_ini_y = _cy + 70;

	// Cartão "BICICLETA": arrastado até a imagem (4.5s a 7.5s)
	var _p1 = suavizar(progresso(_t, 4500, 7500));
	var _c1x = lerp(_c1_ini_x, _img_x, _p1);
	var _c1y = lerp(_c1_ini_y + _bob, _img_y + 70, _p1);

	// Cartão "CARRO": vai até a imagem e volta suave (erro, 12.5s a 15.5s)
	var _ida = suavizar(progresso(_t, 12500, 13800));
	var _volta = suavizar(progresso(_t, 14300, 15500));
	var _p2 = _ida - _volta;
	var _treme = (_t >= 13800 && _t < 14300) ? sin(_t / 25) * 8 : 0;
	var _c2x = lerp(_c2_ini_x, _img_x + 40, _p2) + _treme;
	var _c2y = lerp(_c2_ini_y - _bob, _img_y - 40, _p2);
	var _erro = (_t >= 13800 && _t < 14600);

	if (_t < 12000) {
		desenhar_cartao(_c2x, _c2y, "CARRO", COR_AZUL_ESCURO);
		desenhar_cartao(_c1x, _c1y, "BICICLETA", _alvo_ok ? COR_VERDE : COR_AZUL_ESCURO);
	} else {
		desenhar_cartao(_c1x, _c1y, "BICICLETA", COR_VERDE);
		desenhar_cartao(_c2x, _c2y, "CARRO", _erro ? COR_VERMELHO : COR_AZUL_ESCURO);
	}

	// Moeda subindo depois do acerto (7.5s a 9.5s)
	if (_t >= 7500 && _t < 9500) {
		var _m = progresso(_t, 7500, 9500);
		var _my = _img_y - 120 - _m * 80;
		draw_set_alpha(1 - _m);
		draw_set_colour(COR_AMARELO);
		draw_circle(_img_x + 90, _my, 26, false);
		draw_set_colour(COR_LARANJA);
		draw_circle(_img_x + 90, _my, 26, true);
		draw_set_alpha(1);
		desenhar_texto(_img_x + 90, _my, "+50", 1.6, 80, c_black, COR_AMARELO, 1 - _m);
	}

	// Ponteiro acompanha o cartão que está sendo arrastado
	if (_t >= 4000 && _t < 8000) desenhar_ponteiro(_c1x + 20, _c1y + 10);
	if (_t >= 12000 && _t < 14300) desenhar_ponteiro(_c2x + 20, _c2y + 10);

	// Botão de dica piscando (16s em diante)
	if (_t >= 16000) {
		var _pulso = 1 + sin(current_time / 150) * 0.08;
		var _dx = _px + 660, _dy = _py + 50;
		draw_set_colour(COR_AMARELO);
		draw_circle(_dx, _dy, 34 * _pulso, false);
		draw_set_colour(COR_LARANJA);
		draw_circle(_dx, _dy, 34 * _pulso, true);
		desenhar_texto(_dx, _dy, "?", 3 * _pulso, 60, c_white, COR_LARANJA, 1);
		desenhar_ponteiro(_dx + 10, _dy + 10);
	}
	draw_set_colour(c_white);
}

/// Demonstração animada da Fase 2 (usada quando não há vídeo).
function demo_fase2(_t) {
	var _cx = room_width / 2, _cy = 300;
	var _a = progresso(_t, 0, 600);
	var _px = _cx - 400, _py = _cy - 170;
	draw_set_alpha(0.92 * _a);
	draw_set_colour(c_white);
	draw_roundrect_ext(_px, _py, _px + 800, _py + 340, 30, 30, false);
	draw_set_alpha(1);
	if (_a < 1) return;

	// Três bicicletas na cena; cada uma acende quando é contada
	var _marcos = [8000, 9000, 10000];
	for (var _i = 0; _i < 3; _i++) {
		var _bx = _px + 120 + _i * 170;
		var _by = _cy - 10 + ((_i == 1) ? -40 : 30);
		var _contada = (_t >= _marcos[_i]);
		var _pop = _contada ? 1 + 0.25 * (1 - progresso(_t, _marcos[_i], _marcos[_i] + 300)) : 1;
		if (_contada) {
			draw_set_colour(COR_VERDE_CLARO);
			draw_circle(_bx, _by, 62 * _pop, false);
		}
		desenhar_bicicleta(_bx, _by, 1.2 * _pop, COR_VERDE);
		if (_contada) {
			desenhar_texto(_bx, _by - 70, string(_i + 1), 3, 60, COR_LARANJA, c_white, 1);
		}
		// Ponteiro "tocando" cada bicicleta durante a contagem
		if (_t >= _marcos[_i] - 300 && _t < _marcos[_i] + 700 && _t < 11500) {
			desenhar_ponteiro(_bx + 10, _by + 10);
		}
	}

	// Opções de número na lateral
	var _ops = [2, 3, 4];
	var _escolha = (_t >= 13500);
	for (var _j = 0; _j < 3; _j++) {
		var _nx = _px + 700, _ny = _py + 70 + _j * 100;
		var _certo = _escolha && (_ops[_j] == 3);
		draw_set_colour(_certo ? COR_VERDE : COR_AZUL_ESCURO);
		draw_roundrect_ext(_nx - 44, _ny - 40, _nx + 44, _ny + 40, 18, 18, false);
		desenhar_texto(_nx, _ny, string(_ops[_j]), 3.5, 80, c_white, c_black, 1);
	}

	// Ponteiro vai até o número 3 (11.5s a 13.5s)
	if (_t >= 11500 && _t < 15500) {
		var _p = suavizar(progresso(_t, 11500, 13300));
		desenhar_ponteiro(lerp(_px + 460, _px + 700, _p), lerp(_cy + 120, _py + 170, _p));
	}

	// Dica de acessibilidade: "toque para ouvir"
	if (_t >= 15500) {
		var _bx2 = _px + 120;
		var _by2 = _cy + 20;
		var _onda = (current_time mod 900) / 900;
		draw_set_alpha(1 - _onda);
		draw_set_colour(COR_LARANJA);
		draw_circle(_bx2, _by2, 40 + _onda * 50, true);
		draw_circle(_bx2, _by2, 41 + _onda * 50, true);
		draw_set_alpha(1);
		desenhar_ponteiro(_bx2 + 10, _by2 + 10);
	}
	draw_set_colour(c_white);
}
