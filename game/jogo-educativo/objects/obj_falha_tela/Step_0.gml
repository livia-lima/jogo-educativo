// Título "Que Pena! Não foi dessa vez..."
var _t = point_in_rectangle(mouse_x, mouse_y, bx - 450, 100, bx + 450, 235);
if (_t && !hover_titulo) falar("naofoidessavez");
hover_titulo = _t;

// Botão "Tentar de novo"
var _b1 = point_in_rectangle(mouse_x, mouse_y, bx - bw/2, b1y - bh/2, bx + bw/2, b1y + bh/2);
if (_b1 && !hover_b1) falar("tentardenovo");
hover_b1 = _b1;

// Botão "Voltar ao menu"
var _b2 = point_in_rectangle(mouse_x, mouse_y, bx - bw/2, b2y - bh/2, bx + bw/2, b2y + bh/2);
if (_b2 && !hover_b2) falar("voltaraomenu");
hover_b2 = _b2;

if (mouse_check_button_pressed(mb_left)) {
    if (_b1) room_goto(destino_tentar);
    if (_b2) room_goto(rm_start_screen);
}
