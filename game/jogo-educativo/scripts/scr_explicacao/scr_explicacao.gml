/// Funções compartilhadas das telas de Explicação (Fase 1 e Fase 2) e da tela Parabéns.
/// Responsável: João Vitor — layout conforme o Figma do projeto.
///
/// Legendas: cada "deixa" (cue) tem início e fim em milissegundos e o texto.
/// Nas telas de explicação o tempo é a posição do vídeo; na tela Parabéns é o
/// relógio da própria tela, que também dispara a voz e as animações.

#macro VIDEO_FASE1 "videos/fase1_explicacao.mp4"
#macro VIDEO_FASE2 "videos/fase2_explicacao.mp4"

// Fontes do Figma (Included Files, licença OFL)
#macro FONTE_PIXELIFY "fonts/PixelifySans.ttf"
#macro FONTE_PRESS "fonts/PressStart2P.ttf"

// Player de vídeo (medidas do Figma convertidas para a sala 1366x768)
#macro PLAYER_X 296
#macro PLAYER_W 822
#macro PLAYER_H 519
#macro PLAYER_BARRA_H 54

// Botões Voltar / Continuar: tamanho da parte visível de spr_botao_seta
#macro SETA_W 171
#macro SETA_H 182

// Caixa de legenda
#macro LEGENDA_X 164
#macro LEGENDA_Y 631
#macro LEGENDA_W 1097
#macro LEGENDA_H 125

// Cores
#macro COR_VERDE make_colour_rgb(82, 182, 154)
#macro COR_VERDE_CLARO make_colour_rgb(217, 237, 146)
#macro COR_LARANJA make_colour_rgb(243, 114, 44)
#macro COR_AMARELO make_colour_rgb(249, 199, 79)
#macro COR_VERMELHO make_colour_rgb(249, 65, 68)
#macro COR_AZUL_ESCURO make_colour_rgb(24, 78, 119)
#macro COR_PLAYER make_colour_rgb(58, 58, 58)
#macro COR_PLAYER_BARRA make_colour_rgb(44, 44, 44)

// ---------------------------------------------------------------- Legendas

/// Cria uma deixa de legenda.
function legenda(_ini, _fim, _texto, _voz = "") {
	return { ini: _ini, fim: _fim, texto: _texto, voz: _voz, tocada: false };
}

/// Legendas do vídeo da tela 6 — Fase 1 Explicação.
/// Preencha quando o vídeo estiver pronto: tempos em milissegundos, contados
/// a partir do início do vídeo. Exemplo:
///   legenda(0, 4000, "Vamos jogar! Ligue a palavra à imagem certa."),
function legendas_fase1() {
	return [
	];
}

/// Legendas do vídeo da tela 9 — Fase 2 Explicação (mesmo formato da Fase 1).
function legendas_fase2() {
	return [
	];
}

/// Retorna o índice da deixa ativa no tempo _t (ms) ou -1.
function legenda_indice(_cues, _t) {
	for (var _i = 0; _i < array_length(_cues); _i++) {
		if (_t >= _cues[_i].ini && _t < _cues[_i].fim) return _i;
	}
	return -1;
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

/// Fonte carregada de Included Files no tamanho pedido (com cache).
/// Retorna -1 se o arquivo não existir (aí usa a fonte padrão, sem acentos).
function fonte(_arquivo, _tamanho) {
	if (!variable_global_exists("fontes_cache")) global.fontes_cache = {};
	var _k = _arquivo + "#" + string(_tamanho);
	if (!variable_struct_exists(global.fontes_cache, _k)) {
		var _f = -1;
		if (file_exists(_arquivo)) {
			font_add_enable_aa(false); // pixel art nítido
			_f = font_add(_arquivo, _tamanho, false, false, 32, 255);
			font_add_enable_aa(true);
		}
		global.fontes_cache[$ _k] = _f;
	}
	return global.fontes_cache[$ _k];
}

/// A fonte padrão do GameMaker só tem ASCII: troca letras acentuadas.
function sem_acentos(_s) {
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

/// Seleciona a fonte e devolve o texto pronto para ela.
function preparar_texto(_f, _txt) {
	if (_f != -1) {
		draw_set_font(_f);
		return _txt;
	}
	return sem_acentos(_txt);
}

/// Texto com sombra deslocada (estilo do Figma). _halign: fa_left/fa_center/fa_right.
/// _largura > 0 quebra linhas. Retorna a largura desenhada.
function texto_sombra(_x, _y, _txt, _f, _escala, _cor, _sombra, _desloc, _halign = fa_center, _largura = -1, _alpha = 1) {
	_txt = preparar_texto(_f, _txt);
	draw_set_halign(_halign);
	draw_set_valign(fa_middle);
	draw_set_alpha(_alpha);
	var _sep = string_height("Ag");
	var _w = (_largura > 0) ? _largura / _escala : 100000;
	if (_desloc > 0) {
		draw_set_colour(_sombra);
		draw_text_ext_transformed(_x + _desloc, _y + _desloc, _txt, _sep, _w, _escala, _escala, 0);
	}
	draw_set_colour(_cor);
	draw_text_ext_transformed(_x, _y, _txt, _sep, _w, _escala, _escala, 0);
	var _larg = min(string_width(_txt), _w) * _escala;
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	return _larg;
}

/// Largura que um texto terá com a fonte e escala dadas.
function largura_texto(_txt, _f, _escala) {
	_txt = preparar_texto(_f, _txt);
	return string_width(_txt) * _escala;
}

// ---------------------------------------------------------------- Interação

function mouse_sobre(_x, _y, _w, _h) {
	return point_in_rectangle(mouse_x, mouse_y, _x - _w / 2, _y - _h / 2, _x + _w / 2, _y + _h / 2);
}

function clicou_em(_x1, _y1, _x2, _y2) {
	return mouse_check_button_pressed(mb_left) && point_in_rectangle(mouse_x, mouse_y, _x1, _y1, _x2, _y2);
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

// ---------------------------------------------------------------- Player de vídeo

/// "mm:ss" a partir de milissegundos.
function formatar_tempo(_ms) {
	var _s = floor(max(0, _ms) / 1000);
	var _m = _s div 60;
	_s = _s mod 60;
	return string(_m) + ":" + ((_s < 10) ? "0" : "") + string(_s);
}

/// Desenha o quadro do vídeo dentro da área, mantendo a proporção.
function desenhar_video_na_area(_surf, _x, _y, _w, _h) {
	var _sw = surface_get_width(_surf), _sh = surface_get_height(_surf);
	var _s = min(_w / _sw, _h / _sh);
	var _dw = _sw * _s, _dh = _sh * _s;
	draw_surface_stretched(_surf, _x + (_w - _dw) / 2, _y + (_h - _dh) / 2, _dw, _dh);
}

/// Botão grande de play (anel branco com triângulo), como no Figma.
function desenhar_play_grande(_cx, _cy, _alpha) {
	draw_set_alpha(_alpha);
	draw_set_colour(c_white);
	for (var _r = 0; _r < 5; _r++) draw_circle(_cx, _cy, 62 - _r, true);
	draw_triangle(_cx - 20, _cy - 34, _cx - 20, _cy + 34, _cx + 38, _cy, false);
	draw_set_alpha(1);
}

/// Ícones da barra de controles (brancos, centro em _x,_y).
function icone_play(_x, _y) { draw_triangle(_x - 9, _y - 12, _x - 9, _y + 12, _x + 12, _y, false); }
function icone_pausa(_x, _y) {
	draw_rectangle(_x - 9, _y - 11, _x - 3, _y + 11, false);
	draw_rectangle(_x + 3, _y - 11, _x + 9, _y + 11, false);
}
function icone_anterior(_x, _y) {
	draw_rectangle(_x - 11, _y - 11, _x - 8, _y + 11, false);
	draw_triangle(_x + 11, _y - 12, _x + 11, _y + 12, _x - 7, _y, false);
}
function icone_proximo(_x, _y) {
	draw_triangle(_x - 11, _y - 12, _x - 11, _y + 12, _x + 7, _y, false);
	draw_rectangle(_x + 8, _y - 11, _x + 11, _y + 11, false);
}
function icone_volume(_x, _y, _mudo) {
	draw_rectangle(_x - 11, _y - 5, _x - 5, _y + 5, false);
	draw_triangle(_x - 5, _y - 5, _x + 5, _y - 12, _x + 5, _y + 12, false);
	draw_triangle(_x - 5, _y - 5, _x + 5, _y + 12, _x - 5, _y + 5, false);
	if (_mudo) {
		draw_set_colour(COR_VERMELHO);
		draw_line_width(_x - 13, _y - 13, _x + 9, _y + 13, 3);
		draw_set_colour(c_white);
	}
}
function icone_tela_cheia(_x, _y) {
	var _a = 12, _l = 7, _e = 3;
	draw_rectangle(_x - _a, _y - _a, _x - _a + _l, _y - _a + _e, false);
	draw_rectangle(_x - _a, _y - _a, _x - _a + _e, _y - _a + _l, false);
	draw_rectangle(_x + _a - _l, _y - _a, _x + _a, _y - _a + _e, false);
	draw_rectangle(_x + _a - _e, _y - _a, _x + _a, _y - _a + _l, false);
	draw_rectangle(_x - _a, _y + _a - _e, _x - _a + _l, _y + _a, false);
	draw_rectangle(_x - _a, _y + _a - _l, _x - _a + _e, _y + _a, false);
	draw_rectangle(_x + _a - _l, _y + _a - _e, _x + _a, _y + _a, false);
	draw_rectangle(_x + _a - _e, _y + _a - _l, _x + _a, _y + _a, false);
}

/// Caixa de legenda (sempre visível, como no Figma); o texto aparece quando há fala.
function desenhar_caixa_legenda(_texto, _alpha) {
	draw_sprite_stretched(spr_caixa_legenda, 0, LEGENDA_X, LEGENDA_Y, LEGENDA_W, LEGENDA_H);
	if (_texto != "") {
		texto_sombra(LEGENDA_X + LEGENDA_W / 2, LEGENDA_Y + LEGENDA_H / 2, _texto, fonte(FONTE_PRESS, 20), escala_texto(),
			COR_AMARELO, c_black, 3, fa_center, LEGENDA_W - 90, _alpha);
	}
}
