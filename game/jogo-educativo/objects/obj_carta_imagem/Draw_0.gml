
/// obj_carta_imagem - DRAW
/// Destaque verde no acerto e vermelho no erro.

if (associada && acerto_frames <= 0) {
    exit;
}

if (sprite_item != -1) {

    // =================================
    // 1. AREA DO SPRITE
    // =================================

    var _esquerda = sprite_get_bbox_left(sprite_item);
    var _direita = sprite_get_bbox_right(sprite_item);
    var _topo = sprite_get_bbox_top(sprite_item);
    var _baixo = sprite_get_bbox_bottom(sprite_item);

    var _largura = max(
        1,
        _direita - _esquerda + 1
    );

    var _altura = max(
        1,
        _baixo - _topo + 1
    );

    var _limite_w = room_width * 0.28;
    var _limite_h = room_height * 0.12;

    var _escala = min(
        _limite_w / _largura,
        _limite_h / _altura
    );

    var _centro_x = (_esquerda + _direita) / 2;
    var _centro_y = (_topo + _baixo) / 2;

    var _origem_x = sprite_get_xoffset(sprite_item);
    var _origem_y = sprite_get_yoffset(sprite_item);

    var _desenho_x =
        x + (_origem_x - _centro_x) * _escala;

    var _desenho_y =
        y + (_origem_y - _centro_y) * _escala;

    // =================================
    // 2. DESTAQUE VISUAL
    // =================================

    var _mostrar_feedback =
        acerto_frames > 0 || erro_frames > 0;

    if (_mostrar_feedback) {

        var _cor = make_color_rgb(45, 170, 105);

        if (erro_frames > 0) {
            _cor = make_color_rgb(220, 80, 90);
        }

        var _meia_w = room_width * 0.11;
        var _meia_h = room_height * 0.075;

        // Fundo transparente
        draw_set_color(_cor);
        draw_set_alpha(0.20);

        draw_roundrect(
            x - _meia_w,
            y - _meia_h,
            x + _meia_w,
            y + _meia_h,
            false
        );

        // Contorno colorido
        draw_set_alpha(1);

        draw_roundrect(
            x - _meia_w,
            y - _meia_h,
            x + _meia_w,
            y + _meia_h,
            true
        );
    }

    // =================================
    // 3. DESENHAR IMAGEM
    // =================================

    draw_set_color(c_white);
    draw_set_alpha(1);

    draw_sprite_ext(
        sprite_item,
        0,
        _desenho_x,
        _desenho_y,
        _escala,
        _escala,
        0,
        c_white,
        1
    );
}
