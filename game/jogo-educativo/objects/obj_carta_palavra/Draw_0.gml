
/// obj_carta_palavra - DRAW
/// Feedback visual de acerto e erro.

if (associada && acerto_frames <= 0) {
    exit;
}

// =====================================
// 1. DIMENSOES DO CARTAO
// =====================================

var _w = room_width * 0.39;
var _h = room_height * 0.105;

var _esquerda = x - _w / 2;
var _direita = x + _w / 2;
var _topo = y - _h / 2;
var _baixo = y + _h / 2;

// =====================================
// 2. CORES E MENSAGENS
// =====================================

var _cor_borda = make_color_rgb(22, 66, 67);
var _cor_fundo = make_color_rgb(37, 80, 83);

var _texto_exibido = texto;

// Acerto
if (acerto_frames > 0) {

    _cor_borda = make_color_rgb(38, 180, 105);
    _cor_fundo = make_color_rgb(36, 115, 79);

    _texto_exibido = "CERTO!";
}

// Erro
else if (erro_frames > 0) {

    _cor_borda = make_color_rgb(220, 80, 90);
    _cor_fundo = make_color_rgb(130, 55, 65);

    _texto_exibido = "TENTE DE NOVO";
}

// =====================================
// 3. DESENHAR CARTAO
// =====================================

draw_set_alpha(1);

draw_set_color(_cor_borda);

draw_roundrect(
    _esquerda - 2,
    _topo - 2,
    _direita + 2,
    _baixo + 2,
    false
);

draw_set_color(_cor_fundo);

draw_roundrect(
    _esquerda,
    _topo,
    _direita,
    _baixo,
    false
);

// =====================================
// 4. CONFIGURAR FONTE
// =====================================

if (
    fonte_cartao != -1
    && font_exists(fonte_cartao)
) {
    draw_set_font(fonte_cartao);
} else {
    draw_set_font(-1);
}

// =====================================
// 5. ESCALA DO TEXTO
// =====================================

var _acessibilidade = 1;

if (variable_global_exists("escala_fonte")) {
    _acessibilidade = max(
        0.5,
        global.escala_fonte
    );
}

var _largura_texto = max(
    1,
    string_width(_texto_exibido)
);

var _altura_texto = max(
    1,
    string_height(_texto_exibido)
);

var _escala = min(
    _acessibilidade,
    (_w - 20) / _largura_texto,
    (_h - 10) / _altura_texto
);

// =====================================
// 6. DESENHAR TEXTO
// =====================================

draw_set_color(c_white);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(
    x,
    y,
    _texto_exibido,
    _escala,
    _escala,
    0
);

// =====================================
// 7. RESTAURAR CONFIGURACOES
// =====================================

draw_set_font(-1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_color(c_white);
draw_set_alpha(1);
