
/// obj_controlador_frase1 - STEP
/// Abre o popup ao clicar no botao Dicas.

if (
    !instance_exists(obj_popup_dicas_fase1)
    && mouse_check_button_pressed(mb_left)
) {

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _gw = display_get_gui_width();
    var _gh = display_get_gui_height();

    // Regiao da lampada no HUD
    if (point_in_rectangle(
        _mx, _my,
        _gw * 0.87,
        _gh * 0.01,
        _gw * 0.97,
        _gh * 0.18
    )) {

        instance_create_layer(
            0, 0,
            "Instances",
            obj_popup_dicas_fase1
        );
    }
}
