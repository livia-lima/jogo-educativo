if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, 10, 10, 80, 80)) {
        room_goto(rm_start_screen);
    }
}