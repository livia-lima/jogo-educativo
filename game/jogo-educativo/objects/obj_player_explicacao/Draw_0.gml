/// @description Fundo, player de vídeo (layout do Figma) e caixa de legenda
draw_sprite(fundo, 0, 0, 0);

var _px = PLAYER_X, _py = player_y, _pw = PLAYER_W, _ph = PLAYER_H;
var _area_h = _ph - PLAYER_BARRA_H;
var _by = _py + _ph - PLAYER_BARRA_H / 2;

// Área do vídeo
draw_set_colour(COR_PLAYER);
draw_rectangle(_px, _py, _px + _pw, _py + _ph, false);
if (usando_video) {
	var _v = video_draw();
	if (_v[0] == 0 && surface_exists(_v[1])) desenhar_video_na_area(_v[1], _px, _py, _pw, _area_h);
}
if (!tocando) desenhar_play_grande(_px + _pw / 2, _py + _area_h / 2, 1);

// Barra de controles
draw_set_colour(COR_PLAYER_BARRA);
draw_rectangle(_px, _py + _area_h, _px + _pw, _py + _ph, false);
draw_set_colour(c_white);
if (tocando) icone_pausa(_px + 22, _by); else icone_play(_px + 22, _by);
icone_anterior(_px + 55, _by);
icone_proximo(_px + 90, _by);

var _f = fonte(FONTE_PIXELIFY, 12);
texto_sombra(_px + 110, _by, formatar_tempo(tempo), _f, 1, c_white, c_black, 0, fa_left);

// Barra de progresso: parte assistida (branca), restante (cinza) e marcador
var _bx1 = _px + 155, _bx2 = _px + 630;
var _p = (duracao > 0) ? clamp(tempo / duracao, 0, 1) : 0;
var _mx = lerp(_bx1, _bx2, _p);
draw_set_colour(make_colour_rgb(110, 110, 110));
draw_rectangle(_bx1, _by - 3, _bx2, _by + 3, false);
draw_set_colour(c_white);
draw_rectangle(_bx1, _by - 3, _mx, _by + 3, false);
draw_circle(_mx, _by, 9, false);

texto_sombra(_px + 642, _by, formatar_tempo(duracao), _f, 1, c_white, c_black, 0, fa_left);
texto_sombra(_px + 680, _by, "HD", _f, 1, c_white, c_black, 0, fa_left);

// Volume: ícone + 5 barrinhas (preenchidas conforme o volume)
icone_volume(_px + 716, _by, mudo);
var _nivel = mudo ? 0 : round(obter_volume() * 5);
for (var _i = 0; _i < 5; _i++) {
	draw_set_colour((_i < _nivel) ? c_white : make_colour_rgb(110, 110, 110));
	draw_rectangle(_px + 731 + _i * 9, _by - 6, _px + 737 + _i * 9, _by + 6, false);
}
draw_set_colour(c_white);
icone_tela_cheia(_px + 799, _by);

// Botões Voltar / Continuar (crescem quando o mouse está em cima)
var _fb = fonte(FONTE_PIXELIFY, 32);
for (var _b = 0; _b < array_length(botoes); _b++) {
	var _bt = botoes[_b];
	var _s = escala_seta * (_bt.sobre ? 1.08 : 1);
	draw_sprite_ext(spr_botao_seta, 0, _bt.x, _bt.y, _s * _bt.lado, _s, 0, c_white, 1);
	texto_sombra(_bt.x, _bt.y + SETA_H * escala_seta / 2 + 26, _bt.rotulo, _fb, escala_texto(), c_white, COR_AZUL_ESCURO, 3);
}

// Legenda
var _texto = "", _alpha = 1;
if (cue_atual != -1) {
	var _c = cues[cue_atual];
	_texto = _c.texto;
	_alpha = max(0.15, min(progresso(tempo, _c.ini, _c.ini + 250), 1 - progresso(tempo, _c.fim - 200, _c.fim)));
}
desenhar_caixa_legenda(_texto, _alpha);
