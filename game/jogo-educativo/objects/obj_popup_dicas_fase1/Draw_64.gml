
/// obj_popup_dicas_fase1 - DRAW GUI

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// =====================================
// 1. ESCURECER O JOGO AO FUNDO
// =====================================

draw_set_alpha(0.75);
draw_set_color(c_black);

draw_rectangle(0, 0, _gw, _gh, false);

draw_set_alpha(1);

// =====================================
// 2. JANELA DO POPUP
// =====================================

var _w = _gw * 0.78;
var _h = _gh * 0.75;

var _px = (_gw - _w) / 2;
var _py = (_gh - _h) / 2;

// Borda
draw_set_color(make_color_rgb(53, 112, 101));

draw_roundrect(
    _px - 3,
    _py - 3,
    _px + _w + 3,
    _py + _h + 3,
    false
);

// Fundo
draw_set_color(make_color_rgb(24, 49, 48));

draw_roundrect(
    _px,
    _py,
    _px + _w,
    _py + _h,
    false
);

// =====================================
// 3. BOTAO FECHAR
// =====================================

var _bx = _px + 12;
var _by = _py + 10;

draw_set_color(make_color_rgb(135, 57, 65));

draw_roundrect(
    _bx,
    _by,
    _bx + 38,
    _by + 38,
    false
);

draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(_bx + 19, _by + 19, "X");

// =====================================
// 4. TITULO
// =====================================

draw_text(
    _px + _w / 2,
    _py + 29,
    "DICAS"
);

// =====================================
// 5. AREA DO VIDEO
// =====================================

var _vx = _px + 18;
var _vy = _py + 58;
var _vw = _w - 36;
var _vh = _h - 76;

draw_set_color(c_black);

draw_rectangle(
    _vx, _vy,
    _vx + _vw, _vy + _vh,
    false
);

// =====================================
// 6. REPRODUZIR VIDEO
// =====================================

var _desenhou = false;

if (video_aberto) {

    var _dados = video_draw();

    if (
        array_length(_dados) > 1
        && _dados[0] == 0
        && surface_exists(_dados[1])
    ) {

        var _surf = _dados[1];

        // Preservar a proporcao do video
        var _sw = surface_get_width(_surf);
        var _sh = surface_get_height(_surf);

        var _escala = min(
            _vw / _sw,
            _vh / _sh
        );

        var _dw = _sw * _escala;
        var _dh = _sh * _escala;

        draw_set_color(c_white);

        draw_surface_stretched(
            _surf,
            _vx + (_vw - _dw) / 2,
            _vy + (_vh - _dh) / 2,
            _dw,
            _dh
        );

        _desenhou = true;
    }
}

// Mensagem se nao houver video disponivel
if (!_desenhou) {

    draw_set_color(c_white);

    if (video_aberto) {
        draw_text(
            _gw / 2,
            _vy + _vh / 2,
            "CARREGANDO VIDEO..."
        );
    } else {
        draw_text(
            _gw / 2,
            _vy + _vh / 2,
            "VIDEO NAO ENCONTRADO"
        );
    }
}

// =====================================
// 7. RESTAURAR CONFIGURACOES
// =====================================

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
