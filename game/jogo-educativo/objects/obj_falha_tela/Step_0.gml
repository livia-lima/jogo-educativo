if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, bx - bw/2, b1y - bh/2, bx + bw/2, b1y + bh/2)) {
        room_goto(destino_tentar);
    }
    if (point_in_rectangle(mouse_x, mouse_y, bx - bw/2, b2y - bh/2, bx + bw/2, b2y + bh/2)) {
        room_goto(rm_start_screen);
    }
}