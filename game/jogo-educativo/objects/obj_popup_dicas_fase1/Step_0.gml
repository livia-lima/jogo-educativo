
/// obj_popup_dicas_fase1 - STEP

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// Dimensoes do popup
var _w = _gw * 0.78;
var _h = _gh * 0.75;

var _px = (_gw - _w) / 2;
var _py = (_gh - _h) / 2;

// Botao X no canto superior esquerdo
var _x1 = _px + 12;
var _y1 = _py + 10;
var _x2 = _x1 + 38;
var _y2 = _y1 + 38;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (
    keyboard_check_pressed(vk_escape)
    || (
        mouse_check_button_pressed(mb_left)
        && point_in_rectangle(
            _mx, _my,
            _x1, _y1,
            _x2, _y2
        )
    )
) {
    instance_destroy();
}
