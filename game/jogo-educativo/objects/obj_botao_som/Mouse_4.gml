
slider_aberto = !slider_aberto;

if (slider_aberto) {

    var _botao = sprite_index;
    var _barra = spr_slider_barra;

    // Centro horizontal do botão
    var _centro_x = x + (
        (sprite_get_bbox_left(_botao) +
         sprite_get_bbox_right(_botao)) / 2
        - sprite_get_xoffset(_botao)
    ) * image_xscale;

    // Borda superior do botão
    var _topo_y = y + (
        sprite_get_bbox_top(_botao)
        - sprite_get_yoffset(_botao)
    ) * image_yscale;

    // Espaço proporcional à altura do botão
    var _altura = (
        sprite_get_bbox_bottom(_botao)
        - sprite_get_bbox_top(_botao)
    ) * image_yscale;

    var _espaco = _altura * 0.13;

    // Centro horizontal relativo da barra
    var _barra_centro_x = (
        (sprite_get_bbox_left(_barra) +
         sprite_get_bbox_right(_barra)) / 2
        - sprite_get_xoffset(_barra)
    );

    // Borda inferior relativa da barra
    var _barra_base_y = (
        sprite_get_bbox_bottom(_barra)
        - sprite_get_yoffset(_barra)
    );

    // Coordenadas finais
    var _slider_x = _centro_x - _barra_centro_x;
    var _slider_y = _topo_y - _espaco - _barra_base_y;

    meu_slider = instance_create_layer(
        _slider_x, _slider_y,
        "Instances", obj_slider_som
    );

    meu_slider.depth = depth - 1;

} else {

    if (instance_exists(meu_slider)) {
        instance_destroy(meu_slider);
    }
}
